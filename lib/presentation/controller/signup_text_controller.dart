import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signup_text_controller.g.dart';

@riverpod
TextEditingController signupNameControllerState(
    SignupNameControllerStateRef ref) {
  return TextEditingController(text: "");
}

@riverpod
TextEditingController signupEmailControllerState(
    SignupEmailControllerStateRef ref) {
  return TextEditingController(text: '');
}

@riverpod
TextEditingController signupPasswordControllerState(
    SignupPasswordControllerStateRef ref) {
  return TextEditingController(text: '');
}

@riverpod
class SignupObscureTextState extends _$SignupObscureTextState {
  @override
  bool build() => true;

  void toggle() {
    state = !state;
  }
  // この記法だと動かない
  // void toggle() => !state;
}

// final signupObscureTextStateProvider = StateProvider.autoDispose((ref) => true);
