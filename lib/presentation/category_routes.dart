import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/domain/category/category.dart';
import 'package:quiz_app/presentation/screens/category_detail_screen.dart';
// import 'package:quiz_app/domain/category/category.dart';
// import 'package:quiz_app/presentation/screens/category_detail_screen.dart';
import 'package:quiz_app/presentation/screens/category_list_screen.dart';

const categoryRoutes = TypedGoRoute<CategoryListRoute>(
  path: '/category-list',
  routes: [
    TypedGoRoute<CategoryDetailRoute>(path: 'detail'),
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
