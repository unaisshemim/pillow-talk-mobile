import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pillowtalk/features/profile/model/user_model.dart';
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

  Future<ProfileModel> setupUserProfile({
    required String name,
    required int age,
    required String gender,
    required String email,
  }) async {
    final request = ProfileModel(
      name: name,
      age: age,
      gender: gender,
      email: email,
    );

    final response = await api.post(
      ApiEndpoints.postUserProfile,
      data: request.toJson(),
    );

    log('Profile setup response: ${response.statusMessage}');

    return ProfileModel.fromJson(response.data);
  }
}
