import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/presentation/screens/dictionary_screen.dart';
import 'package:quiz_app/presentation/screens/setting_screen.dart';

const settingRoutes = TypedGoRoute<SettingRoute>(path: '/setting', routes: [
  TypedGoRoute<DictionaryRoute>(path: 'dictionary'),
]);

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
