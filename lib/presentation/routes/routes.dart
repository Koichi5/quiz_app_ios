import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/domain/category/category.dart';
import 'package:quiz_app/domain/dto/quiz_result.dart';
import 'package:quiz_app/domain/question/question.dart';
import 'package:quiz_app/presentation/screens/category_detail_screen.dart';
import 'package:quiz_app/presentation/screens/category_list_screen.dart';
import 'package:quiz_app/presentation/screens/dictionary_screen.dart';
import 'package:quiz_app/presentation/screens/home_screen.dart';
import 'package:quiz_app/presentation/screens/intro_slider_screen.dart';
import 'package:quiz_app/presentation/screens/login_screen.dart';
import 'package:quiz_app/presentation/screens/original_question_list_screen.dart';
import 'package:quiz_app/presentation/screens/original_question_quiz_screen.dart';
import 'package:quiz_app/presentation/screens/original_question_set_screen.dart';
import 'package:quiz_app/presentation/screens/quiz_history_screen.dart';
import 'package:quiz_app/presentation/screens/quiz_list_screen.dart';
import 'package:quiz_app/presentation/screens/quiz_result_screen.dart';
import 'package:quiz_app/presentation/screens/retry_quiz_screen.dart';
import 'package:quiz_app/presentation/screens/review_screen.dart';
import 'package:quiz_app/presentation/screens/setting_screen.dart';
import 'package:quiz_app/presentation/screens/signup_screen.dart';
import 'package:quiz_app/presentation/screens/weak_question_quiz_screen.dart';
import 'package:quiz_app/presentation/screens/weak_question_screen.dart';

part 'routes.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _categoryListNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'categoryListNav');
final GlobalKey<NavigatorState> _reviewNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'reviewNav');
final GlobalKey<NavigatorState> _originalQuestionListNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'originalQuestionListNav');
final GlobalKey<NavigatorState> _settingNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'settingNav');

// @TypedGoRoute<HomeRoute>(
//   path: '/',
// )
// class HomeRoute extends GoRouteData {
//   const HomeRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
// }

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

// ----- StatefulSellRoute -----

