import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/option/option.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/domain/repository/original_question_repository.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/presentation/controller/auth_controller.dart';
import 'package:quiz_app/presentation/controller/option_text_controller.dart';

final originalQuestionExceptionProvider =
    StateProvider<CustomException?>((_) => null);

final originalQuestionControllerProvider = StateNotifierProvider.autoDispose<
    OriginalQuestionController, AsyncValue<List<Question>>>((ref) {
  final user = ref.read(authControllerProvider);
  return OriginalQuestionController(ref, user?.uid);
});

class OriginalQuestionController
    extends StateNotifier<AsyncValue<List<Question>>> {
  final Ref ref;
  final String? _userId;

  OriginalQuestionController(this.ref, this._userId)
      : super(const AsyncValue.loading()) {
    if (_userId != null) {
      retrieveOriginalQuestionList();
    }
  }

  Future<void> retrieveOriginalQuestionList() async {
    try {
      final originalQuestionList =
          await ref.read(originalQuestionRepositoryProvider)
              .retrieveOriginalQuestionList(userId: _userId!);
      if (mounted) {
        state = AsyncValue.data(originalQuestionList);
      }
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
            text: ref.read(firstOptionTextControllerProvider).text,
            isCorrect: ref.read(firstOptionIsCorrectProvider),
            isSelected: false),
        Option(
            text: ref.read(secondOptionTextControllerProvider).text,
            isCorrect: ref.read(secondOptionIsCorrectProvider),
            isSelected: false),
        Option(
            text: ref.read(thirdOptionTextControllerProvider).text,
            isCorrect: ref.read(thirdOptionIsCorrectProvider),
            isSelected: false),
        Option(
            text: ref.read(fourthOptionTextControllerProvider).text,
            isCorrect: ref.read(fourthOptionIsCorrectProvider),
            isSelected: false),
      ],
    );
    if (ref.read(firstOptionIsCorrectProvider) ||
        ref.read(secondOptionIsCorrectProvider) ||
        ref.read(thirdOptionIsCorrectProvider) ||
        ref.read(fourthOptionIsCorrectProvider)) {
      final originalQuestionWithDocRef =
          await ref.read(originalQuestionRepositoryProvider).addOriginalQuestion(
              userId: _userId!, question: originalQuestion);
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
      await ref.read(originalQuestionRepositoryProvider).deleteOriginalQuestion(
          userId: _userId!, originalQuestionDocRef: originalQuestionDocRef);
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
