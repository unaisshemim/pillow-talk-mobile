import 'package:dio/dio.dart';
import 'package:pillowtalk/common/providers/hive_provider.dart';
import 'package:pillowtalk/common/services/api_service.dart';
import 'package:pillowtalk/common/services/dio_service.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

//accessing hive
final tokenProvider = Provider<Future<String?>>((ref) async {
  final hive = ref.read(hiveServiceProvider);
  return await hive.get('accessToken');
});
//injecting token int to hive

final dioProvider = Provider<Dio>((ref) {
  tokenFn() => ref.watch(tokenProvider);
  return createDio(tokenProvider: tokenFn);
});

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});
