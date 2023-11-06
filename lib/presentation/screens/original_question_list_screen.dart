import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/presentation/controller/original_question_controller/original_question_controller.dart';
import 'package:quiz_app/presentation/screens/quiz_screen.dart';
import 'package:quiz_app/presentation/widgets/original_question_list_card.dart';

import 'original_question_set_screen.dart';

class OriginalQuestionListScreen extends HookConsumerWidget {
  OriginalQuestionListScreen({Key? key}) : super(key: key);

  final List<String> dictionaryWordList = [];
  final List<String> dictionaryDescriptionList = [];
  final List<String> dictionaryUrlList = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final originalQuestionState = ref.watch(originalQuestionControllerProvider);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context, ref, originalQuestionState, screenSize),
      floatingActionButton:
          _buildFloatingActionButton(context, ref, originalQuestionState),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: const Text("オリジナル問題"),
      actions: [
        IconButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OriginalQuestionSetScreen())),
          icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref,
      AsyncValue<List<Question>> originalQuestionState, Size screenSize) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            originalQuestionState.when(
              data: (originalQuestionList) => originalQuestionList.isEmpty
                  ? _buildEmptyState(context, screenSize)
                  : _buildQuestionList(originalQuestionList),
              error: (error, _) => _buildErrorState(context, screenSize),
              loading: () => _buildLoadingState(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, Size screenSize) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenSize.height * 0.1),
          const Text("自分で問題を追加して解いてみましょう！"),
          Lottie.asset("assets/json_files/original_question.json",
              width: screenSize.width * 0.7, fit: BoxFit.fitWidth),
        ],
      ),
    );
  }

  Widget _buildQuestionList(List<Question> originalQuestionList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: originalQuestionList.length,
      itemBuilder: (BuildContext context, int index) {
        return OriginalQuestionListCard(
            originalQuestion: originalQuestionList[index]);
      },
    );
  }

  Widget _buildErrorState(BuildContext context, Size screenSize) {
    return Center(
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("エラーが発生しています", textAlign: TextAlign.center),
            Lottie.asset("assets/json_files/error.json",
                width: screenSize.width * 0.7, fit: BoxFit.fitWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
        child: Lottie.asset("assets/json_files/loading.json",
            width: 200, height: 200));
  }

  Widget _buildFloatingActionButton(BuildContext context, WidgetRef ref,
      AsyncValue<List<Question>> originalQuestionState) {
    return originalQuestionState.when(
      data: (originalQuestionList) => originalQuestionList.isEmpty
          ? const SizedBox()
          : FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: _buildQuizAppBar(context, ref),
                    body: QuizScreen(
                        ref: ref,
                        questionList: originalQuestionState.asData!.value),
                  ),
                ),
              ),
              child: const Icon(Icons.play_arrow),
            ),
      error: (error, _) =>
          _buildErrorState(context, MediaQuery.of(context).size),
      loading: () => const Center(child: SizedBox()),
    );
  }

  AppBar _buildQuizAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
          ref.watch(currentQuestionIndexProvider.notifier).state = 1;
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      centerTitle: true,
      title: const Text("オリジナル問題"),
    );
  }
}
