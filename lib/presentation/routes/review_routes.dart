import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/presentation/screens/quiz_history_screen.dart';
import 'package:quiz_app/presentation/screens/review_screen.dart';
import 'package:quiz_app/presentation/screens/weak_question_screen.dart';

const reviewRoutes = TypedGoRoute<ReviewRoute>(
  path: '/review',
  routes: [
    TypedGoRoute<WeakQuestionRoute>(path: 'weak-question'),
    TypedGoRoute<QuizHistoryRoute>(path: 'quiz-history'),
  ],
);

class ReviewRoute extends GoRouteData {
  const ReviewRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(key: state.pageKey, child: const ReviewScreen());
  }
}

class WeakQuestionRoute extends GoRouteData {
  const WeakQuestionRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const WeakQuestionScreen(),
    );
  }
}

class QuizHistoryRoute extends GoRouteData {
  const QuizHistoryRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const QuizHistoryScreen(),
    );
  }
}
