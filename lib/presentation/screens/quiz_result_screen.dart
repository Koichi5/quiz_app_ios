import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/domain/dto/quiz_result.dart';
import 'package:quiz_app/presentation/routes/routes.dart';
import 'package:quiz_app/presentation/screens/quiz_screen.dart';
import 'package:quiz_app/presentation/widgets/result_question_list_card.dart';

class QuizResultScreen extends HookConsumerWidget {
  const QuizResultScreen({required this.result, Key? key}) : super(key: key);

  static String get routeName => 'quiz-result';
  static String get routeLocation => '/$routeName';

  final QuizResult result;

  bool get hasError =>
      result.questionList.length != result.answerIsCorrectList.length;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: !hasError,
      ),
      body: hasError
          ? _buildErrorScreen(context)
          : _buildResultScreen(context, ref),
    );
  }

  Widget _buildErrorScreen(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "エラーが発生しています\n テスト結果を正確に取得できませんでした",
            textAlign: TextAlign.center,
          ),
          Lottie.asset(
            "assets/json_files/error.json",
            width: MediaQuery.of(context).size.width * 0.7,
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }

  Widget _buildResultScreen(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _quizResultInfo(context),
          _resultQuestionList(context),
          _bottomButtons(context, ref),
        ],
      ),
    );
  }

  Widget _quizResultInfo(BuildContext context) {
    final int correctAnswerRate =
        (result.totalCorrect / result.questionList.length * 100).round();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "正答率",
            style: TextStyle(fontSize: 15),
          ),
          Text(
            "$correctAnswerRate%",
            style: Theme.of(context).textTheme.headline2,
          ),
        ],
      ),
    );
  }

  Widget _resultQuestionList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: result.questionList.length,
      itemBuilder: (BuildContext context, int index) {
        final question = result.questionList[result.takenQuestions[index]];
        final answerIsCorrect = result.answerIsCorrectList[index];
        return ResultQuestionListCard(
            question: question, answerIsCorrect: answerIsCorrect);
      },
    );
  }

  Widget _bottomButtons(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _retryButton(context, ref),
          _exitButton(context),
        ],
      ),
    );
  }

  Widget _retryButton(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextButton(
        onPressed: () {
          ref.watch(currentQuestionIndexProvider.notifier).state = 1;
          // RetryQuizRoute($extra: result.questionList).go(context);

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => RetryQuizScreen(
          //       questionList: result.questionList,
          //     ),
          //   ),
          // );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => Scaffold(
          //       appBar: AppBar(
          //         leading: IconButton(
          //           icon: const Icon(Icons.arrow_back_ios),
          //           onPressed: () {
          //             context.pop();
          //             ref.watch(currentQuestionIndexProvider.notifier).state =
          //                 1;
          //           },
          //         ),
          //         centerTitle: true,
          //         title: const Text("再挑戦"),
          //       ),
          //       body: QuizScreen(
          //         questionList: result.questionList,
          //         ref: ref,
          //       ),
          //     ),
          //   ),
          // );
        },
        child: Text(
          "再挑戦",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }

  Widget _exitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () {
          // const HomeRoute().pushReplacement(context);
          const CategoryListRoute().pushReplacement(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "終 了",
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
