// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) =>
    _ProfileModel(
      id: json['id'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      role: json['role'] as String?,
      name: json['name'] as String?,
      age: (json['age'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$ProfileModelToJson(_ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'role': instance.role,
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'email': instance.email,
    };

_ProfileUpdateRequest _$ProfileUpdateRequestFromJson(
  Map<String, dynamic> json,
) => _ProfileUpdateRequest(
  name: json['name'] as String,
  age: (json['age'] as num).toInt(),
  gender: json['gender'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$ProfileUpdateRequestToJson(
  _ProfileUpdateRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'age': instance.age,
  'gender': instance.gender,
  'email': instance.email,
};
