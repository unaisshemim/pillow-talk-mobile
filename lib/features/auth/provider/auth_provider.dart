import 'dart:developer';
import 'package:pillowtalk/features/auth/model/auth/auth_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pillowtalk/common/providers/hive_provider.dart';
import 'package:pillowtalk/features/auth/repository/auth_repository.dart';
part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  // Lazily grab the repo once. Using read so notifier doesn't rebuild if repo changes.
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  // Initial state for the AsyncNotifier: nothing loaded yet.
  @override
  Future<SendOtpResponse?> build() async => null;

  Future<void> sendOtp(String phone) async {
    state = const AsyncLoading();
    try {
      log("phone: $phone");
      final res = await _repo.sendOtp(phone);
      log('sendOtp response: $res');
      // Don't store the response in state, just mark as success
      state = const AsyncData(null);
    } catch (e, st) {
      log('sendOtp error: $e');
      state = AsyncError(e, st);
    } finally {
      state = state;
    }
  }

  Future<bool> verifyOtp(String phone, String otp) async {
    state = const AsyncLoading();
    try {
      log("phone: $phone, otp: $otp");
      final res = await _repo.verifyOtp(phone, otp);

      // Store access token from the response
      final hiveService = ref.read(hiveServiceProvider);
      await hiveService.put('accessToken', res.accessToken);

      // Store refresh token as well
      await hiveService.put('refreshToken', res.refreshToken);

      //store onboarding status
      await hiveService.put('isOnBoardingAlreadyWatched', true);

      state = AsyncData(res); //

      // You can also store user info if needed
      // await hiveService.put('user', res.user.toJson());

      return true;
    } catch (e, st) {
      log('verifyOtp error: $e');
      state = AsyncError(e, st);
      return false;
    }
  }

  /// Check if user is authenticated by checking for valid access token
  Future<bool> isAuthenticated() async {
    try {
      final hiveService = ref.read(hiveServiceProvider);
      final token = await hiveService.get('accessToken');
      return token != null && token.toString().isNotEmpty;
    } catch (e) {
      log('isAuthenticated error: $e');
      return false;
    }
  }

  //check if the user watched onboarding
  Future<bool> hasWatchedOnboarding() async {
    try {
      final hiveService = ref.read(hiveServiceProvider);
      final hasWatched = await hiveService.get('isOnBoardingAlreadyWatched');
      return hasWatched == true;
    } catch (e) {
      log('hasWatchedOnboarding error: $e');
      return false;
    }
  }

  /// Get stored access token
  Future<String?> getAccessToken() async {
    try {
      final hiveService = ref.read(hiveServiceProvider);

      return await hiveService.get('accessToken');
    } catch (e) {
      log('getAccessToken error: $e');
      return null;
    }
  }

  /// Get stored refresh token
  Future<String?> getRefreshToken() async {
    try {
      final hiveService = ref.read(hiveServiceProvider);
      return await hiveService.get('refreshToken') as String;
    } catch (e) {
      log('getRefreshToken error: $e');
      return null;
    }
  }

  /// Logout user by clearing stored tokens
  Future<void> logout() async {
    try {
      final hiveService = ref.read(hiveServiceProvider);
      await hiveService.delete('accessToken');
      await hiveService.delete('refreshToken');
      log('User logged out successfully');
    } catch (e, st) {
      log('logout error: $e');
      state = AsyncError(e, st);
    }
  }

  /// Refresh the access token using refresh token
  Future<bool> refreshAccessToken() async {
    try {
      final refreshToken = await getRefreshToken();

      final response = await _repo.refreshToken(refreshToken!);
      log('response: $response');

      if (response.accessToken.isNotEmpty) {
        final hiveService = ref.read(hiveServiceProvider);
        await hiveService.put('accessToken', response.accessToken);

        if (response.refreshToken.isNotEmpty) {
          await hiveService.put('refreshToken', response.refreshToken);
        }

        log('Token refreshed successfully');
        return true;
      }

      return false;
    } catch (e) {
      log('Token refresh error: $e');
      return false;
    }
  }

  /// Check if user is authenticated with valid token
  Future<bool> isValidTokenAuthenticated() async {
    try {
      final String? token = await getAccessToken();

      if (token == null || token.isEmpty) {}

      // Try to refresh the token preemptively
      final refreshed = await refreshAccessToken();
      log("refresh $refreshed");
      return refreshed;
    } catch (e) {
      log('Token validation error: $e');
      return false;
    }
  }
}
