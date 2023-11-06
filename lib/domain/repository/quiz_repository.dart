import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/domain/category/category.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/domain/quiz/quiz.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/general/general_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quiz_repository.g.dart';

abstract class BaseQuizRepository {
  Future<Quiz> addQuiz({required Category category, required Quiz quiz});
  Future<List<Quiz>> retrieveQuizList({required Category category});
  Future<List<Quiz>> retrieveLocalQuizList({required Category category});
}

// final quizRepositoryProvider =
//     Provider<QuizRepository>((ref) => QuizRepository(ref));

@Riverpod(keepAlive: true, dependencies: [firebaseFirestore])
class QuizRepository extends _$QuizRepository {
  @override
  QuizRepository build() => QuizRepository();

  CollectionReference _quizCollection(String categoryDocRef) => ref
      .watch(firebaseFirestoreProvider)
      .collection("category")
      .doc(categoryDocRef)
      .collection("quiz");

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

      await quizRef
          .doc(category.quizDocRef)
          .update(quizWithDocRef.toDocument());
      return quizWithDocRef;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<List<Quiz>> retrieveQuizList({required Category category}) async {
    try {
      return await retrieveQuery(category: category).then((ref) async =>
          await ref.get().then((value) async =>
              await retrieveLocalQuizList(category: category)));
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<List<Quiz>> retrieveLocalQuizList({required Category category}) async {
    final snap = await _quizCollection(category.categoryDocRef!)
        .get(const GetOptions(source: Source.cache));
    return snap.docs.map((doc) => Quiz.fromDocument(doc)).toList();
  }

  Future<Query<Quiz>> retrieveQuery({required Category category}) async {
    DocumentSnapshot? lastDocRef;
    await _quizCollection(category.categoryDocRef!)
        .get(const GetOptions(source: Source.cache))
        .then((value) {
      if (value.docs.isNotEmpty) lastDocRef = value.docs.last;
    });

    Query<Quiz> ref = _quizCollection(category.categoryDocRef!).withConverter(
        fromFirestore: (snapshot, _) => Quiz.fromJson(snapshot.data()!),
        toFirestore: (data, _) => data.toJson());
    if (lastDocRef != null) {
      ref = ref.startAtDocument(lastDocRef!);
    }
    return ref;
  }
}
