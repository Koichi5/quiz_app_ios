import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/domain/quiz/quiz.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/general/general_provider.dart';

abstract class BaseQuestionRepository {
  Future<Question> addQuestion(
      {required Quiz quiz, required Question question});
  Future<List<Question>> retrieveQuestionList({required Quiz quiz});
}

final questionRepositoryProvider =
    Provider<QuestionRepository>((ref) => QuestionRepository(ref));

class QuestionRepository implements BaseQuestionRepository {
  final Ref ref;

  QuestionRepository(this.ref);

  CollectionReference _questionsCollection(Quiz quiz) => ref
      .watch(firebaseFirestoreProvider)
      .collection("category")
      .doc(quiz.categoryDocRef)
      .collection("quiz")
      .doc(quiz.quizDocRef)
      .collection("questions");

  @override
  Future<Question> addQuestion(
      {required Quiz quiz, required Question question}) async {
    try {
      final questionRef = _questionsCollection(quiz).doc(quiz.questionDocRef);
      final questionWithDocRef =
          question.copyWith(questionDocRef: quiz.questionDocRef);

      await questionRef.set({
        ...questionWithDocRef.toDocument(),
        "options":
            question.options.map((option) => option.toDocument()).toList(),
      });

      return questionWithDocRef;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<Question>> retrieveQuestionList({required Quiz quiz}) async {
    try {
      final snap = await _questionsCollection(quiz).get();
      return snap.docs.map((doc) => Question.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}

abstract class BaseWeakQuestionRepository {
  Future<Question> addWeakQuestion({required Question question});
  Future<List<Question>> retrieveWeakQuestionList();
  Future<void> deleteWeakQuestion({required String weakQuestionDocRef});
}

final weakQuestionRepositoryProvider =
    Provider<WeakQuestionRepository>((ref) => WeakQuestionRepository(ref));

class WeakQuestionRepository implements BaseWeakQuestionRepository {
  final Ref ref;

  WeakQuestionRepository(this.ref);

  CollectionReference _weakQuestionsCollection(String userId) => ref
      .watch(firebaseFirestoreProvider)
      .collection("user")
      .doc(userId)
      .collection("weakQuestion");

  @override
  Future<Question> addWeakQuestion({required Question question}) async {
    try {
      final currentUser = ref.watch(firebaseAuthProvider).currentUser!;
      final questionRef = _weakQuestionsCollection(currentUser.uid)
          .doc(question.questionDocRef);

      await questionRef.set({
        ...question.toDocument(),
        "options":
            question.options.map((option) => option.toDocument()).toList(),
      });

      return question;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<Question>> retrieveWeakQuestionList() async {
    try {
      final currentUser = ref.watch(firebaseAuthProvider).currentUser!;
      final snap = await _weakQuestionsCollection(currentUser.uid).get();
      return snap.docs.map((doc) => Question.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteWeakQuestion({required String weakQuestionDocRef}) async {
    try {
      final currentUser = ref.watch(firebaseAuthProvider).currentUser!;
      await _weakQuestionsCollection(currentUser.uid)
          .doc(weakQuestionDocRef)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
