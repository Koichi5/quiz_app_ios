import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/presentation/screens/quiz_screen.dart';

class OriginalQuestionQuizScreen extends ConsumerWidget {
  const OriginalQuestionQuizScreen({super.key, required this.originalQuestionList});

  final List<Question> originalQuestionList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
          ref.watch(currentQuestionIndexProvider.notifier).state = 1;
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      centerTitle: true,
      title: const Text("オリジナル問題"),
    ),
    body: QuizScreen(ref: ref, questionList: originalQuestionList,),
    );
  }
}
