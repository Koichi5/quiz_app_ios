import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/domain/quiz_history/quiz_history.dart';
import 'package:quiz_app/domain/repository/quiz_history_repository.dart';
import 'package:quiz_app/general/general_provider.dart';

void main() {
  group('QuizHistoryRepository', () {
    ProviderContainer? container;
    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      container = ProviderContainer(overrides: [
        firebaseFirestoreProvider.overrideWithValue(FakeFirebaseFirestore())
      ]);
    });

    test('addQuizHistory', () async {
      const userId = 'userId';
      final quizDate = DateTime(2023, 10, 16, 15, 8, 30);
      await container!.read(quizHistoryRepositoryProvider).addQuizHistory(
            userId: userId,
            quizHistory: QuizHistory(
              categoryDocRef: 'categoryDocRef',
              quizDocRef: 'quizDocRef',
              quizTitle: 'quizTitle',
              score: 10,
              questionCount: 15,
              timeTakenMinutes: 1,
              timeTakenSeconds: 30,
              quizDate: quizDate,
              status: 'Completed',
              takenQuestions: [1, 2],
              answerIsCorrectList: [false, true],
              questionList: [
                const Question(
                    text: 'question1 text',
                    duration: 15,
                    optionsShuffled: false,
                    options: []),
                const Question(
                    text: 'question2 text',
                    duration: 15,
                    optionsShuffled: false,
                    options: [])
              ],
            ),
          );
      final snapshot = await container!
          .read(firebaseFirestoreProvider)
          .collection('user')
          .doc(userId)
          .collection('quizHistory')
          .get();
      expect(snapshot.docs.length, equals(1));
      expect(snapshot.docs.first.data()['categoryDocRef'],
          equals('categoryDocRef'));
      expect(snapshot.docs.first.data()['quizDocRef'], equals('quizDocRef'));
      expect(snapshot.docs.first.data()['quizTitle'], equals('quizTitle'));
      expect(snapshot.docs.first.data()['score'], equals(10));
      expect(snapshot.docs.first.data()['questionCount'], equals(15));
      expect(snapshot.docs.first.data()['timeTakenMinutes'], equals(1));
      expect(snapshot.docs.first.data()['timeTakenSeconds'], equals(30));
      expect(snapshot.docs.first.data()['quizDate'], equals(quizDate.toIso8601String()));
      expect(snapshot.docs.first.data()['status'], equals('Completed'));
      expect(snapshot.docs.first.data()['takenQuestions'], equals([1, 2]));
      expect(snapshot.docs.first.data()['answerIsCorrectList'],
          equals([false, true]));
    });
  });
}
