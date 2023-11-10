import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_text_controller.g.dart';

@riverpod
TextEditingController questionIdControllerState (QuestionIdControllerStateRef ref) {
  return TextEditingController(text: '');
}

@riverpod
TextEditingController questionTextControllerState (QuestionTextControllerStateRef ref) {
  return TextEditingController(text: '');
}

@riverpod
TextEditingController questionDurationControllerState (QuestionDurationControllerStateRef ref) {
  return TextEditingController(text: '');
}