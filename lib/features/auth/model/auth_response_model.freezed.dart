// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SendOtpResponse {

 String get requestId;// your backend/Firebase session id
 String get maskedNumber;// e.g. +91 ******1234
 int get retryAfter;
/// Create a copy of SendOtpResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendOtpResponseCopyWith<SendOtpResponse> get copyWith => _$SendOtpResponseCopyWithImpl<SendOtpResponse>(this as SendOtpResponse, _$identity);

  /// Serializes this SendOtpResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendOtpResponse&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.maskedNumber, maskedNumber) || other.maskedNumber == maskedNumber)&&(identical(other.retryAfter, retryAfter) || other.retryAfter == retryAfter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requestId,maskedNumber,retryAfter);

@override
String toString() {
  return 'SendOtpResponse(requestId: $requestId, maskedNumber: $maskedNumber, retryAfter: $retryAfter)';
}


}

/// @nodoc
abstract mixin class $SendOtpResponseCopyWith<$Res>  {
  factory $SendOtpResponseCopyWith(SendOtpResponse value, $Res Function(SendOtpResponse) _then) = _$SendOtpResponseCopyWithImpl;
@useResult
$Res call({
 String requestId, String maskedNumber, int retryAfter
});




}
/// @nodoc
class _$SendOtpResponseCopyWithImpl<$Res>
    implements $SendOtpResponseCopyWith<$Res> {
  _$SendOtpResponseCopyWithImpl(this._self, this._then);

  final SendOtpResponse _self;
  final $Res Function(SendOtpResponse) _then;

/// Create a copy of SendOtpResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requestId = null,Object? maskedNumber = null,Object? retryAfter = null,}) {
  return _then(_self.copyWith(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,maskedNumber: null == maskedNumber ? _self.maskedNumber : maskedNumber // ignore: cast_nullable_to_non_nullable
as String,retryAfter: null == retryAfter ? _self.retryAfter : retryAfter // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SendOtpResponse].
extension SendOtpResponsePatterns on SendOtpResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendOtpResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendOtpResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendOtpResponse value)  $default,){
final _that = this;
switch (_that) {
case _SendOtpResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendOtpResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SendOtpResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String requestId,  String maskedNumber,  int retryAfter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendOtpResponse() when $default != null:
return $default(_that.requestId,_that.maskedNumber,_that.retryAfter);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String requestId,  String maskedNumber,  int retryAfter)  $default,) {final _that = this;
switch (_that) {
case _SendOtpResponse():
return $default(_that.requestId,_that.maskedNumber,_that.retryAfter);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String requestId,  String maskedNumber,  int retryAfter)?  $default,) {final _that = this;
switch (_that) {
case _SendOtpResponse() when $default != null:
return $default(_that.requestId,_that.maskedNumber,_that.retryAfter);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SendOtpResponse implements SendOtpResponse {
  const _SendOtpResponse({required this.requestId, required this.maskedNumber, this.retryAfter = 30});
  factory _SendOtpResponse.fromJson(Map<String, dynamic> json) => _$SendOtpResponseFromJson(json);

@override final  String requestId;
// your backend/Firebase session id
@override final  String maskedNumber;
// e.g. +91 ******1234
@override@JsonKey() final  int retryAfter;

/// Create a copy of SendOtpResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendOtpResponseCopyWith<_SendOtpResponse> get copyWith => __$SendOtpResponseCopyWithImpl<_SendOtpResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendOtpResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendOtpResponse&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.maskedNumber, maskedNumber) || other.maskedNumber == maskedNumber)&&(identical(other.retryAfter, retryAfter) || other.retryAfter == retryAfter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requestId,maskedNumber,retryAfter);

@override
String toString() {
  return 'SendOtpResponse(requestId: $requestId, maskedNumber: $maskedNumber, retryAfter: $retryAfter)';
}


}

/// @nodoc
abstract mixin class _$SendOtpResponseCopyWith<$Res> implements $SendOtpResponseCopyWith<$Res> {
  factory _$SendOtpResponseCopyWith(_SendOtpResponse value, $Res Function(_SendOtpResponse) _then) = __$SendOtpResponseCopyWithImpl;
@override @useResult
$Res call({
 String requestId, String maskedNumber, int retryAfter
});




}
/// @nodoc
class __$SendOtpResponseCopyWithImpl<$Res>
    implements _$SendOtpResponseCopyWith<$Res> {
  __$SendOtpResponseCopyWithImpl(this._self, this._then);

  final _SendOtpResponse _self;
  final $Res Function(_SendOtpResponse) _then;

/// Create a copy of SendOtpResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requestId = null,Object? maskedNumber = null,Object? retryAfter = null,}) {
  return _then(_SendOtpResponse(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,maskedNumber: null == maskedNumber ? _self.maskedNumber : maskedNumber // ignore: cast_nullable_to_non_nullable
as String,retryAfter: null == retryAfter ? _self.retryAfter : retryAfter // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
