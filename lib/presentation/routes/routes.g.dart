// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $rootRoute,
      $signupRoute,
      $loginRoute,
      $myShellRouteData,
    ];

RouteBase get $rootRoute => GoRouteData.$route(
      path: '/intro-slider',
      factory: $RootRouteExtension._fromState,
    );

extension $RootRouteExtension on RootRoute {
  static RootRoute _fromState(GoRouterState state) => const RootRoute();

  String get location => GoRouteData.$location(
        '/intro-slider',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signupRoute => GoRouteData.$route(
      path: '/signup',
      factory: $SignupRouteExtension._fromState,
    );

extension $SignupRouteExtension on SignupRoute {
  static SignupRoute _fromState(GoRouterState state) => const SignupRoute();

  String get location => GoRouteData.$location(
        '/signup',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginRouteExtension._fromState,
    );

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  String get location => GoRouteData.$location(
        '/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $myShellRouteData => StatefulShellRouteData.$route(
      restorationScopeId: MyShellRouteData.$restorationScopeId,
      navigatorContainerBuilder: MyShellRouteData.$navigatorContainerBuilder,
      factory: $MyShellRouteDataExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          navigatorKey: BranchCategoryListData.$navigatorKey,
          routes: [
            GoRouteData.$route(
              path: '/',
              factory: $CategoryListRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'detal',
                  factory: $CategoryDetailRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'quiz-list',
                      factory: $QuizListRouteExtension._fromState,
                      routes: [
                        GoRouteData.$route(
                          path: 'quiz-result',
                          factory: $QuizResultRouteExtension._fromState,
                          routes: [
                            GoRouteData.$route(
                              path: 'retry-quiz',
                              factory: $RetryQuizRouteExtension._fromState,
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
        StatefulShellBranchData.$branch(
          navigatorKey: BranchReviewData.$navigatorKey,
          restorationScopeId: BranchReviewData.$restorationScopeId,
          routes: [
            GoRouteData.$route(
              path: '/review',
              factory: $ReviewRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'weak-quesiton-list',
                  factory: $WeakQuestionListRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'weak-question-quiz',
                      factory: $WeakQuestionQuizRouteExtension._fromState,
                    ),
                  ],
                ),
                GoRouteData.$route(
                  path: 'quiz-history',
                  factory: $QuizHistoryRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          navigatorKey: BranchOriginalQuestionListData.$navigatorKey,
          restorationScopeId:
              BranchOriginalQuestionListData.$restorationScopeId,
          routes: [
            GoRouteData.$route(
              path: '/original-question-quiz',
              factory: $OriginalQuestionListRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'original-question-quiz',
                  factory: $OriginalQuestionQuizRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'original-question-set',
                  factory: $OriginalQuestionSetRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'quiz-result',
                  factory: $OriginalQuestionQuizResultRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'retry-quiz',
                      factory:
                          $OriginalQuestionRetryQuizRouteExtension._fromState,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          navigatorKey: BranchSettingData.$navigatorKey,
          restorationScopeId: BranchSettingData.$restorationScopeId,
          routes: [
            GoRouteData.$route(
              path: '/setting',
              factory: $SettingRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'dictionary',
                  factory: $DictionaryRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $MyShellRouteDataExtension on MyShellRouteData {
  static MyShellRouteData _fromState(GoRouterState state) =>
      const MyShellRouteData();
}

extension $CategoryListRouteExtension on CategoryListRoute {
  static CategoryListRoute _fromState(GoRouterState state) =>
      const CategoryListRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CategoryDetailRouteExtension on CategoryDetailRoute {
  static CategoryDetailRoute _fromState(GoRouterState state) =>
      CategoryDetailRoute(
        $extra: state.extra as Category,
      );

  String get location => GoRouteData.$location(
        '/detal',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $QuizListRouteExtension on QuizListRoute {
  static QuizListRoute _fromState(GoRouterState state) => QuizListRoute(
        $extra: state.extra as Category,
      );

  String get location => GoRouteData.$location(
        '/detal/quiz-list',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $QuizResultRouteExtension on QuizResultRoute {
  static QuizResultRoute _fromState(GoRouterState state) => QuizResultRoute(
        $extra: state.extra as QuizResult,
      );

  String get location => GoRouteData.$location(
        '/detal/quiz-list/quiz-result',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $RetryQuizRouteExtension on RetryQuizRoute {
  static RetryQuizRoute _fromState(GoRouterState state) => RetryQuizRoute(
        $extra: state.extra as List<Question>,
      );

  String get location => GoRouteData.$location(
        '/detal/quiz-list/quiz-result/retry-quiz',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $ReviewRouteExtension on ReviewRoute {
  static ReviewRoute _fromState(GoRouterState state) => const ReviewRoute();

  String get location => GoRouteData.$location(
        '/review',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WeakQuestionListRouteExtension on WeakQuestionListRoute {
  static WeakQuestionListRoute _fromState(GoRouterState state) =>
      const WeakQuestionListRoute();

  String get location => GoRouteData.$location(
        '/review/weak-quesiton-list',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WeakQuestionQuizRouteExtension on WeakQuestionQuizRoute {
  static WeakQuestionQuizRoute _fromState(GoRouterState state) =>
      WeakQuestionQuizRoute(
        $extra: state.extra as List<Question>,
      );

  String get location => GoRouteData.$location(
        '/review/weak-quesiton-list/weak-question-quiz',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $QuizHistoryRouteExtension on QuizHistoryRoute {
  static QuizHistoryRoute _fromState(GoRouterState state) =>
      const QuizHistoryRoute();

  String get location => GoRouteData.$location(
        '/review/quiz-history',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OriginalQuestionListRouteExtension on OriginalQuestionListRoute {
  static OriginalQuestionListRoute _fromState(GoRouterState state) =>
      const OriginalQuestionListRoute();

  String get location => GoRouteData.$location(
        '/original-question-quiz',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OriginalQuestionQuizRouteExtension on OriginalQuestionQuizRoute {
  static OriginalQuestionQuizRoute _fromState(GoRouterState state) =>
      OriginalQuestionQuizRoute(
        $extra: state.extra as List<Question>,
      );

  String get location => GoRouteData.$location(
        '/original-question-quiz/original-question-quiz',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $OriginalQuestionSetRouteExtension on OriginalQuestionSetRoute {
  static OriginalQuestionSetRoute _fromState(GoRouterState state) =>
      const OriginalQuestionSetRoute();

  String get location => GoRouteData.$location(
        '/original-question-quiz/original-question-set',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OriginalQuestionQuizResultRouteExtension
    on OriginalQuestionQuizResultRoute {
  static OriginalQuestionQuizResultRoute _fromState(GoRouterState state) =>
      OriginalQuestionQuizResultRoute(
        $extra: state.extra as QuizResult,
      );

  String get location => GoRouteData.$location(
        '/original-question-quiz/quiz-result',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $OriginalQuestionRetryQuizRouteExtension
    on OriginalQuestionRetryQuizRoute {
  static OriginalQuestionRetryQuizRoute _fromState(GoRouterState state) =>
      OriginalQuestionRetryQuizRoute(
        $extra: state.extra as List<Question>,
      );

  String get location => GoRouteData.$location(
        '/original-question-quiz/quiz-result/retry-quiz',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $SettingRouteExtension on SettingRoute {
  static SettingRoute _fromState(GoRouterState state) => const SettingRoute();

  String get location => GoRouteData.$location(
        '/setting',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DictionaryRouteExtension on DictionaryRoute {
  static DictionaryRoute _fromState(GoRouterState state) =>
      const DictionaryRoute();

  String get location => GoRouteData.$location(
        '/setting/dictionary',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
