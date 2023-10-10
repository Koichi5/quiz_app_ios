import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/category/category.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/domain/quiz/quiz.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/general/general_provider.dart';

abstract class BaseQuizRepository {
  Future<Quiz> addQuiz({required Category category, required Quiz quiz});
  Future<List<Quiz>> retrieveQuiz({required Category category});
}

final quizRepositoryProvider =
    Provider<QuizRepository>((ref) => QuizRepository(ref));

class QuizRepository implements BaseQuizRepository {
  final Ref ref;

  QuizRepository(this.ref);

  CollectionReference _quizCollection(String categoryDocRef) => ref
      .watch(firebaseFirestoreProvider)
      .collection("category")
      .doc(categoryDocRef)
      .collection("quiz");

  @override
  Future<Quiz> addQuiz({required Category category, required Quiz quiz}) async {
    try {
      final quizRef = _quizCollection(category.categoryDocRef!);

      final emptyQuestion = await quizRef
          .doc(category.quizDocRef)
          .collection("questions")
          .add(Question.empty().toDocument());

      final quizWithDocRef = quiz.copyWith(
        categoryDocRef: category.categoryDocRef,
        quizDocRef: category.quizDocRef,
        questionDocRef: emptyQuestion.id,
        categoryId: category.categoryId,
      );

      await quizRef.doc(category.quizDocRef).update(quizWithDocRef.toDocument());
      return quizWithDocRef;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<Quiz>> retrieveQuiz({required Category category}) async {
    try {
      final snap = await _quizCollection(category.categoryDocRef!).get();
      return snap.docs.map((doc) => Quiz.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
