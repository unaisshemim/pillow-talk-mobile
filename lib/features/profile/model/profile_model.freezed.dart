// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileModel {

 String? get id; String? get phoneNumber; String? get role; String? get name; int? get age; String? get gender; String? get email;
/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileModelCopyWith<ProfileModel> get copyWith => _$ProfileModelCopyWithImpl<ProfileModel>(this as ProfileModel, _$identity);

  /// Serializes this ProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.role, role) || other.role == role)&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,phoneNumber,role,name,age,gender,email);

@override
String toString() {
  return 'ProfileModel(id: $id, phoneNumber: $phoneNumber, role: $role, name: $name, age: $age, gender: $gender, email: $email)';
}


}

/// @nodoc
abstract mixin class $ProfileModelCopyWith<$Res>  {
  factory $ProfileModelCopyWith(ProfileModel value, $Res Function(ProfileModel) _then) = _$ProfileModelCopyWithImpl;
@useResult
$Res call({
 String? id, String? phoneNumber, String? role, String? name, int? age, String? gender, String? email
});




}
/// @nodoc
class _$ProfileModelCopyWithImpl<$Res>
    implements $ProfileModelCopyWith<$Res> {
  _$ProfileModelCopyWithImpl(this._self, this._then);

  final ProfileModel _self;
  final $Res Function(ProfileModel) _then;

/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? phoneNumber = freezed,Object? role = freezed,Object? name = freezed,Object? age = freezed,Object? gender = freezed,Object? email = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileModel].
extension ProfileModelPatterns on ProfileModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileModel value)  $default,){
final _that = this;
switch (_that) {
case _ProfileModel():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? phoneNumber,  String? role,  String? name,  int? age,  String? gender,  String? email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
return $default(_that.id,_that.phoneNumber,_that.role,_that.name,_that.age,_that.gender,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? phoneNumber,  String? role,  String? name,  int? age,  String? gender,  String? email)  $default,) {final _that = this;
switch (_that) {
case _ProfileModel():
return $default(_that.id,_that.phoneNumber,_that.role,_that.name,_that.age,_that.gender,_that.email);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? phoneNumber,  String? role,  String? name,  int? age,  String? gender,  String? email)?  $default,) {final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
return $default(_that.id,_that.phoneNumber,_that.role,_that.name,_that.age,_that.gender,_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileModel implements ProfileModel {
  const _ProfileModel({this.id, this.phoneNumber, this.role, this.name, this.age, this.gender, this.email});
  factory _ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);

@override final  String? id;
@override final  String? phoneNumber;
@override final  String? role;
@override final  String? name;
@override final  int? age;
@override final  String? gender;
@override final  String? email;

/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileModelCopyWith<_ProfileModel> get copyWith => __$ProfileModelCopyWithImpl<_ProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.role, role) || other.role == role)&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,phoneNumber,role,name,age,gender,email);

@override
String toString() {
  return 'ProfileModel(id: $id, phoneNumber: $phoneNumber, role: $role, name: $name, age: $age, gender: $gender, email: $email)';
}


}

/// @nodoc
abstract mixin class _$ProfileModelCopyWith<$Res> implements $ProfileModelCopyWith<$Res> {
  factory _$ProfileModelCopyWith(_ProfileModel value, $Res Function(_ProfileModel) _then) = __$ProfileModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? phoneNumber, String? role, String? name, int? age, String? gender, String? email
});




}
/// @nodoc
class __$ProfileModelCopyWithImpl<$Res>
    implements _$ProfileModelCopyWith<$Res> {
  __$ProfileModelCopyWithImpl(this._self, this._then);

  final _ProfileModel _self;
  final $Res Function(_ProfileModel) _then;

/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? phoneNumber = freezed,Object? role = freezed,Object? name = freezed,Object? age = freezed,Object? gender = freezed,Object? email = freezed,}) {
  return _then(_ProfileModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ProfileUpdateRequest {

 String get name; int get age; String get gender; String get email;
/// Create a copy of ProfileUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileUpdateRequestCopyWith<ProfileUpdateRequest> get copyWith => _$ProfileUpdateRequestCopyWithImpl<ProfileUpdateRequest>(this as ProfileUpdateRequest, _$identity);

  /// Serializes this ProfileUpdateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileUpdateRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,age,gender,email);

@override
String toString() {
  return 'ProfileUpdateRequest(name: $name, age: $age, gender: $gender, email: $email)';
}


}

/// @nodoc
abstract mixin class $ProfileUpdateRequestCopyWith<$Res>  {
  factory $ProfileUpdateRequestCopyWith(ProfileUpdateRequest value, $Res Function(ProfileUpdateRequest) _then) = _$ProfileUpdateRequestCopyWithImpl;
@useResult
$Res call({
 String name, int age, String gender, String email
});




}
/// @nodoc
class _$ProfileUpdateRequestCopyWithImpl<$Res>
    implements $ProfileUpdateRequestCopyWith<$Res> {
  _$ProfileUpdateRequestCopyWithImpl(this._self, this._then);

  final ProfileUpdateRequest _self;
  final $Res Function(ProfileUpdateRequest) _then;

/// Create a copy of ProfileUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? age = null,Object? gender = null,Object? email = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileUpdateRequest].
extension ProfileUpdateRequestPatterns on ProfileUpdateRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileUpdateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileUpdateRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileUpdateRequest value)  $default,){
final _that = this;
switch (_that) {
case _ProfileUpdateRequest():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileUpdateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileUpdateRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int age,  String gender,  String email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileUpdateRequest() when $default != null:
return $default(_that.name,_that.age,_that.gender,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int age,  String gender,  String email)  $default,) {final _that = this;
switch (_that) {
case _ProfileUpdateRequest():
return $default(_that.name,_that.age,_that.gender,_that.email);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int age,  String gender,  String email)?  $default,) {final _that = this;
switch (_that) {
case _ProfileUpdateRequest() when $default != null:
return $default(_that.name,_that.age,_that.gender,_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileUpdateRequest implements ProfileUpdateRequest {
  const _ProfileUpdateRequest({required this.name, required this.age, required this.gender, required this.email});
  factory _ProfileUpdateRequest.fromJson(Map<String, dynamic> json) => _$ProfileUpdateRequestFromJson(json);

@override final  String name;
@override final  int age;
@override final  String gender;
@override final  String email;

/// Create a copy of ProfileUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileUpdateRequestCopyWith<_ProfileUpdateRequest> get copyWith => __$ProfileUpdateRequestCopyWithImpl<_ProfileUpdateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileUpdateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileUpdateRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,age,gender,email);

@override
String toString() {
  return 'ProfileUpdateRequest(name: $name, age: $age, gender: $gender, email: $email)';
}


}

/// @nodoc
abstract mixin class _$ProfileUpdateRequestCopyWith<$Res> implements $ProfileUpdateRequestCopyWith<$Res> {
  factory _$ProfileUpdateRequestCopyWith(_ProfileUpdateRequest value, $Res Function(_ProfileUpdateRequest) _then) = __$ProfileUpdateRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, int age, String gender, String email
});




}
/// @nodoc
class __$ProfileUpdateRequestCopyWithImpl<$Res>
    implements _$ProfileUpdateRequestCopyWith<$Res> {
  __$ProfileUpdateRequestCopyWithImpl(this._self, this._then);

  final _ProfileUpdateRequest _self;
  final $Res Function(_ProfileUpdateRequest) _then;

/// Create a copy of ProfileUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? age = null,Object? gender = null,Object? email = null,}) {
  return _then(_ProfileUpdateRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
