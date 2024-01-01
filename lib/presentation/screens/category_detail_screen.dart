import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/category/category.dart';
import 'package:quiz_app/presentation/routes/routes.dart';

final weakQuestionInCategoryCountProvider = StateProvider((ref) => 0);

class CategoryDetailScreen extends HookConsumerWidget {
  const CategoryDetailScreen({required this.category, Key? key})
      : super(key: key);

  final Category category;
  static String get routeName => 'category-detail';
  static String get routeLocation => '/$routeName';

  String _calcProcessTime(int categoryCount) {
    final processTime = categoryCount * 10;
    if (categoryCount < 6) {
      return "${processTime * 10} 秒";
    } else {
      final processTimeMin = (processTime / 60).floor();
      final processTimeSec = processTime % 60;
      return "$processTimeMin 分 $processTimeSec 秒";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int weakQuestionInCategoryCount =
        ref.watch(weakQuestionInCategoryCountProvider);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            category.imagePath,
            fit: BoxFit.fitWidth,
          ),
          _buildBackButton(context),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
                color: Theme.of(context).colorScheme.background,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 40.0, right: 40.0, bottom: 20.0, left: 40.0),
                          child: Text(
                            category.name,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 40.0),
                          child: Text(category.description),
                        ),
                        _buildCategoryInfoRow(
                          context,
                          icon: Icons.question_mark,
                          label: "問題数",
                          value: "${category.categoryQuestionCount} 問",
                        ),
                        _buildCategoryInfoRow(
                          context,
                          icon: Icons.timer,
                          label: "所要時間",
                          value:
                              _calcProcessTime(category.categoryQuestionCount),
                        ),
                        _buildCategoryInfoRow(
                          context,
                          icon: Icons.star,
                          label: "苦手問題",
                          value: "$weakQuestionInCategoryCount 問",
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ElevatedButton(
                            onPressed: () {
                              QuizListRoute($extra: category).go(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary),
                            child: Text(
                              "スタート",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
      child: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
    );
  }

  Widget _buildCategoryInfoRow(BuildContext context,
      {required IconData icon, required String label, required String value}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, right: 20.0, bottom: 20.0, left: 40),
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(label),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
              child: Text(value),
            ),
          ],
        ),
        Divider(
          color: Theme.of(context).colorScheme.inversePrimary,
          thickness: 1.0,
          indent: 20.0,
          endIndent: 20.0,
        ),
      ],
    );
  }
}
