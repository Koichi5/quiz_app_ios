import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/domain/category/category.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/domain/quiz/quiz.dart';
import 'package:quiz_app/presentation/controller/question_controller.dart';
import 'package:quiz_app/presentation/controller/quiz_controller.dart';
import 'package:quiz_app/presentation/screens/quiz_screen.dart';

class QuizListScreen extends HookConsumerWidget {
  static String get routeName => 'quiz-list';
  static String get routeLocation => '/$routeName';
  final Category? category;
  final List<Question>? questionList;
  final List<Quiz>? quizList;

  const QuizListScreen({
    this.category,
    this.questionList,
    this.quizList,
    Key? key,
  }) : super(key: key);

  Widget _buildErrorScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
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
              Lottie.asset(
                "assets/json_files/error.json",
                width: MediaQuery.of(context).size.width * 0.7,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuizScreenWithCategory(
      BuildContext context, WidgetRef ref, Category category) {
    final quizListState = ref.watch(quizControllerProvider(category));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            ref.watch(currentQuestionIndexProvider.notifier).state = 1;
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text(category.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            quizListState.when(
              data: (quizzes) => quizzes.isEmpty
                  ? const Center(
                      child: Material(child: Text("クイズはありません")),
                    )
                  : ref.watch(questionControllerProvider(quizzes.first)).when(
                        data: (questions) => questions.isEmpty
                            ? const Center(
                                child: Text("問題が用意されていません"),
                              )
                            : QuizScreen(
                                ref: ref,
                                category: category,
                                quiz: quizzes.first,
                                questionList: questions),
                        error: (error, _) => Center(
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    fit: BoxFit.fitWidth),
                              ],
                            ),
                          ),
                        ),
                        loading: () => Center(
                          child: Lottie.asset("assets/json_files/loading.json",
                              width: 200, height: 200),
                        ),
                      ),
              error: (error, _) => Center(
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
                          width: MediaQuery.of(context).size.width * 0.7,
                          fit: BoxFit.fitWidth),
                    ],
                  ),
                ),
              ),
              loading: () => Center(
                child: Lottie.asset("assets/json_files/loading.json",
                    width: 200, height: 200),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizScreenWithQuestions(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
            ref.watch(currentQuestionIndexProvider.notifier).state = 1;
          },
        ),
      ),
      body: QuizScreen(
        ref: ref,
        questionList: questionList!,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (category != null) {
      return _buildQuizScreenWithCategory(context, ref, category!);
    } else if (questionList != null) {
      return _buildQuizScreenWithQuestions(context, ref);
    } else {
      return _buildErrorScreen(context);
    }
  }
}
