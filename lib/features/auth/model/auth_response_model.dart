import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response_model.freezed.dart';
part 'auth_response_model.g.dart';

@freezed
abstract class SendOtpResponse with _$SendOtpResponse {
  const factory SendOtpResponse({
    required String requestId, // your backend/Firebase session id
    required String maskedNumber, // e.g. +91 ******1234
    @Default(30) int retryAfter, // seconds to enable "Resend"
  }) = _SendOtpResponse;

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$SendOtpResponseFromJson(json);
}
