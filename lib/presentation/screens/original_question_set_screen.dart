import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/option_form_state/option_form_state.dart';
import 'package:quiz_app/domain/question_form_state/question_form_state.dart';
import 'package:quiz_app/presentation/controller/option_text_controller.dart';
import 'package:quiz_app/presentation/controller/question_text_controller.dart';
import 'package:quiz_app/presentation/controller/validator/option_validator_provider.dart';
import 'package:quiz_app/presentation/controller/validator/question_validator_provider.dart';
import 'package:quiz_app/presentation/widgets/custom_text_field.dart';
import 'package:quiz_app/presentation/widgets/original_question_set_button.dart';

class OriginalQuestionSetScreen extends HookConsumerWidget {
  const OriginalQuestionSetScreen({Key? key}) : super(key: key);

    static String get routeName => 'original-question-set';
  static String get routeLocation => '/$routeName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final textControllerProvider = ref.watch(questionTextControllerProvider);
    final questionValidator = ref.watch(questionValidatorProvider);
    final questionValidatorNotifier =
        ref.watch(questionValidatorProvider.notifier);
    final optionValidator = ref.watch(optionValidatorProvider);
    final optionValidatorNotifier = ref.watch(optionValidatorProvider.notifier);

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
                questionValidatorNotifier,
                optionValidator,
                optionValidatorNotifier),
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
      QuestionValidatorProvider questionValidatorNotifier,
      OptionFormState optionValidator,
      OptionValidatorProvider optionValidatorNotifier) {
    return [
      _buildCustomTextField(
          screenSize: screenSize,
          title: "問題文",
          controller: textControllerProvider,
          error: questionValidator.form.text.errorMessage,
          onChanged: (text) => questionValidatorNotifier.setQuestionText(text)),
      SizedBox(height: screenSize.height * 0.05),
      _buildOptionHeader(screenSize),
      ..._buildOptions(
          context, ref, screenSize, optionValidator, optionValidatorNotifier),
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
      OptionFormState optionValidator,
      OptionValidatorProvider optionValidatorNotifier) {
    final options = [
      ref.watch(firstOptionTextControllerProvider),
      ref.watch(secondOptionTextControllerProvider),
      ref.watch(thirdOptionTextControllerProvider),
      ref.watch(fourthOptionTextControllerProvider),
    ];
    final isCorrectOptions = [
      ref.watch(firstOptionIsCorrectProvider),
      ref.watch(secondOptionIsCorrectProvider),
      ref.watch(thirdOptionIsCorrectProvider),
      ref.watch(fourthOptionIsCorrectProvider),
    ];
    final notifiers = [
      ref.watch(firstOptionIsCorrectProvider.notifier),
      ref.watch(secondOptionIsCorrectProvider.notifier),
      ref.watch(thirdOptionIsCorrectProvider.notifier),
      ref.watch(fourthOptionIsCorrectProvider.notifier),
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
                        optionValidatorNotifier.setOptionText(optionText),
                  ),
                ),
                Switch(
                  value: isCorrectOptions[index],
                  onChanged: (value) => notifiers[index].state = value,
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
