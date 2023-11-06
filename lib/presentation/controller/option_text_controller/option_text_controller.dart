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

// final optionIdControllerProvider = StateProvider.autoDispose((ref) {
//   return TextEditingController(text: '');
// });

// final firstOptionTextControllerProvider = StateProvider.autoDispose((ref) {
//   return TextEditingController(text: '');
// });

// final firstOptionIsCorrectProvider = StateProvider.autoDispose((ref) => false);

// final secondOptionTextControllerProvider = StateProvider.autoDispose((ref) {
//   return TextEditingController(text: '');
// });

// final secondOptionIsCorrectProvider = StateProvider.autoDispose((ref) => false);

// final thirdOptionTextControllerProvider = StateProvider.autoDispose((ref) {
//   return TextEditingController(text: '');
// });

// final thirdOptionIsCorrectProvider = StateProvider.autoDispose((ref) => false);

// final fourthOptionTextControllerProvider = StateProvider.autoDispose((ref) {
//   return TextEditingController(text: '');
// });

// final fourthOptionIsCorrectProvider = StateProvider.autoDispose((ref) => false);
