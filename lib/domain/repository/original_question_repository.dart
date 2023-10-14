import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/general/general_provider.dart';

abstract class BaseOriginalQuestionRepository {
  Future<Question> addOriginalQuestion(
      {required String userId, required Question question});
  Future<List<Question>> retrieveOriginalQuestionList({required String userId});
  Future<List<Question>> retrieveLocalOriginalQuestionList(
      {required String userId});
  Future<void> deleteOriginalQuestion(
      {required String userId, required String originalQuestionDocRef});
}

final originalQuestionRepositoryProvider = Provider<OriginalQuestionRepository>(
    (ref) => OriginalQuestionRepository(ref));

class OriginalQuestionRepository implements BaseOriginalQuestionRepository {
  final Ref ref;

  OriginalQuestionRepository(this.ref);

  CollectionReference _userCollection(String userId) => ref
      .watch(firebaseFirestoreProvider)
      .collection("user")
      .doc(userId)
      .collection("originalQuestion");

  @override
  Future<Question> addOriginalQuestion(
      {required String userId, required Question question}) async {
    try {
      final originalQuestionRef = ref
          .watch(firebaseFirestoreProvider)
          .collection("user")
          .doc(userId)
          .collection("originalQuestion");

      final originalQuestionWithDocRef = Question(
        id: question.id,
        text: question.text,
        originalQuestionDocRef: "",
        duration: question.duration,
        optionsShuffled: question.optionsShuffled,
        options: [],
      );
      // originalQuestionDocRef が正しく記録されるために一度 originalQuestionDocRef を含まない状態で add する
      final originalQuestion = await originalQuestionRef
          .add(originalQuestionWithDocRef.toDocument());
      // add した後にドキュメントIDの取得を行い、 update で反映させる
      final originalQuestionDocRef = originalQuestion.id;

      await originalQuestionRef.doc(originalQuestionDocRef).update({
        "options":
            question.options.map((option) => option.toDocument()).toList(),
        "originalQuestionDocRef": originalQuestionDocRef,
      });
      return originalQuestionWithDocRef;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<Question>> retrieveOriginalQuestionList(
      {required String userId}) async {
    try {
      return await retrieveQuery(userId: userId).then((ref) async => await ref
          .get()
          .then((value) async =>
              await retrieveLocalOriginalQuestionList(userId: userId)));
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<Question>> retrieveLocalOriginalQuestionList(
      {required String userId}) async {
    final snap = await _userCollection(userId)
        .get(const GetOptions(source: Source.cache));
    return snap.docs.map((doc) => Question.fromDocument(doc)).toList();
  }

  Future<Query<Question>> retrieveQuery({required String userId}) async {
    DocumentSnapshot? lastDocRef;
    await _userCollection(userId)
        .get(const GetOptions(source: Source.cache))
        .then((value) {
      if (value.docs.isNotEmpty) lastDocRef = value.docs.last;
    });

    Query<Question> ref = _userCollection(userId).withConverter(
        fromFirestore: (snapshot, _) => Question.fromJson(snapshot.data()!),
        toFirestore: (data, _) => data.toJson());
    if (lastDocRef != null) {
      ref = ref.startAtDocument(lastDocRef!);
    }
    return ref;
  }

  @override
  Future<void> deleteOriginalQuestion(
      {required String userId, required String originalQuestionDocRef}) async {
    try {
      await _userCollection(userId).doc(originalQuestionDocRef).delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
