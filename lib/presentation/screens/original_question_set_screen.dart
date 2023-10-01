import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/presentation/controller/option_text_controller.dart';
import 'package:quiz_app/presentation/controller/question_text_controller.dart';
import 'package:quiz_app/presentation/controller/validator/option_validator_provider.dart';
import 'package:quiz_app/presentation/controller/validator/question_validator_provider.dart';
import 'package:quiz_app/presentation/widgets/custom_text_field.dart';
import 'package:quiz_app/presentation/widgets/original_question_set_button.dart';

class OriginalQuestionSetScreen extends HookConsumerWidget {
  const OriginalQuestionSetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textControllerProvider = ref.watch(questionTextControllerProvider);
    final questionValidator = ref.watch(questionValidatorProvider);
    final questionValidatorNotifier =
        ref.watch(questionValidatorProvider.notifier);
    final optionValidator = ref.watch(optionValidatorProvider);
    final optionValidatorNotifier = ref.watch(optionValidatorProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("問題文追加"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: CustomTextField(
                  title: "問題文",
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  controller: textControllerProvider,
                  error: questionValidator.form.text.errorMessage,
                  onChanged: (questionText) {
                    questionValidatorNotifier.setQuestionText(questionText);
                  },
                  // helperText: "問題文を入力してください",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text("選択肢"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text("正誤"),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: CustomTextField(
                        title: "選択肢１",
                        controller:
                            ref.watch(firstOptionTextControllerProvider),
                        error: optionValidator.form.text.errorMessage,
                        onChanged: (optionText) {
                          optionValidatorNotifier.setOptionText(optionText);
                        },
                      ),
                    ),
                    Switch(
                      value: ref.watch(firstOptionIsCorrectProvider),
                      onChanged: (value) {
                        ref.watch(firstOptionIsCorrectProvider.notifier).state =
                            value;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: CustomTextField(
                        title: "選択肢２",
                        controller:
                            ref.watch(secondOptionTextControllerProvider),
                        error: optionValidator.form.text.errorMessage,
                        onChanged: (optionText) {
                          optionValidatorNotifier.setOptionText(optionText);
                        },
                      ),
                    ),
                    Switch(
                        value: ref.watch(secondOptionIsCorrectProvider),
                        onChanged: (value) {
                          ref
                              .watch(secondOptionIsCorrectProvider.notifier)
                              .state = value;
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: CustomTextField(
                        title: "選択肢３",
                        controller:
                            ref.watch(thirdOptionTextControllerProvider),
                        error: optionValidator.form.text.errorMessage,
                        onChanged: (optionText) {
                          optionValidatorNotifier.setOptionText(optionText);
                        },
                      ),
                    ),
                    Switch(
                        value: ref.watch(thirdOptionIsCorrectProvider),
                        onChanged: (value) {
                          ref
                              .watch(thirdOptionIsCorrectProvider.notifier)
                              .state = value;
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: CustomTextField(
                        title: "選択肢４",
                        controller:
                            ref.watch(fourthOptionTextControllerProvider),
                        error: optionValidator.form.text.errorMessage,
                        onChanged: (optionText) {
                          optionValidatorNotifier.setOptionText(optionText);
                        },
                      ),
                    ),
                    Switch(
                        value: ref.watch(fourthOptionIsCorrectProvider),
                        onChanged: (value) {
                          ref
                              .watch(fourthOptionIsCorrectProvider.notifier)
                              .state = value;
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              OriginalQuestionSetButton(
                text: textControllerProvider.text,
                duration: "10",
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
