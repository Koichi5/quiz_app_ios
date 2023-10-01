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

  @override
  Future<Question> addQuestion(
      {required Quiz quiz, required Question question}) async {
    try {
      final questionRef = ref.watch(firebaseFirestoreProvider)
          .collection("category")
          .doc(quiz.categoryDocRef)
          .collection("quiz")
          .doc(quiz.quizDocRef)
          .collection("questions");
      final questionWithDocRef = Question(
        id: question.id,
        categoryDocRef: quiz.categoryDocRef,
        quizDocRef: quiz.quizDocRef,
        questionDocRef: quiz.questionDocRef,
        text: question.text,
        duration: question.duration,
        optionsShuffled: question.optionsShuffled,
        options: [],
      );

      await questionRef
          .doc(quiz.questionDocRef)
          .update(questionWithDocRef.toDocument());

      await questionRef.doc(quiz.questionDocRef).update({
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
      final snap = await ref.watch(firebaseFirestoreProvider)
          .collection("category")
          .doc(quiz.categoryDocRef)
          .collection("quiz")
          .doc(quiz.quizDocRef)
          .collection("questions")
          .get();
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

  @override
  Future<Question> addWeakQuestion({required Question question}) async {
    final User? currentUser = ref.watch(firebaseAuthProvider).currentUser;
    try {
      print(question);
      final questionRef = ref.watch(firebaseFirestoreProvider)
          .collection("user")
          .doc(currentUser!.uid)
          .collection("weakQuestion");
      final questionWithDocRef = Question(
        id: question.id,
        categoryDocRef: question.categoryDocRef,
        quizDocRef: question.quizDocRef,
        questionDocRef: question.questionDocRef,
        text: question.text,
        duration: question.duration,
        optionsShuffled: question.optionsShuffled,
        options: [],
      );
      await questionRef
          .doc(question.questionDocRef)
          .set(questionWithDocRef.toDocument());
      await questionRef
          .doc(question.questionDocRef)
          .update(questionWithDocRef.toDocument());
      await questionRef.doc(question.questionDocRef).update({
        "options":
        question.options.map((option) => option.toDocument()).toList(),
      });
      return questionWithDocRef;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<Question>> retrieveWeakQuestionList() async {
    try {
      final User? currentUser = ref.watch(firebaseAuthProvider).currentUser;
      final snap = await ref.watch(firebaseFirestoreProvider)
          .collection("user")
          .doc(currentUser!.uid)
          .collection("weakQuestion")
          .get();
      return snap.docs.map((doc) => Question.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteWeakQuestion({required String weakQuestionDocRef}) async {
    final User? currentUser = ref.watch(firebaseAuthProvider).currentUser;
    try {
      await ref.watch(firebaseFirestoreProvider)
          .collection('user')
          .doc(currentUser!.uid)
          .collection("weakQuestion")
          .doc(weakQuestionDocRef)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
