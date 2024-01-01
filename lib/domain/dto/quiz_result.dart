import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_app/domain/question/question.dart';

part 'quiz_result.freezed.dart';

@freezed
class QuizResult with _$QuizResult {
  const factory QuizResult({
    required List<Question> questionList,
    required double totalCorrect,
    required List<int> takenQuestions,
    required List<bool> answerIsCorrectList,
  }) = _QuizResult;
}