import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillowtalk/utils/constant/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import 'package:pillowtalk/common/services/dio_service.dart';
import 'package:pillowtalk/features/auth/model/auth/auth_model.dart';

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
    log(response.toString());

    return response.data;
  }

  Future<SendOtpResponse> verifyOtp(String phone, String otp) async {
    final request = VerifyOtpRequest(phoneNumber: phone, otp: otp);
    final response = await api.post(
      ApiEndpoints.verifyOtp,
      data: request.toJson(),
    );
    log(response.toString());

    return SendOtpResponse.fromJson(response.data);
  }
}
