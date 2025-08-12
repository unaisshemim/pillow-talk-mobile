// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  phoneNumber: json['phoneNumber'] as String,
  name: json['name'] as String?,
  age: (json['age'] as num?)?.toInt(),
  gender: json['gender'] as String?,
  email: json['email'] as String?,
  role: json['role'] as String,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'email': instance.email,
      'role': instance.role,
    };
