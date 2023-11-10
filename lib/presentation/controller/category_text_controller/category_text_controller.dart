import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_text_controller.g.dart';

@riverpod
TextEditingController categoryIdControllerState(
    CategoryIdControllerStateRef ref) {
  return TextEditingController(text: '');
}

@riverpod
TextEditingController categoryNameControllerState(
    CategoryNameControllerStateRef ref) {
  return TextEditingController(text: '');
}

@riverpod
TextEditingController categoryDescriptionControllerState(
    CategoryDescriptionControllerStateRef ref) {
  return TextEditingController(text: '');
}

