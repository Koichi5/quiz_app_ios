import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_text_controller.g.dart';

@riverpod
TextEditingController loginEmailControllerState(
    LoginEmailControllerStateRef ref) {
  return TextEditingController(text: '');
}

@riverpod
TextEditingController loginPasswordControllerState(
    LoginPasswordControllerStateRef ref) {
  return TextEditingController(text: '');
}

@riverpod
class LoginObscureTextState extends _$LoginObscureTextState {
  @override
  bool build() => true;

  void toggle() {
    state = !state;
  }
}
