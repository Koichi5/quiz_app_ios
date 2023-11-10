import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/domain/repository/original_question_repository/original_question_repository.dart';
import 'package:quiz_app/general/general_provider.dart';

void main() {
  group('OriginalQuestionRepository', () {
    ProviderContainer? container;
    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      container = ProviderContainer(overrides: [
        firebaseFirestoreProvider.overrideWithValue(FakeFirebaseFirestore())
      ]);
    });

    test('addOriginalQuestion', () async {
      const userId = 'userId';
      await container!
          .read(originalQuestionRepositoryProvider)
          .addOriginalQuestion(
              question: const Question(
                  text: 'text',
                  duration: 15,
                  optionsShuffled: false,
                  options: []),
              );
      final snapshot = await container!
          .read(firebaseFirestoreProvider)
          .collection('user')
          .doc(userId)
          .collection('originalQuestion')
          .get();
      final addedQuestion = snapshot.docs.first.data();
      expect(snapshot.docs.length, equals(1));
      expect(addedQuestion['text'], equals('text'));
      expect(addedQuestion['duration'], equals(15));
      expect(addedQuestion['optionsShuffled'], equals(false));
      expect(addedQuestion['options'], equals([]));
    });

    test('retrieveOriginalQuestionList', () async {
      await container!
          .read(originalQuestionRepositoryProvider)
          .addOriginalQuestion(
              question: const Question(
                  text: 'text',
                  duration: 15,
                  optionsShuffled: false,
                  options: []),
              );
      final originalQuestionList = await container!
          .read(originalQuestionRepositoryProvider)
          .retrieveOriginalQuestionList();
      expect(originalQuestionList.length, 1);
      expect(originalQuestionList.first.text, equals('text'));
      expect(originalQuestionList.first.duration, equals(15));
      expect(originalQuestionList.first.optionsShuffled, equals(false));
      expect(originalQuestionList.first.options, equals([]));
    });
  });
}
