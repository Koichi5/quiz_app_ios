import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/presentation/screens/category_list_screen.dart';
import 'package:quiz_app/presentation/screens/dictionary_screen.dart';
import 'package:quiz_app/presentation/screens/home_screen.dart';
import 'package:quiz_app/presentation/screens/intro_slider_screen.dart';
import 'package:quiz_app/presentation/screens/login_screen.dart';
import 'package:quiz_app/presentation/screens/original_question_list_screen.dart';
import 'package:quiz_app/presentation/screens/original_question_set_screen.dart';
import 'package:quiz_app/presentation/screens/quiz_history_screen.dart';
import 'package:quiz_app/presentation/screens/review_screen.dart';
import 'package:quiz_app/presentation/screens/setting_screen.dart';
import 'package:quiz_app/presentation/screens/signup_screen.dart';
import 'package:quiz_app/presentation/screens/weak_question_screen.dart';

part 'routers.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

@TypedGoRoute<RootRoute>(path: '/intro-slider')
class RootRoute extends GoRouteData {
  const RootRoute();
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      // intro なのか home なのか 空のScaffold なのか
      child: const IntroSliderScreen(),
    );
  }
}

// auth routes
@TypedGoRoute<SignupRoute>(path: '/signup')
class SignupRoute extends GoRouteData {
  const SignupRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const SignupScreen(),
    );
  }
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const LoginScreen(),
    );
  }
}

// category routes
@TypedGoRoute<CategoryListRoute>(
  path: '/category-list',
)
class CategoryListRoute extends GoRouteData {
  const CategoryListRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
        key: state.pageKey, child: const CategoryListScreen());
  }
}

// original question routes
@TypedGoRoute<OriginalQuestionListRoute>(
    path: '/original-question-list',
    routes: [
      TypedGoRoute<OriginalQuestionSetRoute>(
        path: 'original-question-set',
      ),
    ])
class OriginalQuestionListRoute extends GoRouteData {
  const OriginalQuestionListRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: OriginalQuestionListScreen(),
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

// review routes
@TypedGoRoute<ReviewRoute>(
  path: '/review',
  routes: [
    TypedGoRoute<WeakQuestionRoute>(path: 'weak-question'),
    TypedGoRoute<QuizHistoryRoute>(path: 'quiz-history'),
  ],
)
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

// setting routes
@TypedGoRoute<SettingRoute>(path: '/setting', routes: [
  TypedGoRoute<DictionaryRoute>(path: 'dictionary'),
])
class SettingRoute extends GoRouteData {
  const SettingRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(key: state.pageKey, child: const SettingScreen());
  }
}

class DictionaryRoute extends GoRouteData {
  const DictionaryRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const DictionaryScreen(),
    );
  }
}
