import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillowtalk/common/services/result.dart';
import 'package:pillowtalk/features/profile/model/profile_model.dart';
import 'package:pillowtalk/utils/constant/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import 'package:pillowtalk/common/services/dio_service.dart';

part 'profile_repository.g.dart';

@riverpod
ProfileRepository profileRepository(Ref ref) {
  final api = ref.watch(networkServiceProvider);
  return ProfileRepository(api);
}

class ProfileRepository {
  final Dio api;

  ProfileRepository(this.api);

  Future<Result<ProfileModel, Exception>> setupUserProfile({
    required ProfileModel profile,
  }) async {
    try {
      log("Setting up user profile: ${profile.toJson()}");
      final response = await api.post(
        ApiEndpoints.postUserProfile,
        data: profile.toJson(),
      );

      return Success(ProfileModel.fromJson(response.data));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Future<Result<ProfileModel, Exception>> updateUserProfile({
    required ProfileUpdateRequest profile,
  }) async {
    try {
      log("Updating user profile: ${profile.toJson()}");
      final response = await api.put(
        ApiEndpoints.updateUserProfile,
        data: profile.toJson(),
      );
      log("profile model updated: ${ProfileModel.fromJson(response.data)}");

      final profileModel = ProfileModel.fromJson(response.data['data']);
      return Success(profileModel);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
