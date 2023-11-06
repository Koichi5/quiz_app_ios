import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quiz_text_controller.g.dart';

@riverpod
TextEditingController quizIdControllerState(QuizIdControllerStateRef ref) {
  return TextEditingController(text: '');
}

@riverpod
TextEditingController quizTitleControllerState(QuizTitleControllerStateRef ref) {
  return TextEditingController(text: '');
}

@riverpod
TextEditingController quizDescriptionControllerState(QuizDescriptionControllerStateRef ref) {
  return TextEditingController(text: '');
}

@riverpod
TextEditingController quizCategoryIdControllerState(QuizCategoryIdControllerStateRef ref) {
  return TextEditingController(text: '');
}
