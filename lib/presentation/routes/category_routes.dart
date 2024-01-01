import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/domain/category/category.dart';
import 'package:quiz_app/domain/dto/quiz_result.dart';
import 'package:quiz_app/presentation/screens/category_detail_screen.dart';
import 'package:quiz_app/presentation/screens/category_list_screen.dart';
import 'package:quiz_app/presentation/screens/quiz_list_screen.dart';
import 'package:quiz_app/presentation/screens/quiz_result_screen.dart';

const categoryRoutes = TypedGoRoute<CategoryListRoute>(
  path: '/category-list',
  routes: [
    TypedGoRoute<CategoryDetailRoute>(
      path: 'detail',
      routes: [
        TypedGoRoute<QuizListRoute>(
          path: 'quiz-list',
          routes: [
            TypedGoRoute<QuizResultRoute>(
              path: 'quiz-result',
            ),
          ],
        ),
      ],
    ),
  ],
);

class CategoryBranchData extends StatefulShellBranchData {
  const CategoryBranchData();
}

class CategoryListRoute extends GoRouteData {
  const CategoryListRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
        key: state.pageKey, child: const CategoryListScreen());
  }
}

class CategoryDetailRoute extends GoRouteData {
  const CategoryDetailRoute({required this.category});

  final Category category;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: CategoryDetailScreen(
        category: category,
      ),
    );
  }
}

class QuizListRoute extends GoRouteData {
  const QuizListRoute({required this.category});

  final Category category;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
        key: state.pageKey,
        child: QuizListScreen(
          category: category,
        ));
  }
}

class QuizResultRoute extends GoRouteData {
  const QuizResultRoute({
    required this.result,
  });

  final QuizResult result;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: QuizResultScreen(
        result: result,
      ),
    );
  }
}
