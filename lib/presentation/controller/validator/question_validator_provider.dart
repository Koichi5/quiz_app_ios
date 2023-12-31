import 'package:quiz_app/domain/entity/question_form_entity/question_form_entity.dart';
import 'package:quiz_app/domain/field/field.dart';
import 'package:quiz_app/domain/question_form_state/question_form_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_validator_provider.g.dart';

@riverpod
class QuestionValidator extends _$QuestionValidator {
  @override
  QuestionFormState build() => QuestionFormState(QuestionFormEntity.empty());

  void setQuestionId(String questionId) {
    final bool isQuestionId = RegExp("[0-9]").hasMatch(questionId);
    QuestionFormEntity form = state.form.copyWith(id: Field(value: questionId));

    late Field questionIdField;

    if (isQuestionId) {
      questionIdField = form.id.copyWith(isValid: true, errorMessage: "");
    } else {
      questionIdField =
          form.id.copyWith(isValid: false, errorMessage: "問題のIDには数字を指定してください");
    }
    state = state.copyWith(form: form.copyWith(id: questionIdField));
  }

  void setQuestionText(String questionText) {
    final bool isQuestionText = questionText != "";
    QuestionFormEntity form =
        state.form.copyWith(text: Field(value: questionText));

    late Field questionTextField;

    if (isQuestionText) {
      questionTextField = form.id.copyWith(isValid: true, errorMessage: "");
    } else {
      questionTextField =
          form.id.copyWith(isValid: false, errorMessage: "問題文が入力されていません");
    }
    state = state.copyWith(form: form.copyWith(text: questionTextField));
  }
}
