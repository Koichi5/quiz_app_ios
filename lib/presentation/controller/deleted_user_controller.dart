import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/repository/deleted_user_repository.dart';
import 'package:quiz_app/general/custom_exception.dart';

final deletedUserExceptionProvider =
    StateProvider<CustomException?>((_) => null);

final deletedUserQuestionCountProvider = StateProvider((ref) => 0);

final deletedUserControllerProvider = StateNotifierProvider((ref) {
  return DeletedUserController(ref);
});

class DeletedUserController extends StateNotifier {
  final Ref ref;
  late final DeletedUserRepository _deletedUserRepository;

  DeletedUserController(this.ref) : super(const AsyncValue.data(null)) {
    _deletedUserRepository = ref.watch(deletedUserRepositoryProvider);
  }

  Future<void> deleteUser() async {
    try {
      await _deletedUserRepository.deleteUser();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
