import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/presentation/screens/quiz_screen.dart';

class WeakQuestionQuizScreen extends ConsumerWidget {
  const WeakQuestionQuizScreen({super.key, required this.weakQuestionList});

  final List<Question> weakQuestionList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
            ref.watch(currentQuestionIndexProvider.notifier).state = 1;
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text("苦手問題"),
      ),
      body: QuizScreen(
        ref: ref,
        questionList: weakQuestionList,
      ),
    );
  }
}
