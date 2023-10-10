import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/quiz/quiz.dart';
import 'package:quiz_app/presentation/controller/category_controller.dart';
import 'package:quiz_app/presentation/controller/question_controller.dart';
import 'package:quiz_app/presentation/controller/validator/question_validator_provider.dart';

class QuestionSetButton extends HookConsumerWidget {
  const QuestionSetButton(
      {required this.text,
      required this.duration,
      required this.quiz,
      Key? key})
      : super(key: key);
  final String text;
  final String duration;
  final Quiz quiz;

  Color _getButtonColor(BuildContext context, WidgetRef ref) {
    return ref.watch(questionValidatorProvider).form.isValid
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;
  }

  Color _getTextColor(BuildContext context, WidgetRef ref) {
    return ref.watch(questionValidatorProvider).form.isValid
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSecondary;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonColor = _getButtonColor(context, ref);
    final textColor = _getTextColor(context, ref);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
          onPressed: ([bool mounted = true]) async {
            if (ref.watch(questionValidatorProvider).form.isValid) {
              await ref
                  .watch(questionControllerProvider(quiz).notifier)
                  .addQuestion(
                    text: text,
                    duration: duration,
                    optionsShuffled: false,
                    quiz: quiz,
                  );
              ref.watch(categoryQuestionCountProvider.notifier).state++;
              if (!mounted) return;
              Navigator.pop(context);
            }
          },
          child: Text(
            "問題登録",
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
