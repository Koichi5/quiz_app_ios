import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/option/option.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/presentation/controller/original_question_controller/original_question_controller.dart';

class OriginalQuestionListCard extends HookConsumerWidget {
  const OriginalQuestionListCard({required this.originalQuestion, Key? key})
      : super(key: key);

  final Question originalQuestion;

  Option getCorrectOption(Question question) {
    return question.options.firstWhere((option) => option.isCorrect);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showDeleteConfirmationDialog() {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "削除しました",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await ref
                      .watch(originalQuestionControllerProvider.notifier)
                      .retrieveOriginalQuestionList();
                  context.pop();
                },
                child: const Text("戻る"),
              )
            ],
          );
        },
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpandablePanel(
          header: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(originalQuestion.text),
          ),
          collapsed: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("答え"),
          ),
          expanded: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(getCorrectOption(originalQuestion).text),
              ),
              TextButton(
                onPressed: ([bool mounted = true]) async {
                  if (originalQuestion.originalQuestionDocRef != null) {
                    await ref
                        .watch(originalQuestionControllerProvider.notifier)
                        .deleteOriginalQuestion(
                            originalQuestionDocRef:
                                originalQuestion.originalQuestionDocRef!);
                    if (!mounted) return;
                    showDeleteConfirmationDialog();
                  }
                },
                child: const Text("覚えた！"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
