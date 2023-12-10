import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/domain/quiz_history/quiz_history.dart';
import 'package:quiz_app/domain/repository/quiz_history_repository/quiz_history_repository.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quiz_history_controller.g.dart';

@riverpod
class QuizHistoryController extends _$QuizHistoryController {
  @override
  Future<List<QuizHistory>> build() {
    return retrieveQuizHistoryList();
  }

  Future<List<QuizHistory>> retrieveQuizHistoryList() async {
    try {
      final quizHistoryList = await ref
          .watch(quizHistoryRepositoryProvider)
          .retrieveQuizHistoryList();
      return quizHistoryList;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<String> addQuizHistory({
    required String userId,
    required String quizDocRef,
    required String categoryDocRef,
    required String quizTitle,
    // required int score,
    // required int questionCount,
    // required int timeTakenMinutes,
    // required int timeTakenSeconds,
    required QuizPerformance performance,
    required DateTime quizDate,
    required String status,
    required List<int> takenQuestions,
    required List<bool> answerIsCorrectList,
    required List<Question> questionList,
  }) async {
    final quizHistory = QuizHistory(
      quizDocRef: quizDocRef,
      categoryDocRef: categoryDocRef,
      quizTitle: quizTitle,
      score: performance.score,
      questionCount: performance.questionCount,
      timeTakenMinutes: performance.timeTakenMinutes,
      timeTakenSeconds: performance.timeTakenSeconds,
      quizDate: quizDate,
      status: status,
      takenQuestions: takenQuestions,
      answerIsCorrectList: answerIsCorrectList,
      questionList: questionList,
    );
    final quizHistoryDocRef = await ref
        .watch(quizHistoryRepositoryProvider)
        .addQuizHistory(quizHistory: quizHistory, userId: userId);
    state.whenData((categoryList) => state = AsyncValue.data(
        categoryList..add(quizHistory.copyWith(id: quizHistoryDocRef))));
    return quizHistoryDocRef;
  }
}

class QuizPerformance {
  final int score;
  final int questionCount;
  final int timeTakenMinutes;
  final int timeTakenSeconds;

  QuizPerformance({
    required this.score,
    required this.questionCount,
    required this.timeTakenMinutes,
    required this.timeTakenSeconds,
  });
}
