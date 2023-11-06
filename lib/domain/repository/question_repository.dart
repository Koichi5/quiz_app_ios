import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/domain/quiz/quiz.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/general/general_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_repository.g.dart';

abstract class BaseQuestionRepository {
  Future<Question> addQuestion(
      {required Quiz quiz, required Question question});
  Future<List<Question>> retrieveQuestionList({required Quiz quiz});
  Future<List<Question>> retrieveLocalQuestionList({required Quiz quiz});
}

// final questionRepositoryProvider =
//     Provider<QuestionRepository>((ref) => QuestionRepository(ref));

@Riverpod(keepAlive: true, dependencies: [firebaseFirestore])
class QuestionRepository extends _$QuestionRepository {
  @override
  QuestionRepository build() => QuestionRepository();

  CollectionReference _questionsCollection(Quiz quiz) => ref
      .watch(firebaseFirestoreProvider)
      .collection("category")
      .doc(quiz.categoryDocRef)
      .collection("quiz")
      .doc(quiz.quizDocRef)
      .collection("questions");

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

  Future<List<Question>> retrieveQuestionList({required Quiz quiz}) async {
    try {
      return await retrieveQuery(quiz: quiz).then((ref) async => await ref
          .get()
          .then((value) async => await retrieveLocalQuestionList(quiz: quiz)));
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<List<Question>> retrieveLocalQuestionList({required Quiz quiz}) async {
    final snap = await _questionsCollection(quiz)
        .get(const GetOptions(source: Source.cache));
    return snap.docs.map((doc) => Question.fromDocument(doc)).toList();
  }

  Future<Query<Question>> retrieveQuery({required Quiz quiz}) async {
    DocumentSnapshot? lastDocRef;
    await _questionsCollection(quiz)
        .get(const GetOptions(source: Source.cache))
        .then((value) {
      if (value.docs.isNotEmpty) lastDocRef = value.docs.last;
    });

    Query<Question> ref = _questionsCollection(quiz).withConverter(
        fromFirestore: (snapshot, _) => Question.fromJson(snapshot.data()!),
        toFirestore: (data, _) => data.toJson());
    if (lastDocRef != null) {
      ref = ref.startAtDocument(lastDocRef!);
    }
    return ref;
  }
}
