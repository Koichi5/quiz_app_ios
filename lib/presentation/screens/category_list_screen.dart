import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/domain/category/category.dart';
import 'package:quiz_app/presentation/controller/category_contoller/category_controller.dart';
import 'package:quiz_app/presentation/widgets/category_card.dart';
import 'package:quiz_app/presentation/widgets/category_list_skelton_card.dart';

class CategoryListScreen extends HookConsumerWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryListState = ref.watch(categoryControllerProvider);

    return SingleChildScrollView(
      child: categoryListState.when(
        data: (categories) => _buildDataState(categories, context),
        error: (error, _) => _buildErrorState(context),
        loading: () => _buildLoadingState(),
      ),
    );
  }

  Widget _buildDataState(List<Category> categories, BuildContext context) {
    if (categories.isEmpty) {
      return const Center(child: Text("カテゴリはありません"));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        return CategoryCard(category: categories[index]);
      },
    );
  }

  Widget _buildErrorState(BuildContext context) {
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
            Lottie.asset(
              "assets/json_files/error.json",
              width: MediaQuery.of(context).size.width * 0.7,
              fit: BoxFit.fitWidth,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return const CategoryListSkeltonCard();
      },
    );
  }
}
