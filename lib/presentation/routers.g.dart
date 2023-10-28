// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routers.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRoute,
      $rootRoute,
      $signupRoute,
      $loginRoute,
      $categoryListRoute,
      $originalQuestionListRoute,
      $reviewRoute,
      $settingRoute,
    ];

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeRouteExtension._fromState,
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

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

RouteBase get $categoryListRoute => GoRouteData.$route(
      path: '/category-list',
      factory: $CategoryListRouteExtension._fromState,
    );

extension $CategoryListRouteExtension on CategoryListRoute {
  static CategoryListRoute _fromState(GoRouterState state) =>
      const CategoryListRoute();

  String get location => GoRouteData.$location(
        '/category-list',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $originalQuestionListRoute => GoRouteData.$route(
      path: '/original-question-list',
      factory: $OriginalQuestionListRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'original-question-set',
          factory: $OriginalQuestionSetRouteExtension._fromState,
        ),
      ],
    );

extension $OriginalQuestionListRouteExtension on OriginalQuestionListRoute {
  static OriginalQuestionListRoute _fromState(GoRouterState state) =>
      const OriginalQuestionListRoute();

  String get location => GoRouteData.$location(
        '/original-question-list',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OriginalQuestionSetRouteExtension on OriginalQuestionSetRoute {
  static OriginalQuestionSetRoute _fromState(GoRouterState state) =>
      const OriginalQuestionSetRoute();

  String get location => GoRouteData.$location(
        '/original-question-list/original-question-set',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $reviewRoute => GoRouteData.$route(
      path: '/review',
      factory: $ReviewRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'weak-question',
          factory: $WeakQuestionRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'quiz-history',
          factory: $QuizHistoryRouteExtension._fromState,
        ),
      ],
    );

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

extension $WeakQuestionRouteExtension on WeakQuestionRoute {
  static WeakQuestionRoute _fromState(GoRouterState state) =>
      const WeakQuestionRoute();

  String get location => GoRouteData.$location(
        '/review/weak-question',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
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

RouteBase get $settingRoute => GoRouteData.$route(
      path: '/setting',
      factory: $SettingRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'dictionary',
          factory: $DictionaryRouteExtension._fromState,
        ),
      ],
    );

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
