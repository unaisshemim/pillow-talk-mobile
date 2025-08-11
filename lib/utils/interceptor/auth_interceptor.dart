import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pillowtalk/common/providers/token_provider.dart';

part 'auth_interceptor.g.dart';

class AuthInterceptor extends Interceptor {
  final Future<String?> Function() tokenProvider;
  AuthInterceptor({required this.tokenProvider});

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
}

@riverpod
AuthInterceptor networkServiceInterceptor(Ref ref) {
  Future<String?> tokenFn() =>
      ref.read(tokenProvider.future); // generated token()
  return AuthInterceptor(tokenProvider: tokenFn);
}
