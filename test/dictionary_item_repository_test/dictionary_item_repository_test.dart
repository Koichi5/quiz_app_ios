import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/repository/dictionary_item_repository.dart';
import 'package:quiz_app/general/general_provider.dart';

void main() {
  group('DictionaryItemRepository', () {
    ProviderContainer? container;
    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      container = ProviderContainer(overrides: [
        firebaseFirestoreProvider.overrideWithValue(FakeFirebaseFirestore())
      ]);
    });

    test('addDictionaryItem', () async {
      await container!.read(dictionaryItemRepositoryProvider).addDictionaryItem(
          dictionaryWordList: [
            'wordA',
            'wordB',
            'wordC'
          ],
          dictionaryDescriptionList: [
            'wordA description',
            'wordB description',
            'wordC description'
          ],
          dictionaryWordUrlList: [
            'https://www.wordA.com',
            'https://www.wordB.com',
            'https://www.wordC.com'
          ]);
      final snapshot = await container!
          .read(firebaseFirestoreProvider)
          .collection('dictionary')
          .get();
      expect(snapshot.docs.length, equals(3));
      expect(snapshot.docs[0].data()['dictionaryWord'], equals('wordA'));
      expect(snapshot.docs[0].data()['dictionaryDescription'],
          equals('wordA description'));
      expect(snapshot.docs[0].data()['dictionaryUrl'],
          equals('https://www.wordA.com'));

      expect(snapshot.docs[1].data()['dictionaryWord'], equals('wordB'));
      expect(snapshot.docs[1].data()['dictionaryDescription'],
          equals('wordB description'));
      expect(snapshot.docs[1].data()['dictionaryUrl'],
          equals('https://www.wordB.com'));

      expect(snapshot.docs[2].data()['dictionaryWord'], equals('wordC'));
      expect(snapshot.docs[2].data()['dictionaryDescription'],
          equals('wordC description'));
      expect(snapshot.docs[2].data()['dictionaryUrl'],
          equals('https://www.wordC.com'));
    });

    test('retrieveDictionaryItem', () async {
      await container!.read(dictionaryItemRepositoryProvider).addDictionaryItem(
          dictionaryWordList: [
            'wordA',
            'wordB',
            'wordC'
          ],
          dictionaryDescriptionList: [
            'wordA description',
            'wordB description',
            'wordC description'
          ],
          dictionaryWordUrlList: [
            'https://www.wordA.com',
            'https://www.wordB.com',
            'https://www.wordC.com'
          ]);

      final doctionaryItemList = await container!
          .read(dictionaryItemRepositoryProvider)
          .retrieveDictionaryItem();
      expect(doctionaryItemList.length, equals(3));
      expect(doctionaryItemList[0].dictionaryWord, equals('wordA'));
      expect(doctionaryItemList[0].dictionaryDescription,
          equals('wordA description'));
      expect(
          doctionaryItemList[0].dictionaryUrl, equals('https://www.wordA.com'));

      expect(doctionaryItemList[1].dictionaryWord, equals('wordB'));
      expect(doctionaryItemList[1].dictionaryDescription,
          equals('wordB description'));
      expect(
          doctionaryItemList[1].dictionaryUrl, equals('https://www.wordB.com'));

      expect(doctionaryItemList[2].dictionaryWord, equals('wordC'));
      expect(doctionaryItemList[2].dictionaryDescription,
          equals('wordC description'));
      expect(
          doctionaryItemList[2].dictionaryUrl, equals('https://www.wordC.com'));
    });
  });
}
