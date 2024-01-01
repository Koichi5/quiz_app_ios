import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/presentation/screens/quiz_screen.dart';

class RetryQuizScreen extends ConsumerWidget {
  const RetryQuizScreen({super.key, required this.questionList});

  final List<Question> questionList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.pop();
            ref.watch(currentQuestionIndexProvider.notifier).state = 1;
          },
        ),
        centerTitle: true,
        title: const Text("再挑戦"),
      ),
      body: QuizScreen(
        ref: ref,
        questionList: questionList,
      ),
    );
  }
}
