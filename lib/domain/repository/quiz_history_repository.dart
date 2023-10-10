import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/quiz_history/quiz_history.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/general/general_provider.dart';

final userCompletedCategoryListProvider = StateProvider((ref) => []);

abstract class BaseQuizHistoryRepository {
  Future<String> addQuizHistory(
      {required User user, required QuizHistory quizHistory});
  Future<List<QuizHistory>> retrieveQuizHistoryList();
  Future<List<String>> retrieveUserCompletedCategoryNameList();
}

final quizHistoryRepositoryProvider =
    Provider<QuizHistoryRepository>((ref) => QuizHistoryRepository(ref));

class QuizHistoryRepository implements BaseQuizHistoryRepository {
  final Ref ref;

  QuizHistoryRepository(this.ref);

  CollectionReference _userQuizHistoryCollection(String userId) => ref
      .watch(firebaseFirestoreProvider)
      .collection("user")
      .doc(userId)
      .collection("quizHistory");

  @override
  Future<String> addQuizHistory(
      {required User user, required QuizHistory quizHistory}) async {
    try {
      final quizHistoryRef = _userQuizHistoryCollection(user.uid);
      final quizHistoryDocRef = quizHistoryRef.doc().id;

      final questionList = quizHistory.questionList
          .map((question) => question.copyWith(options: []).toDocument())
          .toList();

      await quizHistoryRef.doc(quizHistoryDocRef).set({
        ...quizHistory.copyWith(id: quizHistoryDocRef).toDocument(),
        "questionList": questionList,
      });

      return quizHistoryDocRef;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<List<String?>> retrieveUserCompletedCategoryList() async {
    final User? currentUser = ref.watch(firebaseAuthProvider).currentUser;
    try {
      final snap = ref
          .watch(firebaseFirestoreProvider)
          .collection("user")
          .doc(currentUser!.uid)
          .get();
      return snap.then(
          (value) => value.data()!.values.map((e) => e.toString()).toList());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<QuizHistory>> retrieveQuizHistoryList() async {
    final User? currentUser = ref.watch(firebaseAuthProvider).currentUser;
    const int quizHistoryLimitCount = 10;
    try {
      final snap = await _userQuizHistoryCollection(currentUser!.uid)
          .orderBy("quizDate", descending: true)
          .limit(quizHistoryLimitCount)
          .get();
      return snap.docs.map((doc) => QuizHistory.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<String>> retrieveUserCompletedCategoryNameList() async {
    final User? currentUser = ref.watch(firebaseAuthProvider).currentUser;
    try {
      final snap = await ref
          .watch(firebaseFirestoreProvider)
          .collection("user")
          .doc(currentUser!.uid)
          .get();
      return snap.data()!.values.map((e) => e.toString()).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
