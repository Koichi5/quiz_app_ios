import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/option/option.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/domain/quiz/quiz.dart';
import 'package:quiz_app/domain/repository/question_repository.dart';
import 'package:quiz_app/general/general_provider.dart';

void main() {
  group('QuestionRepository', () {
    ProviderContainer? container;
    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      container = ProviderContainer(overrides: [
        firebaseFirestoreProvider.overrideWithValue(FakeFirebaseFirestore())
      ]);
    });

    test('addQuestion', () async {
      const categoryDocRef = 'categoryDocRef';
      const quizDocRef = 'quizDocRef';
      const quiz = Quiz(
        categoryId: 1,
        title: 'quiz title',
        description: 'quiz description',
        questionsShuffled: false,
        categoryDocRef: categoryDocRef,
        questionDocRef: quizDocRef,
        questions: [],
      );
      const question = Question(
        text: 'question text',
        duration: 15,
        optionsShuffled: false,
        options: [
          Option(text: 'option1 text', isCorrect: true, isSelected: false),
          Option(text: 'option2 text', isCorrect: false, isSelected: false),
          Option(text: 'option3 text', isCorrect: false, isSelected: false),
          Option(text: 'option4 text', isCorrect: false, isSelected: false),
        ],
      );

      await container!.read(questionRepositoryProvider).addQuestion(
            quiz: quiz,
            question: question,
          );

      final questionList = await container!
          .read(questionRepositoryProvider)
          .retrieveQuestionList(quiz: quiz);

      expect(questionList.length, equals(1));
      expect(questionList.first.text, equals('question text'));
      expect(questionList.first.duration, equals(15));
      expect(questionList.first.optionsShuffled, equals(false));
    });
  });
}
