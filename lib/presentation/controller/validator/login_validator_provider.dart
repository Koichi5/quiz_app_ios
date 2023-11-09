import 'package:quiz_app/domain/entity/login_form_entity/login_form_entity.dart';
import 'package:quiz_app/domain/field/field.dart';
import 'package:quiz_app/domain/login_form_state/login_form_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_validator_provider.g.dart';

@riverpod
class LoginValidator extends _$LoginValidator {
  @override
  LoginFormState build() => LoginFormState(LoginFormEntity.empty());

  void setEmail(String email) {
    final bool isEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    LoginFormEntity form = state.form.copyWith(email: Field(value: email));

    late Field emailField;

    if(isEmail) {
      emailField = form.email.copyWith(isValid: true, errorMessage: "");
    } else {
      emailField = form.email.copyWith(isValid: false, errorMessage: "メールアドレスが適切ではありません");
    }
    state = state.copyWith(form: form.copyWith(email: emailField));
  }

  void setPassword(String password) {
    final bool isPassword = RegExp(r"^[a-zA-Z0-9]{6,}$").hasMatch(password);
    LoginFormEntity form = state.form.copyWith(password: Field(value: password));

    late Field passwordField;

    if(isPassword) {
      passwordField = form.password.copyWith(isValid: true, errorMessage: "");
    } else {
      passwordField = form.password.copyWith(isValid: false, errorMessage: "6文字以上の英数字を入力してください");
    }
    state = state.copyWith(form: form.copyWith(password: passwordField));
  }
}