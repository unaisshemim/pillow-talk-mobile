import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillowtalk/features/auth/provider/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pillowtalk/common/providers/token_provider.dart';

part 'auth_interceptor.g.dart';

class AuthInterceptor extends Interceptor {
  final Future<String?> Function() tokenProvider;
  final Future<bool> Function() refreshAccessToken;

  AuthInterceptor({
    required this.tokenProvider,
    required this.refreshAccessToken,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path.contains('/auth')) {
      options.headers['web-api-key'] = 'your-api-key';
    } else {
      final token = await tokenProvider();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // If unauthorized, try refreshing the token
    if (err.response?.statusCode == 401) {
      final refreshed = await refreshAccessToken();

      if (refreshed) {
        // Get the new token and retry the request
        final newToken = await tokenProvider();
        if (newToken != null && newToken.isNotEmpty) {
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

          try {
            final retryResponse = await Dio().fetch(err.requestOptions);
            return handler.resolve(retryResponse);
          } catch (e) {
            return handler.reject(e as DioException);
          }
        }
      }
    }
    // If refresh fails, forward the error
    handler.next(err);
  }
}

@riverpod
AuthInterceptor networkServiceInterceptor(Ref ref) {
  Future<String?> tokenFn() => ref.read(tokenProvider.future);
  Future<bool> refreshFn() =>
      ref.read(authNotifierProvider.notifier).refreshAccessToken();

  return AuthInterceptor(tokenProvider: tokenFn, refreshAccessToken: refreshFn);
}
