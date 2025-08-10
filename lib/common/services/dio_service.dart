import 'package:dio/dio.dart';
import 'package:pillowtalk/utils/interceptor/auth_interceptor.dart';

Dio createDio({required Future<String?> Function() tokenProvider}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://your-api.com', // Optional
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.add(AuthInterceptor(tokenProvider: tokenProvider));
  return dio;
}
