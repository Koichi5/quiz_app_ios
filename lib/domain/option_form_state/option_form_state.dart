import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_app/domain/entity/option_form_entity/option_form_entity.dart';

part 'option_form_state.freezed.dart';

@freezed
class OptionFormState with _$OptionFormState {
  const factory OptionFormState(OptionFormEntity form) = _OptionFormState;
}