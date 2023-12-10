import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/domain/option/option.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/domain/repository/original_question_repository/original_question_repository.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/presentation/controller/option_text_controller/option_text_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'original_question_controller.g.dart';

@riverpod
class OriginalQuestionController extends _$OriginalQuestionController {
  late final OriginalQuestionRepository _originalQuestionRepositoryNotifier;
  @override
  Future<List<Question>> build() {
    _originalQuestionRepositoryNotifier =
        ref.watch(originalQuestionRepositoryProvider.notifier);
    return retrieveOriginalQuestionList();
  }

  Future<List<Question>> retrieveOriginalQuestionList() async {
    try {
      final originalQuestionList = await _originalQuestionRepositoryNotifier
          .retrieveOriginalQuestionList();
      return originalQuestionList;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<Question?> addOriginalQuestion({
    String? id,
    required String text,
    required String duration,
    required bool optionsShuffled,
  }) async {
    final originalQuestion = Question(
      id: id,
      text: text,
      duration: int.parse(duration),
      optionsShuffled: optionsShuffled,
      options: [
        Option(
            text: ref.read(firstOptionTextControllerStateProvider).text,
            isCorrect: ref.read(firstOptionIsCorrectStateProvider),
            isSelected: false),
        Option(
            text: ref.read(secondOptionTextControllerStateProvider).text,
            isCorrect: ref.read(secondOptionIsCorrectStateProvider),
            isSelected: false),
        Option(
            text: ref.read(thirdOptionTextControllerStateProvider).text,
            isCorrect: ref.read(thirdOptionIsCorrectStateProvider),
            isSelected: false),
        Option(
            text: ref.read(fourthOptionTextControllerStateProvider).text,
            isCorrect: ref.read(fourthOptionIsCorrectStateProvider),
            isSelected: false),
      ],
    );
    if (ref.read(firstOptionIsCorrectStateProvider) ||
        ref.read(secondOptionIsCorrectStateProvider) ||
        ref.read(thirdOptionIsCorrectStateProvider) ||
        ref.read(fourthOptionIsCorrectStateProvider)) {
      final originalQuestionWithDocRef = await _originalQuestionRepositoryNotifier
          .addOriginalQuestion(question: originalQuestion);
      state.whenData((originalQuestionList) => state = AsyncValue.data(
          originalQuestionList
            ..add(
                originalQuestion.copyWith(id: originalQuestionWithDocRef.id))));
      return originalQuestion;
    } else {
      return null;
    }
  }

  Future<void> deleteOriginalQuestion(
      {required String originalQuestionDocRef}) async {
    try {
      await _originalQuestionRepositoryNotifier
          .deleteOriginalQuestion(
              originalQuestionDocRef: originalQuestionDocRef);
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
