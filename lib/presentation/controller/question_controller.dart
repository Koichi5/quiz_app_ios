import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/option/option.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/domain/quiz/quiz.dart';
import 'package:quiz_app/domain/repository/question_repository.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/presentation/controller/auth_controller.dart';
import 'package:quiz_app/presentation/controller/option_text_controller.dart';


final questionExceptionProvider = StateProvider<CustomException?>((_) => null);

final questionControllerProvider = StateNotifierProvider.family
    .autoDispose<QuestionController, AsyncValue<List<Question>>, Quiz>(
        (ref, quiz) {
  final user = ref.read(authControllerProvider);
  return QuestionController(ref, user?.uid, quiz);
});

class QuestionController extends StateNotifier<AsyncValue<List<Question>>> {
  final Ref ref;
  final String? _userId;
  final Quiz quiz;

  QuestionController(this.ref, this._userId, this.quiz)
      : super(const AsyncValue.loading()) {
    if (_userId != null) {
      retrieveQuestionList(quiz: quiz);
    }
  }

  Future<void> retrieveQuestionList({required Quiz quiz}) async {
    try {
      final questionList = await ref.watch(questionRepositoryProvider)
          .retrieveQuestionList(quiz: quiz);
      if (mounted) {
        state = AsyncValue.data(questionList);
      }
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<Question> addQuestion({
    String? id,
    required String text,
    required String duration,
    required bool optionsShuffled,
    required Quiz quiz,
  }) async {
    final question = Question(
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
    final questionWithDocRef = await ref.watch(questionRepositoryProvider)
        .addQuestion(question: question, quiz: quiz);
    state.whenData((questionList) => state = AsyncValue.data(
        questionList..add(question.copyWith(id: questionWithDocRef.id))));
    return question;
  }
}

final weakQuestionExceptionProvider =
    StateProvider<CustomException?>((_) => null);

final weakQuestionControllerProvider = StateNotifierProvider.autoDispose<
    WeakQuestionController, AsyncValue<List<Question>>>((ref) {
  final user = ref.read(authControllerProvider);
  return WeakQuestionController(ref, user?.uid);
});

class WeakQuestionController extends StateNotifier<AsyncValue<List<Question>>> {
  final Ref ref;
  final String? _userId;

  WeakQuestionController(this.ref, this._userId)
      : super(const AsyncValue.loading()) {
    if (_userId != null) {
      retrieveWeakQuestionList();
    }
  }

  Future<void> retrieveWeakQuestionList() async {
    try {
      final weakQuestionList = await ref.watch(weakQuestionRepositoryProvider)
          .retrieveWeakQuestionList();
      if (mounted) {
        state = AsyncValue.data(weakQuestionList);
      }
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<Question> addWeakQuestion({required Question question}) async {
    final questionWithDocRef = await ref.watch(weakQuestionRepositoryProvider)
        .addWeakQuestion(question: question);
    state.whenData((questionList) => state = AsyncValue.data(
        questionList..add(question.copyWith(id: questionWithDocRef.id))));
    return question;
  }
}
