import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/quiz_history/quiz_history.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/general/general_provider.dart';

final userCompletedCategoryListProvider = StateProvider((ref) => []);

abstract class BaseQuizHistoryRepository {
  Future<String> addQuizHistory(
      {required String userId, required QuizHistory quizHistory});
  Future<List<QuizHistory>> retrieveQuizHistoryList();
  Future<List<QuizHistory>> retrieveLocatQuizHistoryList(
      {required String uid, required int quizHistoryLimitCount});
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
      {required String userId, required QuizHistory quizHistory}) async {
    try {
      final quizHistoryRef = _userQuizHistoryCollection(userId);
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
      return await retrieveQuery(
        uid: currentUser!.uid,
        quizHistoryLimitCount: quizHistoryLimitCount,
      ).then(
        (ref) async => await ref
            .get()
            .then((value) async => await retrieveLocatQuizHistoryList(
                  uid: currentUser.uid,
                  quizHistoryLimitCount: quizHistoryLimitCount,
                )),
      );
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<QuizHistory>> retrieveLocatQuizHistoryList(
      {required String uid, required int quizHistoryLimitCount}) async {
    final snap = await _userQuizHistoryCollection(uid)
        .orderBy("quizDate", descending: true)
        .limit(quizHistoryLimitCount)
        .get(const GetOptions(source: Source.cache));
    return snap.docs.map((doc) => QuizHistory.fromDocument(doc)).toList();
  }

  Future<Query<QuizHistory>> retrieveQuery(
      {required String uid, required int quizHistoryLimitCount}) async {
    DocumentSnapshot? lastDocRef;
    await _userQuizHistoryCollection(uid)
        .orderBy("quizDate", descending: true)
        .limit(quizHistoryLimitCount)
        .get(const GetOptions(source: Source.cache))
        .then((value) {
      if (value.docs.isNotEmpty) lastDocRef = value.docs.last;
    });

    Query<QuizHistory> ref = _userQuizHistoryCollection(uid)
        .limit(quizHistoryLimitCount)
        .withConverter(
          fromFirestore: (snapshot, _) =>
              QuizHistory.fromJson(snapshot.data()!),
          toFirestore: (data, _) => data.toJson(),
        );
    if (lastDocRef != null) {
      ref = ref.startAtDocument(lastDocRef!);
    }
    return ref;
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
