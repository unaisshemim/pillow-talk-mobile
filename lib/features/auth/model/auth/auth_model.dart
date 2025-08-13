import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pillowtalk/features/profile/model/user_model.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
sealed class SendOtpRequest with _$SendOtpRequest {
  const factory SendOtpRequest({
    required String phoneNumber, // e.g. +91XXXXXXXXXX
  }) = _SendOtpRequest;

  factory SendOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$SendOtpRequestFromJson(json);
}

@freezed
sealed class VerifyOtpRequest with _$VerifyOtpRequest {
  const factory VerifyOtpRequest({
    required String phoneNumber, // e.g. +91XXXXXXXXXX
    required String otp, // e.g. 123456
  }) = _VerifyOtpRequest;

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);
}

@freezed
sealed class SendOtpResponse with _$SendOtpResponse {
  const factory SendOtpResponse({
    required String message,
    required String accessToken,
    required String refreshToken,
    required bool isNewUser,
    required UserModel user,
  }) = _SendOtpResponse;

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$SendOtpResponseFromJson(json);
}

@freezed
sealed class RefreshTokenResponse with _$RefreshTokenResponse {
  const factory RefreshTokenResponse({
    required String accessToken,
    required String refreshToken,
  }) = _RefreshTokenResponse;

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseFromJson(json);
}
