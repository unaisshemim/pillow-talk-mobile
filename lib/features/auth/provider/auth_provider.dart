import 'dart:developer';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pillowtalk/features/auth/repository/auth_repository.dart';
import 'package:pillowtalk/features/auth/state/auth_state.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  // Lazily grab the repo once. Using read so this notifier doesn't rebuild if repo changes.
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  @override
  AuthState build() => const AuthState.initial();

  Future<void> sendOtp(String phone) async {
    state = const AuthState.loading();
    try {
      log("hi");
      final res = await _repo.sendOtp(phone);
      log("res $res");
      state = const AuthState.otpSent();
    } catch (e) {
      log("e: $e");
      state = AuthState.error(e.toString());
    }
  }

  // Future<void> verifyOtp(String phone, String code) async {
  //   state = const AuthState.loading();
  //   try {
  //     final res = await _repo.verifyOtp(phone, code);
  //     state = const AuthState.authenticated(); // example
  //   } catch (e, st) {
  //     state = AuthState.error(e.toString());
  //   }
  // }
}
