import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/presentation/screens/original_question_list_screen.dart';
import 'package:quiz_app/presentation/screens/original_question_set_screen.dart';

const originalQuestionRoutes = TypedGoRoute<OriginalQuestionListRoute>(
    path: '/original-question-list',
    routes: [
      TypedGoRoute<OriginalQuestionSetRoute>(path: 'original-question-set'),
    ]);

class OriginalQuestionListRoute extends GoRouteData {
  const OriginalQuestionListRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const OriginalQuestionListScreen(),
    );
  }
}

class OriginalQuestionSetRoute extends GoRouteData {
  const OriginalQuestionSetRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const OriginalQuestionSetScreen(),
    );
  }
}
