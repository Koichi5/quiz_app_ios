import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/domain/repository/deleted_user_repository/deleted_user_repository.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deleted_user_controller.g.dart';

@Riverpod(keepAlive: true, dependencies: [DeletedUserRepository])
class DeletedUserController extends _$DeletedUserController {
  @override
  DeletedUserController build() => this;

    Future<void> deleteUser() async {
    try {
      await ref.watch(deletedUserRepositoryProvider).deleteUser();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
