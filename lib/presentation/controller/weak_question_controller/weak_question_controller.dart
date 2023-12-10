import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/domain/repository/weak_question_repository/weak_question_repository.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weak_question_controller.g.dart';

@riverpod
class WeakQuestionController extends _$WeakQuestionController {
  @override
  Future<List<Question>> build() {
    return retrieveWeakQuestionList();
  }

  Future<List<Question>> retrieveWeakQuestionList() async {
    try {
      final weakQuestionList = await ref
          .watch(weakQuestionRepositoryProvider)
          .retrieveWeakQuestionList();
      return weakQuestionList;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<Question> addWeakQuestion({required Question question}) async {
    final questionWithDocRef = await ref
        .watch(weakQuestionRepositoryProvider)
        .addWeakQuestion(question: question);
    state.whenData((questionList) => state = AsyncValue.data(
        questionList..add(question.copyWith(id: questionWithDocRef.id))));
    return question;
  }
}
