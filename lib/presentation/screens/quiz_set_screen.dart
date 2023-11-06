import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/category/category.dart';
import 'package:quiz_app/presentation/controller/quiz_text_controller/quiz_text_controller.dart';
import 'package:quiz_app/presentation/controller/validator/quiz_validator_provider.dart';
import 'package:quiz_app/presentation/widgets/custom_text_field.dart';
import 'package:quiz_app/presentation/widgets/quiz_set_button.dart';

class QuizSetScreen extends HookConsumerWidget {
  const QuizSetScreen({required this.category, Key? key}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleControllerProvider = ref.watch(quizTitleControllerStateProvider);
    final descriptionControllerProvider =
        ref.watch(quizDescriptionControllerStateProvider);
    final quizValidator = ref.watch(quizValidatorProvider);
    final quizValidatorNotifier = ref.watch(quizValidatorProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("カテゴリ追加"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildVerticalSpacer(context, 0.1),
            _buildCustomTextField(
              title: "クイズ名",
              controller: titleControllerProvider,
              error: quizValidator.form.title.errorMessage,
              onChanged: quizValidatorNotifier.setQuizTitle,
              context: context,
            ),
            _buildVerticalSpacer(context, 0.02),
            _buildCustomTextField(
              title: "クイズ詳細",
              controller: descriptionControllerProvider,
              error: quizValidator.form.description.errorMessage,
              onChanged: quizValidatorNotifier.setQuizDescription,
              context: context,
            ),
            _buildVerticalSpacer(context, 0.02),
            QuizSetButton(
              title: titleControllerProvider.text,
              description: descriptionControllerProvider.text,
              category: category,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalSpacer(BuildContext context, double proportion) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * proportion,
    );
  }

  Widget _buildCustomTextField({
    required String title,
    required TextEditingController controller,
    required String? error,
    required void Function(String) onChanged,
    required BuildContext context,
  }) {
    return Column(
      children: [
        _buildVerticalSpacer(context, 0.02),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: CustomTextField(
            title: title,
            controller: controller,
            error: error,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
