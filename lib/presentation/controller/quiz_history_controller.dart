import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/domain/quiz_history/quiz_history.dart';
import 'package:quiz_app/domain/repository/quiz_history_repository.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/presentation/controller/auth_controller.dart';


final quizHistoryExceptionProvider =
    StateProvider<CustomException?>((_) => null);

final quizHistoryControllerProvider =
    StateNotifierProvider<QuizHistoryController, AsyncValue<List<QuizHistory>>>(
        (ref) {
  final user = ref.watch(authControllerProvider);
  return QuizHistoryController(ref, user?.uid);
});

class QuizHistoryController
    extends StateNotifier<AsyncValue<List<QuizHistory>>> {
  final Ref ref;
  final String? _userId;
  QuizHistoryController(this.ref, this._userId)
      : super(const AsyncValue.loading()) {
    if (_userId != null) {
      retrieveQuizHistoryList();
    }
  }

  Future<List<QuizHistory>> retrieveQuizHistoryList() async {
    try {
      final quizHistoryList = await ref.watch(quizHistoryRepositoryProvider)
          .retrieveQuizHistoryList();
      if (mounted) {
        state = AsyncValue.data(quizHistoryList);
      }
      return quizHistoryList;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<String> addQuizHistory({
    required User user,
    required String quizDocRef,
    required String categoryDocRef,
    required String quizTitle,
    required int score,
    required int questionCount,
    required int timeTakenMinutes,
    required int timeTakenSeconds,
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
      score: score,
      questionCount: questionCount,
      timeTakenMinutes: timeTakenMinutes,
      timeTakenSeconds: timeTakenSeconds,
      quizDate: quizDate,
      status: status,
      takenQuestions: takenQuestions,
      answerIsCorrectList: answerIsCorrectList,
      questionList: questionList,
    );
    final quizHistoryDocRef = await ref.watch(quizHistoryRepositoryProvider)
        .addQuizHistory(quizHistory: quizHistory, user: user);
    state.whenData((categoryList) => state = AsyncValue.data(
        categoryList..add(quizHistory.copyWith(id: quizHistoryDocRef))));
    return quizHistoryDocRef;
  }
}
