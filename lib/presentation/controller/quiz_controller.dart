import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/category/category.dart';
import 'package:quiz_app/domain/quiz/quiz.dart';
import 'package:quiz_app/domain/repository/quiz_repository.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/presentation/controller/auth_controller.dart';

const defaultImagePath = "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png";

final quizExceptionProvider = StateProvider<CustomException?>((_) => null);

final quizControllerProvider = StateNotifierProvider.family
    .autoDispose<QuizController, AsyncValue<List<Quiz>>, Category>(
        (ref, category) {
  final user = ref.watch(authControllerProvider);
  return QuizController(ref, user?.uid, category);
});

class QuizController extends StateNotifier<AsyncValue<List<Quiz>>> {
  final Ref ref;
  final String? _userId;
  final Category category;

  QuizController(this.ref, this._userId, this.category)
      : super(const AsyncValue.loading()) {
    if (_userId != null) {
      retrieveQuiz();
    }
  }

  Future<List<Quiz>> retrieveQuiz() async {
    try {
      final quizList = await ref.watch(quizRepositoryProvider)
          .retrieveQuizList(category: category);
      if (mounted) {
        state = AsyncValue.data(quizList);
      }
      return quizList;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<Quiz> addQuiz({
    String? id,
    required String title,
    required String description,
    required bool questionsShuffled,
    String? imagePath,
    required int categoryId,
  }) async {
    final quiz = Quiz(
        id: id,
        title: title,
        description: description,
        questionsShuffled: questionsShuffled,
        imagePath: imagePath ?? defaultImagePath,
        categoryId: categoryId,
        questions: []);
    final quizWithDocRef = await ref.watch(quizRepositoryProvider)
        .addQuiz(category: category, quiz: quiz);
    state.whenData((quizList) =>
        state = AsyncValue.data(quizList..add(quiz.copyWith(id: quizWithDocRef.quizDocRef))));
    return quizWithDocRef;
  }
}