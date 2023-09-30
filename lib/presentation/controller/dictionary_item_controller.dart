import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/dictionary_item/dictionary_item.dart';
import 'package:quiz_app/domain/repository/dictionary_item_repository.dart';

import '../../general/custom_exception.dart';
import 'auth_controller.dart';

final dictionaryItemExceptionProvider = StateProvider<CustomException?>((_) => null);

final dictionaryItemControllerProvider = StateNotifierProvider
    .autoDispose<DictionaryItemController, AsyncValue<List<DictionaryItem>>>(
        (ref) {
      final user = ref.watch(authControllerProvider);
      return DictionaryItemController(ref, user?.uid);
    });

class DictionaryItemController extends StateNotifier<AsyncValue<List<DictionaryItem>>> {
  final Ref ref;
  final String? _userId;

  DictionaryItemController(this.ref, this._userId)
      : super(const AsyncValue.loading()) {
    if (_userId != null) {
      retrieveDictionaryItemList();
    }
  }

  Future<void> retrieveDictionaryItemList() async {
    try {
      final dictionaryItemList = await ref.watch(dictionaryItemRepositoryProvider)
          .retrieveDictionaryItem();
      if (mounted) {
        state = AsyncValue.data(dictionaryItemList);
      }
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}