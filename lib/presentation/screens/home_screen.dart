import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/presentation/controller/weak_question_controller/weak_question_controller.dart';
import 'package:quiz_app/presentation/routes/routes.dart';
import 'package:quiz_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:quiz_app/presentation/widgets/segmented_button.dart';

// final List homePageList = [
//   const CategoryListScreen(),
//   const ReviewScreen(),
//   const OriginalQuestionListScreen(),
//   const SettingScreen(),
// ];

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({
    super.key,
    required this.navigationShell,
    required this.children,
  });

  static String get routeName => 'home';
  static String get routeLocation => '/';

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final bottomNavBarSelectedIndex =
    //     ref.watch(bottomNavBarSelectedIndexProvider);

    return Scaffold(
        appBar: _buildAppBar(navigationShell.currentIndex),
        body: BranchContainer(
          currentIndex: navigationShell.currentIndex,
          children: children,
        ),
        bottomNavigationBar: BottomNavBar(
          navigationShell: navigationShell,
        ),
        floatingActionButton: _buildFloatingActionButton(
            context, ref, navigationShell.currentIndex));
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
                  WeakQuestionQuizRoute($extra: weakQuestionList).go(context);
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

class BranchContainer extends StatelessWidget {
  const BranchContainer(
      {super.key, required this.currentIndex, required this.children});

  final int currentIndex;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: children.mapIndexed(
      (int index, Widget child) {
        if (index == currentIndex) {
          return _branchNavigatorWrapper(index, child);
        } else {
          return const SizedBox();
        }
      },
    ).toList());
  }

  Widget _branchNavigatorWrapper(int index, Widget navigator) => IgnorePointer(
        ignoring: index != currentIndex,
        child: TickerMode(
          enabled: index == currentIndex,
          child: navigator,
        ),
      );
}
// Widget _bodyBuilder(
//     {required int currentIndex, required List<Widget> children}) {
//         Widget _branchNavigatorWrapper(int index, Widget navigator) => IgnorePointer(
//         ignoring: index != currentIndex,
//         child: TickerMode(
//           enabled: index == currentIndex,
//           child: navigator,
//         ),
//       );
//   return Stack(
//     children: children.mapIndexed((int index, Widget child) {
//       if(index == currentIndex) {
//         return _branchNavigatorWrapper(index, navigator)
//       }
//     }),
//   );
// }

