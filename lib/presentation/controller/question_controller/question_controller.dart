import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/domain/option/option.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/domain/quiz/quiz.dart';
import 'package:quiz_app/domain/repository/question_repository/question_repository.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/presentation/controller/option_text_controller/option_text_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_controller.g.dart';

@Riverpod(keepAlive: true, dependencies: [QuestionRepository])
class QuestionController extends _$QuestionController {

  @override
  Future<List<Question>> build({required Quiz quiz}) {
    return retrieveQuestionList(quiz: quiz);
  }

  Future<List<Question>> retrieveQuestionList({required Quiz quiz}) async {
    try {
      final questionList = await ref
          .watch(questionRepositoryProvider(quiz: quiz))
          .retrieveQuestionList();
      return questionList;
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
    final questionWithDocRef = await ref
        .watch(questionRepositoryProvider(quiz: quiz))
        .addQuestion(question: question);
    state.whenData((questionList) => state = AsyncValue.data(
        questionList..add(question.copyWith(id: questionWithDocRef.id))));
    return question;
  }
}
