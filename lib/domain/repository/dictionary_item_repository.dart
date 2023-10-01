import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/dictionary_item/dictionary_item.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/general/general_provider.dart';

abstract class BaseDictionaryItemRepository {
  Future addDictionaryItem({
      required List<String> dictionaryWordList,
      required List<String> dictionaryDescriptionList,
      required List<String> dictionaryWordUrlList});
  Future<List<DictionaryItem>> retrieveDictionaryItem();
}

final dictionaryItemRepositoryProvider = Provider<DictionaryItemRepository>(
    (ref) => DictionaryItemRepository(ref));

class DictionaryItemRepository implements BaseDictionaryItemRepository {
  final Ref ref;

  DictionaryItemRepository(this.ref);

  @override
  Future addDictionaryItem({
    required List<String> dictionaryWordList,
    required List<String> dictionaryDescriptionList,
    required List<String> dictionaryWordUrlList,
  }) async {
    try {
      for (int i = 0; i < dictionaryWordList.length; i++) {
        await ref.watch(firebaseFirestoreProvider).collection("dictionary").add({
          "dictionaryWord": dictionaryWordList[i],
          "dictionaryDescription": dictionaryDescriptionList[i],
          "dictionaryUrl": dictionaryWordUrlList[i],
        });
      }
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<DictionaryItem>> retrieveDictionaryItem() async {
    try {
      final snap =
          await ref.watch(firebaseFirestoreProvider).collection("dictionary").orderBy("dictionaryWord").get();
      return snap.docs.map((doc) => DictionaryItem.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
