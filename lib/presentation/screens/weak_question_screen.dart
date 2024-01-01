import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/presentation/controller/weak_question_controller/weak_question_controller.dart';
import 'package:quiz_app/presentation/widgets/weak_question_card.dart';

class WeakQuestionScreen extends HookConsumerWidget {
  const WeakQuestionScreen({Key? key}) : super(key: key);

  static String get routeName => 'weak-question';
  static String get routeLocation => '/$routeName';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weakQuestionState = ref.watch(weakQuestionControllerProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Center(
        child: _buildWeakQuestionState(context, weakQuestionState, screenHeight, screenWidth),
      ),
    );
  }

  Widget _buildWeakQuestionState(BuildContext context, AsyncValue<List> weakQuestionState, double screenHeight, double screenWidth) {
    return weakQuestionState.when(
      data: (weakQuestionList) {
        if (weakQuestionList.isEmpty) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 0.1 * screenHeight),
              const Text("苦手問題を登録して復習しましょう！"),
              Lottie.asset(
                "assets/json_files/weak_question.json",
                width: 0.7 * screenWidth,
                fit: BoxFit.fitWidth,
              ),
            ],
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: weakQuestionList.length,
            itemBuilder: (BuildContext context, int index) {
              final retrievedWeakQuestion = weakQuestionList[index];
              return WeakQuestionCard(question: retrievedWeakQuestion);
            },
          );
        }
      },
      error: (error, _) {
        return Center(
          child: Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "エラーが発生しています",
                  textAlign: TextAlign.center,
                ),
                Lottie.asset("assets/json_files/error.json",
                    width: 0.7 * screenWidth, fit: BoxFit.fitWidth),
              ],
            ),
          ),
        );
      },
      loading: () {
        return Center(
          child: Lottie.asset("assets/json_files/loading.json",
              width: 200, height: 200),
        );
      },
    );
  }
}
