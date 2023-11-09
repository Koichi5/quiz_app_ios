import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/domain/repository/auth_repository/auth_repository.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/general/general_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'original_question_repository.g.dart';

@Riverpod(keepAlive: true, dependencies: [firebaseFirestore, AuthRepository])
class OriginalQuestionRepository extends _$OriginalQuestionRepository {
  late final CollectionReference _userCollection;

  @override
  OriginalQuestionRepository build() {
    final userId = ref.watch(authRepositoryProvider).getCurrentUser()!.uid;
    _userCollection = ref
        .watch(firebaseFirestoreProvider)
        .collection("user")
        .doc(userId)
        .collection("originalQuestion");
    return this;
  }

  Future<Question> addOriginalQuestion(
      {required Question question}) async {
    try {
      final originalQuestionWithDocRef = Question(
        id: question.id,
        text: question.text,
        originalQuestionDocRef: "",
        duration: question.duration,
        optionsShuffled: question.optionsShuffled,
        options: [],
      );
      // originalQuestionDocRef が正しく記録されるために一度 originalQuestionDocRef を含まない状態で add する
      final originalQuestion = await _userCollection
          .add(originalQuestionWithDocRef.toDocument());
      // add した後にドキュメントIDの取得を行い、 update で反映させる
      final originalQuestionDocRef = originalQuestion.id;

      await _userCollection.doc(originalQuestionDocRef).update({
        "options":
            question.options.map((option) => option.toDocument()).toList(),
        "originalQuestionDocRef": originalQuestionDocRef,
      });
      return originalQuestionWithDocRef;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<List<Question>> retrieveOriginalQuestionList() async {
    try {
      return await retrieveQuery().then((ref) async => await ref
          .get()
          .then((value) async => await retrieveLocalOriginalQuestionList()));
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<List<Question>> retrieveLocalOriginalQuestionList() async {
    final snap =
        await _userCollection.get(const GetOptions(source: Source.cache));
    return snap.docs.map((doc) => Question.fromDocument(doc)).toList();
  }

  Future<Query<Question>> retrieveQuery() async {
    DocumentSnapshot? lastDocRef;
    await _userCollection
        .get(const GetOptions(source: Source.cache))
        .then((value) {
      if (value.docs.isNotEmpty) lastDocRef = value.docs.last;
    });

    Query<Question> ref = _userCollection.withConverter(
        fromFirestore: (snapshot, _) => Question.fromJson(snapshot.data()!),
        toFirestore: (data, _) => data.toJson());
    if (lastDocRef != null) {
      ref = ref.startAtDocument(lastDocRef!);
    }
    return ref;
  }

  Future<void> deleteOriginalQuestion(
      {required String originalQuestionDocRef}) async {
    try {
      await _userCollection.doc(originalQuestionDocRef).delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
