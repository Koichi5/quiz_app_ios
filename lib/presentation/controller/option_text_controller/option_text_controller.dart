import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'option_text_controller.g.dart';

@riverpod
TextEditingController optionIdControllerState(OptionIdControllerStateRef ref) {
  return TextEditingController(text: '');
}

@riverpod
TextEditingController firstOptionTextControllerState(
    FirstOptionTextControllerStateRef ref) {
  return TextEditingController(text: '');
}

@riverpod
TextEditingController secondOptionTextControllerState(
    SecondOptionTextControllerStateRef ref) {
  return TextEditingController(text: '');
}

@riverpod
TextEditingController thirdOptionTextControllerState(
    ThirdOptionTextControllerStateRef ref) {
  return TextEditingController(text: '');
}

@riverpod
TextEditingController fourthOptionTextControllerState(
    FourthOptionTextControllerStateRef ref) {
  return TextEditingController(text: '');
}

@riverpod
class FirstOptionIsCorrectState extends _$FirstOptionIsCorrectState {
  @override
  bool build() => false;

  void set(bool value) {
    state = value;
  }
}

@riverpod
class SecondOptionIsCorrectState extends _$SecondOptionIsCorrectState {
  @override
  bool build() => false;

  void set(bool value) {
    state = value;
  }
}

@riverpod
class ThirdOptionIsCorrectState extends _$ThirdOptionIsCorrectState {
  @override
  bool build() => false;

  void set(bool value) {
    state = value;
  }
}

@riverpod
class FourthOptionIsCorrectState extends _$FourthOptionIsCorrectState {
  @override
  bool build() => false;

  void set(bool value) {
    state = value;
  }
}