@TypedStatefulShellRoute<MyShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<BranchCategoryListData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<CategoryListRoute>(
          path: '/',
          routes: [
            TypedGoRoute<CategoryDetailRoute>(
              path: 'detal',
              routes: [
                TypedGoRoute<QuizListRoute>(
                  path: 'quiz-list',
                  routes: [
                    TypedGoRoute<QuizResultRoute>(
                      path: 'quiz-result',
                      routes: [
                        TypedGoRoute<RetryQuizRoute>(
                          path: 'retry-quiz',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<BranchReviewData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ReviewRoute>(
          path: '/review',
          routes: [
            TypedGoRoute<WeakQuestionListRoute>(
              path: 'weak-quesiton-list',
              routes: [
                TypedGoRoute<WeakQuestionQuizRoute>(
                  path: 'weak-question-quiz',
                ),
              ],
            ),
            TypedGoRoute<QuizHistoryRoute>(
              path: 'quiz-history',
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<BranchOriginalQuestionListData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<OriginalQuestionListRoute>(
          path: '/original-question-quiz',
          routes: [
            TypedGoRoute<OriginalQuestionQuizRoute>(
                path: 'original-question-quiz'),
            TypedGoRoute<OriginalQuestionSetRoute>(
              path: 'original-question-set',
            ),
            TypedGoRoute<OriginalQuestionQuizResultRoute>(
              path: 'quiz-result',
              routes: [
                TypedGoRoute<OriginalQuestionRetryQuizRoute>(
                  path: 'retry-quiz',
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<BranchSettingData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SettingRoute>(
          path: '/setting',
          routes: <TypedRoute<RouteData>>[
            TypedGoRoute<DictionaryRoute>(
              path: 'dictionary',
            ),
          ],
        ),
      ],
    ),
  ],
)

class MyShellRouteData extends StatefulShellRouteData {
  const MyShellRouteData();

  // static final GlobalKey<NavigatorState> $navigatorKey = rootNavigatorKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return navigationShell;
  }

  static const String $restorationScopeId = 'restorationScopeId';

  static Widget $navigatorContainerBuilder(BuildContext context,
      StatefulNavigationShell navigationShell, List<Widget> children) {
    return HomeScreen(
      navigationShell: navigationShell,
      children: children,
    );
  }
}

class BranchCategoryListData extends StatefulShellBranchData {
  const BranchCategoryListData();

  static final GlobalKey<NavigatorState> $navigatorKey =
      _categoryListNavigatorKey;
}

class BranchReviewData extends StatefulShellBranchData {
  BranchReviewData();

  static final GlobalKey<NavigatorState> $navigatorKey = _reviewNavigatorKey;
  static const String $restorationScopeId = 'restorationScopeId';
}

class BranchOriginalQuestionListData extends StatefulShellBranchData {
  BranchOriginalQuestionListData();

  static final GlobalKey<NavigatorState> $navigatorKey =
      _originalQuestionListNavigatorKey;
  static const String $restorationScopeId = 'restorationScopeId';
}

class BranchSettingData extends StatefulShellBranchData {
  BranchSettingData();

  static final GlobalKey<NavigatorState> $navigatorKey = _settingNavigatorKey;
  static const String $restorationScopeId = 'restorationScopeId';
}

// ----- StatefulSellRoute -----

// category routes
// @TypedGoRoute<CategoryListRoute>(path: '/category-list', routes: [
//   TypedGoRoute<CategoryDetailRoute>(
//     path: 'detal',
//   ),
// ])
class CategoryListRoute extends GoRouteData {
  const CategoryListRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
        key: state.pageKey, child: const CategoryListScreen());
  }
}

// @TypedGoRoute<CategoryDetailRoute>(
//   path: '/detail',
// )
class CategoryDetailRoute extends GoRouteData {
  const CategoryDetailRoute({required this.$extra});

  final Category $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: CategoryDetailScreen(
        category: $extra,
      ),
    );
  }
}

// @TypedGoRoute<QuizListRoute>(
//   path: '/quiz-list',
// )
class QuizListRoute extends GoRouteData {
  const QuizListRoute({required this.$extra});

  final Category $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: QuizListScreen(
        category: $extra,
      ),
    );
  }
}

// @TypedGoRoute<QuizResultRoute>(
//   path: '/quiz-result',
// )
class QuizResultRoute extends GoRouteData {
  const QuizResultRoute({required this.$extra});

  final QuizResult $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: QuizResultScreen(
        result: $extra,
      ),
    );
  }
}

// @TypedGoRoute<RetryQuizRoute>(
//   path: '/retry-quiz',
// )
class RetryQuizRoute extends GoRouteData {
  const RetryQuizRoute({required this.$extra});

  final List<Question> $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: RetryQuizScreen(
        questionList: $extra,
      ),
    );
  }
}

// original question
// @TypedGoRoute<OriginalQuestionQuizRoute>(
//   path: '/original-question-quiz',
// )

class OriginalQuestionQuizRoute extends GoRouteData {
  const OriginalQuestionQuizRoute({required this.$extra});

  final List<Question> $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: OriginalQuestionQuizScreen(
        originalQuestionList: $extra,
      ),
    );
  }
}

class OriginalQuestionQuizResultRoute extends GoRouteData {
  const OriginalQuestionQuizResultRoute({required this.$extra});

  final QuizResult $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: QuizResultScreen(
        result: $extra,
      ),
    );
  }
}

class OriginalQuestionRetryQuizRoute extends GoRouteData {
  const OriginalQuestionRetryQuizRoute({required this.$extra});

  final List<Question> $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: RetryQuizScreen(
        questionList: $extra,
      ),
    );
  }
}

// reivew
// @TypedGoRoute<WeakQuestionQuizRoute>(
//   path: '/review',
// )
class ReviewRoute extends GoRouteData {
  const ReviewRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(key: state.pageKey, child: const ReviewScreen());
  }
}

// @TypedGoRoute<WeakQuestionQuizRoute>(
//   path: '/weak-question-quiz',
// )

class WeakQuestionListRoute extends GoRouteData {
  const WeakQuestionListRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const WeakQuestionScreen(),
    );
  }
}

class WeakQuestionQuizRoute extends GoRouteData {
  const WeakQuestionQuizRoute({required this.$extra});

  final List<Question> $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: WeakQuestionQuizScreen(
        weakQuestionList: $extra,
      ),
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

// original question routes
// @TypedGoRoute<OriginalQuestionListRoute>(
//     path: '/original-question-list',
//     routes: [
//       TypedGoRoute<OriginalQuestionSetRoute>(
//         path: 'original-question-set',
//       ),
//     ])
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

// setting routes
// @TypedGoRoute<SettingRoute>(path: '/setting', routes: [
//   TypedGoRoute<DictionaryRoute>(path: 'dictionary'),
// ])
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
