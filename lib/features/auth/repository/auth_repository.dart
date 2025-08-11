import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillowtalk/utils/constant/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import 'package:pillowtalk/common/services/dio_service.dart';
import 'package:pillowtalk/features/auth/model/auth_request/auth_request_model.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final api = ref.watch(networkServiceProvider);
  return AuthRepository(api);
}

class AuthRepository {
  final Dio api;

  AuthRepository(this.api);

  Future<dynamic> sendOtp(String phone) async {
    final request = SendOtpRequest(phoneNumber: phone);
    //plannign to move all the endpoint in single file
    final response = await api.post(
      ApiEndpoints.sendOtp,
      data: request.toJson(),
    );
    return response.data;
  }
}
