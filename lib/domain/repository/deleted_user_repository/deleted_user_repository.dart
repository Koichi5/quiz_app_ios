import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/domain/deleted_user/deleted_user.dart';
import 'package:quiz_app/domain/repository/auth_repository/auth_repository.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/general/general_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deleted_user_repository.g.dart';

@riverpod
class DeletedUserRepository extends _$DeletedUserRepository {
  @override
  DeletedUserRepository build() => this;

  Future<void> deleteUser() async {
    final currentUser = ref.watch(authRepositoryProvider).getCurrentUser();
    try {
      final deletedUserRef = ref
          .watch(firebaseFirestoreProvider)
          .collection("deleted_users")
          .doc(currentUser!.uid);
      deletedUserRef.set(DeletedUser(
        deletedUserUid: currentUser.uid,
        createdAt: DateTime.now(),
      ).toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
