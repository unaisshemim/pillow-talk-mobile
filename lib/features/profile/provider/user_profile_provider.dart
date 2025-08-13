import 'dart:developer';
import 'package:pillowtalk/features/profile/model/user_model.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pillowtalk/common/providers/hive_provider.dart';
import 'package:pillowtalk/features/profile/repository/profile_repository.dart';

part 'user_profile_provider.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  ProfileRepository get _repo => ref.read(profileRepositoryProvider);

  @override
  Future<ProfileModel?> build() async => null;

  Future<bool> setupProfile({
    required String name,
    required int age,
    required String gender,
    required String email,
  }) async {
    state = const AsyncLoading();
    try {
      log(
        "Setting up profile: name=$name, age=$age, gender=$gender, email=$email",
      );

      final response = await _repo.setupUserProfile(
        name: name,
        age: age,
        gender: gender,
        email: email,
      );

      log('Profile setup successful: ${response.toJson()}');

      // Store profile completion status
      final hiveService = ref.read(hiveServiceProvider);
      await hiveService.put('isProfileCompleted', true);

      // Optionally store user profile data
      await hiveService.put('userProfile', response.toJson());

      state = AsyncData(response);
      return true;
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
  Future<UserModel?> getUserProfile() async {
    try {
      final hiveService = ref.read(hiveServiceProvider);
      final profileData = await hiveService.get('userProfile');
      if (profileData != null) {
        return UserModel.fromJson(Map<String, dynamic>.from(profileData));
      }
      return null;
    } catch (e) {
      log('getUserProfile error: $e');
      return null;
    }
  }
}
