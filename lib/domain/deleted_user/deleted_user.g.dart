// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleted_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DeletedUser _$$_DeletedUserFromJson(Map<String, dynamic> json) =>
    _$_DeletedUser(
      id: json['id'] as String?,
      deletedUserUid: json['deletedUserUid'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_DeletedUserToJson(_$_DeletedUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deletedUserUid': instance.deletedUserUid,
      'createdAt': instance.createdAt.toIso8601String(),
    };
