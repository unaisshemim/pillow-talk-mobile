import 'dart:developer';
import 'package:pillowtalk/features/profile/model/profile_model.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pillowtalk/common/providers/hive_provider.dart';
import 'package:pillowtalk/common/services/result.dart';
import 'package:pillowtalk/features/profile/repository/profile_repository.dart';

part 'profile_provider.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  ProfileRepository get _repo => ref.read(profileRepositoryProvider);

  @override
  Future<ProfileModel?> build() async => null;

  Future<bool> setupProfile({required ProfileModel profile}) async {
    state = const AsyncLoading();
    try {
      final result = await _repo.setupUserProfile(profile: profile);

      switch (result) {
        case Success(value: final profile):
          log('Profile setup successful: $profile');

          // Store profile completion status
          final hiveService = ref.read(hiveServiceProvider);
          await hiveService.put('isProfileCompleted', true);

          // Optionally store user profile data

          await hiveService.put('userProfile', profile);

          state = AsyncData(profile);
          return true;
        case Failure(exception: final error):
          log('Profile setup failed: $error');
          state = AsyncError(error, StackTrace.current);
          return false;
      }
    } catch (e, st) {
      log('Profile setup error: $e');
      state = AsyncError(e, st);
      return false;
    }
  }

  /// Check if user has completed profile setup
  Future<bool> hasCompletedProfile() async {
    try {
      final hiveService = ref.read(hiveServiceProvider);
      final hasCompleted = await hiveService.get('isProfileCompleted');
      return hasCompleted == true;
    } catch (e) {
      log('hasCompletedProfile error: $e');
      return false;
    }
  }

  /// Get stored user profile
  Future<ProfileModel?> getUserProfile() async {
    try {
      final hiveService = ref.read(hiveServiceProvider);
      final profileData = await hiveService.get('userProfile');
      log("Retrieved user profile data: $profileData");
      if (profileData != null) {
        return ProfileModel.fromJson(Map<String, dynamic>.from(profileData));
      }
      return null;
    } catch (e) {
      log('getUserProfile error: $e');
      return null;
    }
  }

  Future<ProfileModel?> updateUserProfile({
    required ProfileUpdateRequest profile,
  }) async {
    try {
      final result = await _repo.updateUserProfile(profile: profile);

      switch (result) {
        case Success(value: final profile):
          log('Profile update successful: $profile.');

          // Store profile completion status
          final hiveService = ref.read(hiveServiceProvider);

          // Optionally store user profile data

          await hiveService.put('userProfile', profile.toJson());

          state = AsyncData(profile);

        case Failure(exception: final error):
          log('Profile update failed: $error');
          state = AsyncError(error, StackTrace.current);
      }
    } catch (e) {
      log('updateUserProfile error: $e');
      return null;
    }
    return null;
  }
}
