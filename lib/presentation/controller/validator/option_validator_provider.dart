import 'package:quiz_app/domain/entity/option_form_entity/option_form_entity.dart';
import 'package:quiz_app/domain/field/field.dart';
import 'package:quiz_app/domain/option_form_state/option_form_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'option_validator_provider.g.dart';

@riverpod
class OptionValidator extends _$OptionValidator {
  @override
  OptionFormState build() => OptionFormState(OptionFormEntity.empty());

  void setOptionId(String optionId) {
    final bool isOptionId = RegExp("[0-9]").hasMatch(optionId);
    OptionFormEntity form = state.form.copyWith(id: Field(value: optionId));

    late Field optionIdField;

    if (isOptionId) {
      optionIdField = form.id.copyWith(isValid: true, errorMessage: "");
    } else {
      optionIdField =
          form.id.copyWith(isValid: false, errorMessage: "選択肢のIDには数字を指定してください");
    }
    state = state.copyWith(form: form.copyWith(id: optionIdField));
  }

  void setOptionText(String optionText) {
    final bool isOptionText = optionText != "";
    OptionFormEntity form =
    state.form.copyWith(text: Field(value: optionText));

    late Field optionTextField;

    if (isOptionText) {
      optionTextField = form.id.copyWith(isValid: true, errorMessage: "");
    } else {
      optionTextField =
          form.id.copyWith(isValid: false, errorMessage: "選択肢が入力されていません");
    }
    state = state.copyWith(form: form.copyWith(text: optionTextField));
  }
}
