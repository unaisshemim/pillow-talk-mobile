// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SendOtpResponse _$SendOtpResponseFromJson(Map<String, dynamic> json) =>
    _SendOtpResponse(
      requestId: json['requestId'] as String,
      maskedNumber: json['maskedNumber'] as String,
      retryAfter: (json['retryAfter'] as num?)?.toInt() ?? 30,
    );

Map<String, dynamic> _$SendOtpResponseToJson(_SendOtpResponse instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'maskedNumber': instance.maskedNumber,
      'retryAfter': instance.retryAfter,
    };
