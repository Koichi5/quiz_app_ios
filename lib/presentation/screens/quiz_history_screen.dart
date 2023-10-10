import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/domain/quiz_history/quiz_history.dart';
import 'package:quiz_app/presentation/controller/quiz_history_controller.dart';
import 'package:quiz_app/presentation/widgets/quiz_history_card.dart';

class QuizHistoryScreen extends HookConsumerWidget {
  static const routeName = '/quizHistory';

  const QuizHistoryScreen({Key? key}) : super(key: key);

  Widget _buildLoading() {
    return Center(
      child: Lottie.asset("assets/json_files/loading.json",
          width: 200, height: 200),
    );
  }

  Widget _buildError(String error) {
    return Center(child: Text(error));
  }

  Widget _buildNoData(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          const Text("クイズを解いて実力をつけましょう！"),
          Lottie.asset(
            "assets/json_files/quiz_history.json",
            width: MediaQuery.of(context).size.width * 0.7,
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }

  Widget _buildDataList(List<QuizHistory> quizHistoryData) {
    return Center(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: quizHistoryData.length,
        itemBuilder: (BuildContext context, int index) {
          return QuizHistoryCard(quizHistory: quizHistoryData[index]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: ref
            .watch(quizHistoryControllerProvider.notifier)
            .retrieveQuizHistoryList(),
        builder: (BuildContext context,
            AsyncSnapshot<List<QuizHistory>> quizHistoryList) {
          if (quizHistoryList.connectionState != ConnectionState.done) {
            return _buildLoading();
          }
          if (quizHistoryList.hasError) {
            return _buildError(quizHistoryList.error.toString());
          }
          if (quizHistoryList.data == null || quizHistoryList.data!.isEmpty) {
            return _buildNoData(context);
          }
          return _buildDataList(quizHistoryList.data!);
        },
      ),
    );
  }
}
