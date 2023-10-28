import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/presentation/controller/question_controller.dart';
import 'package:quiz_app/presentation/screens/category_list_screen.dart';
import 'package:quiz_app/presentation/screens/original_question_list_screen.dart';
import 'package:quiz_app/presentation/screens/quiz_screen.dart';
import 'package:quiz_app/presentation/screens/review_screen.dart';
import 'package:quiz_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:quiz_app/presentation/widgets/segmented_button.dart';
import 'setting_screen.dart';

final List homePageList = [
  const CategoryListScreen(),
  const ReviewScreen(),
  OriginalQuestionListScreen(),
  const SettingScreen(),
];

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String get routeName => 'home';
  static String get routeLocation => '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNavBarSelectedIndex =
        ref.watch(bottomNavBarSelectedIndexProvider);

    return Scaffold(
        appBar: _buildAppBar(bottomNavBarSelectedIndex),
        bottomNavigationBar: BottomNavBar(),
        body: homePageList[bottomNavBarSelectedIndex],
        floatingActionButton: _buildFloatingActionButton(
            context, ref, bottomNavBarSelectedIndex));
  }

  AppBar? _buildAppBar(int index) {
    if (index == 2) return null;

    Map<int, String> titles = {
      0: "ホーム",
      1: "復習",
      3: "設定",
    };
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(titles[index] ?? ""),
    );
  }

  Widget? _buildFloatingActionButton(
      BuildContext context, WidgetRef ref, int index) {
    if (index != 1) return null;
    if (ref.watch(currentSelectedIndexProvider) != 0) return null;

    return ref.watch(weakQuestionControllerProvider).when(
          data: (weakQuestionList) {
            if (weakQuestionList.isNotEmpty) {
              return FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ref
                                  .watch(currentQuestionIndexProvider.notifier)
                                  .state = 1;
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                          centerTitle: true,
                          title: const Text("苦手問題"),
                        ),
                        body: QuizScreen(
                          ref: ref,
                          questionList: weakQuestionList,
                        ),
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.play_arrow),
              );
            }
            return null;
          },
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
                  Lottie.asset(
                    "assets/json_files/error.json",
                    width: MediaQuery.of(context).size.width * 0.7,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ),
          ),
          loading: () => const SizedBox(),
        );
  }
}
