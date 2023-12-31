// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deleted_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DeletedUser _$DeletedUserFromJson(Map<String, dynamic> json) {
  return _DeletedUser.fromJson(json);
}

/// @nodoc
mixin _$DeletedUser {
  String? get id => throw _privateConstructorUsedError;
  String get deletedUserUid => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeletedUserCopyWith<DeletedUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeletedUserCopyWith<$Res> {
  factory $DeletedUserCopyWith(
          DeletedUser value, $Res Function(DeletedUser) then) =
      _$DeletedUserCopyWithImpl<$Res, DeletedUser>;
  @useResult
  $Res call({String? id, String deletedUserUid, DateTime createdAt});
}

/// @nodoc
class _$DeletedUserCopyWithImpl<$Res, $Val extends DeletedUser>
    implements $DeletedUserCopyWith<$Res> {
  _$DeletedUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? deletedUserUid = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      deletedUserUid: null == deletedUserUid
          ? _value.deletedUserUid
          : deletedUserUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DeletedUserCopyWith<$Res>
    implements $DeletedUserCopyWith<$Res> {
  factory _$$_DeletedUserCopyWith(
          _$_DeletedUser value, $Res Function(_$_DeletedUser) then) =
      __$$_DeletedUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String deletedUserUid, DateTime createdAt});
}

/// @nodoc
class __$$_DeletedUserCopyWithImpl<$Res>
    extends _$DeletedUserCopyWithImpl<$Res, _$_DeletedUser>
    implements _$$_DeletedUserCopyWith<$Res> {
  __$$_DeletedUserCopyWithImpl(
      _$_DeletedUser _value, $Res Function(_$_DeletedUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? deletedUserUid = null,
    Object? createdAt = null,
  }) {
    return _then(_$_DeletedUser(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      deletedUserUid: null == deletedUserUid
          ? _value.deletedUserUid
          : deletedUserUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DeletedUser extends _DeletedUser {
  const _$_DeletedUser(
      {this.id, required this.deletedUserUid, required this.createdAt})
      : super._();

  factory _$_DeletedUser.fromJson(Map<String, dynamic> json) =>
      _$$_DeletedUserFromJson(json);

  @override
  final String? id;
  @override
  final String deletedUserUid;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'DeletedUser(id: $id, deletedUserUid: $deletedUserUid, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeletedUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deletedUserUid, deletedUserUid) ||
                other.deletedUserUid == deletedUserUid) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, deletedUserUid, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeletedUserCopyWith<_$_DeletedUser> get copyWith =>
      __$$_DeletedUserCopyWithImpl<_$_DeletedUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DeletedUserToJson(
      this,
    );
  }
}

abstract class _DeletedUser extends DeletedUser {
  const factory _DeletedUser(
      {final String? id,
      required final String deletedUserUid,
      required final DateTime createdAt}) = _$_DeletedUser;
  const _DeletedUser._() : super._();

  factory _DeletedUser.fromJson(Map<String, dynamic> json) =
      _$_DeletedUser.fromJson;

  @override
  String? get id;
  @override
  String get deletedUserUid;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_DeletedUserCopyWith<_$_DeletedUser> get copyWith =>
      throw _privateConstructorUsedError;
}
