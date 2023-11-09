import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/domain/repository/auth_repository/auth_repository.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/general/general_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weak_question_repository.g.dart';

@Riverpod(
    keepAlive: true,
    dependencies: [firebaseFirestore, firebaseAuth, AuthRepository])
class WeakQuestionRepository extends _$WeakQuestionRepository {
  late final CollectionReference _weakQuestionsCollection;
  @override
  WeakQuestionRepository build() {
    final userId = ref.watch(authRepositoryProvider).getCurrentUser()!.uid;
    _weakQuestionsCollection = ref
        .watch(firebaseFirestoreProvider)
        .collection("user")
        .doc(userId)
        .collection("weakQuestion");
    return this;
  }

  Future<Question> addWeakQuestion({required Question question}) async {
    try {
      final questionRef = _weakQuestionsCollection
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

  Future<List<Question>> retrieveWeakQuestionList() async {
    try {
      final currentUser = ref.watch(firebaseAuthProvider).currentUser!;
      return await retrieveQuery(uid: currentUser.uid).then((ref) async =>
          await ref.get().then((value) async =>
              await retrieveLocalWeakQuestionList()));
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<List<Question>> retrieveLocalWeakQuestionList() async {
    final snap = await _weakQuestionsCollection
        .get(const GetOptions(source: Source.cache));
    return snap.docs.map((doc) => Question.fromDocument(doc)).toList();
  }

  Future<Query<Question>> retrieveQuery({required String uid}) async {
    DocumentSnapshot? lastDocRef;
    await _weakQuestionsCollection
        .get(const GetOptions(source: Source.cache))
        .then((value) {
      if (value.docs.isNotEmpty) lastDocRef = value.docs.last;
    });

    Query<Question> ref = _weakQuestionsCollection.withConverter(
        fromFirestore: (snapshot, _) => Question.fromJson(snapshot.data()!),
        toFirestore: (data, _) => data.toJson());
    if (lastDocRef != null) {
      ref = ref.startAtDocument(lastDocRef!);
    }
    return ref;
  }

  Future<void> deleteWeakQuestion({required String weakQuestionDocRef}) async {
    try {
      await _weakQuestionsCollection
          .doc(weakQuestionDocRef)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
