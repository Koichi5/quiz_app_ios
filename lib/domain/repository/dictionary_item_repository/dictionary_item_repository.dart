import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/domain/dictionary_item/dictionary_item.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/general/general_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dictionary_item_repository.g.dart';

@riverpod
class DictionaryItemRepository extends _$DictionaryItemRepository {
  @override
  DictionaryItemRepository build() => this;

  CollectionReference get _dictionaryCollection =>
      ref.watch(firebaseFirestoreProvider).collection("dictionary");

  Future addDictionaryItem({
    required List<String> dictionaryWordList,
    required List<String> dictionaryDescriptionList,
    required List<String> dictionaryWordUrlList,
  }) async {
    try {
      final batch = _dictionaryCollection.firestore.batch();
      for (int i = 0; i < dictionaryWordList.length; i++) {
        final docRef = _dictionaryCollection.doc();
        batch.set(docRef, {
          "dictionaryWord": dictionaryWordList[i],
          "dictionaryDescription": dictionaryDescriptionList[i],
          "dictionaryUrl": dictionaryWordUrlList[i],
        });
      }
      await batch.commit();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<List<DictionaryItem>> retrieveDictionaryItem() async {
    try {
      return await retrieveQuery().then((ref) async => await ref
          .get()
          .then((value) async => await retrieveLocalDictionaryItem()));
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<List<DictionaryItem>> retrieveLocalDictionaryItem() async {
    final snap = await _dictionaryCollection
        .orderBy("dictionaryWord")
        .get(const GetOptions(source: Source.cache));
    return snap.docs.map((doc) => DictionaryItem.fromDocument(doc)).toList();
  }

  Future<Query<DictionaryItem>> retrieveQuery() async {
    DocumentSnapshot? lastDocRef;
    await _dictionaryCollection
        .orderBy("dictionaryWord")
        .get(const GetOptions(source: Source.cache))
        .then((value) {
      if (value.docs.isNotEmpty) lastDocRef = value.docs.last;
    });

    Query<DictionaryItem> ref = _dictionaryCollection.withConverter(
      fromFirestore: (snapshot, _) => DictionaryItem.fromJson(snapshot.data()!),
      toFirestore: (data, _) => data.toJson(),
    );
    if (lastDocRef != null) {
      ref = ref.startAtDocument(lastDocRef!);
    }
    return ref;
  }
}
