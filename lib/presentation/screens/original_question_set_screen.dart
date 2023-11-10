import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/option_form_state/option_form_state.dart';
import 'package:quiz_app/domain/question_form_state/question_form_state.dart';
import 'package:quiz_app/presentation/controller/option_text_controller/option_text_controller.dart';
import 'package:quiz_app/presentation/controller/question_text_controller/question_text_controller.dart';
import 'package:quiz_app/presentation/controller/validator/option_validator_provider.dart';
import 'package:quiz_app/presentation/controller/validator/question_validator_provider.dart';
import 'package:quiz_app/presentation/widgets/custom_text_field.dart';
import 'package:quiz_app/presentation/widgets/original_question_set_button.dart';

class OriginalQuestionSetScreen extends HookConsumerWidget {
  const OriginalQuestionSetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final textControllerProvider =
        ref.watch(questionTextControllerStateProvider);
    final questionValidator = ref.watch(questionValidatorProvider);
    final optionValidator = ref.watch(optionValidatorProvider);

    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildContent(
                context,
                ref,
                screenSize,
                textControllerProvider,
                questionValidator,
                optionValidator,
                ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text("問題文追加"),
    );
  }

  List<Widget> _buildContent(
      BuildContext context,
      WidgetRef ref,
      Size screenSize,
      TextEditingController textControllerProvider,
      QuestionFormState questionValidator,
      OptionFormState optionValidator) {
    return [
      _buildCustomTextField(
          screenSize: screenSize,
          title: "問題文",
          controller: textControllerProvider,
          error: questionValidator.form.text.errorMessage,
          onChanged: (text) {
            ref.watch(questionValidatorProvider.notifier).setQuestionText(text);
          }),
      SizedBox(height: screenSize.height * 0.05),
      _buildOptionHeader(screenSize),
      ..._buildOptions(
          context, ref, screenSize, optionValidator),
      const SizedBox(height: 8),
      OriginalQuestionSetButton(
          text: textControllerProvider.text, duration: "10"),
      const SizedBox(height: 50),
    ];
  }

  Widget _buildCustomTextField(
      {required Size screenSize,
      required String title,
      required TextEditingController controller,
      required String error,
      required ValueChanged<String> onChanged}) {
    return SizedBox(
      width: screenSize.width * 0.9,
      child: CustomTextField(
        title: title,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        controller: controller,
        error: error,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildOptionHeader(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.05,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text("選択肢")),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text("正誤")),
        ],
      ),
    );
  }

  List<Widget> _buildOptions(
      BuildContext context,
      WidgetRef ref,
      Size screenSize,
      OptionFormState optionValidator) {
    final options = [
      ref.watch(firstOptionTextControllerStateProvider),
      ref.watch(secondOptionTextControllerStateProvider),
      ref.watch(thirdOptionTextControllerStateProvider),
      ref.watch(fourthOptionTextControllerStateProvider),
    ];
    final isCorrectOptions = [
      ref.watch(firstOptionIsCorrectStateProvider),
      ref.watch(secondOptionIsCorrectStateProvider),
      ref.watch(thirdOptionIsCorrectStateProvider),
      ref.watch(fourthOptionIsCorrectStateProvider),
    ];
    final notifiers = [
      ref.watch(firstOptionIsCorrectStateProvider.notifier),
      ref.watch(secondOptionIsCorrectStateProvider.notifier),
      ref.watch(thirdOptionIsCorrectStateProvider.notifier),
      ref.watch(fourthOptionIsCorrectStateProvider.notifier),
    ];

    return List.generate(4, (index) {
      return Column(
        children: [
          SizedBox(
            width: screenSize.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenSize.width * 0.7,
                  child: CustomTextField(
                    title: "選択肢${index + 1}",
                    controller: options[index],
                    error: optionValidator.form.text.errorMessage,
                    onChanged: (optionText) =>
                        ref.watch(optionValidatorProvider.notifier).setOptionText(optionText),
                  ),
                ),
                Switch(
                  value: isCorrectOptions[index],
                  onChanged: (value) {
                    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                    notifiers[index].state = value;
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: screenSize.height * 0.05),
        ],
      );
    });
  }
}
