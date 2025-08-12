// lib/common/services/dio_service.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillowtalk/utils/constant/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pillowtalk/utils/interceptor/auth_interceptor.dart';

part 'dio_service.g.dart';

@riverpod
Dio networkService(Ref ref) {
  final options = BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {'accept': '*/*', 'Content-Type': 'application/json'},

    // Optional but nice: sets request body content-type for JSON
  );

  final dio = Dio(options);

  // Get the generated interceptor provider and add it
  final interceptor = ref.read(networkServiceInterceptorProvider);
  dio.interceptors.add(interceptor);

  return dio;
}
