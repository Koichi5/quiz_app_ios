import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/presentation/screens/login_screen.dart';
import 'package:quiz_app/presentation/screens/signup_screen.dart';

const signupRoute = TypedGoRoute<SignupRoute>(path: '/signup');

class SignupRoute extends GoRouteData {
  const SignupRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(key: state.pageKey, child: const SignupScreen());
  }
}

const loginRoute = TypedGoRoute<LoginRoute>(path: '/login');

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
