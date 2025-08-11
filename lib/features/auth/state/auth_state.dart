import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.otpSent() = _OtpSent;
  const factory AuthState.verified() = _Verified;
  const factory AuthState.error(String message) = _Error;
}
