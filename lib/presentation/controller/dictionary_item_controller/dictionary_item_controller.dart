import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/domain/dictionary_item/dictionary_item.dart';
import 'package:quiz_app/domain/repository/dictionary_item_repository/dictionary_item_repository.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dictionary_item_controller.g.dart';

@Riverpod(keepAlive: true, dependencies: [DictionaryItemRepository])
class DictionaryItemController extends _$DictionaryItemController {
  @override
  Future<List<DictionaryItem>> build() {
    return retrieveDictionaryItemList();
  }

  Future<List<DictionaryItem>> retrieveDictionaryItemList() async {
    try {
      final dictionaryItemList =
          await ref.watch(dictionaryItemRepositoryProvider).retrieveDictionaryItem();
      return dictionaryItemList;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
