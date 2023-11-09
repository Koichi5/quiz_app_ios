import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/domain/category/category.dart';
import 'package:quiz_app/domain/quiz/quiz.dart';
import 'package:quiz_app/domain/repository/quiz_repository/quiz_repository.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quiz_controller.g.dart';

const defaultImagePath =
    "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png";

@Riverpod(keepAlive: true, dependencies: [QuizRepository])
class QuizController extends _$QuizController {
  @override
  Future<List<Quiz>> build({required Category category}) {
    return retrieveQuiz(category:  category);
  }

  Future<List<Quiz>> retrieveQuiz({required Category category}) async {
    try {
      final quizList = await ref
          .watch(quizRepositoryProvider)
          .retrieveQuizList(category: category);
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
    required Category category,
  }) async {
    final quiz = Quiz(
        id: id,
        title: title,
        description: description,
        questionsShuffled: questionsShuffled,
        imagePath: imagePath ?? defaultImagePath,
        categoryId: categoryId,
        questions: []);
    final quizWithDocRef = await ref
        .watch(quizRepositoryProvider)
        .addQuiz(category: category, quiz: quiz);
    state.whenData((quizList) => state = AsyncValue.data(
        quizList..add(quiz.copyWith(id: quizWithDocRef.quizDocRef))));
    return quizWithDocRef;
  }
}
