import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deleted_user.freezed.dart';
part 'deleted_user.g.dart';

@freezed
abstract class DeletedUser implements _$DeletedUser {
  const DeletedUser._();

  const factory DeletedUser({
    String? id,
    required String deletedUserUid,
    required DateTime createdAt,
  }) = _DeletedUser;

  factory DeletedUser.empty() =>
      DeletedUser(deletedUserUid: "", createdAt: DateTime.now());

  factory DeletedUser.fromJson(json) => _$DeletedUserFromJson(json);

  factory DeletedUser.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()!;
    return DeletedUser.fromJson(data).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');
}
