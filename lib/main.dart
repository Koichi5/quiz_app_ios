import 'dart:developer';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/repository/auth_repository.dart';
import 'package:quiz_app/firebase_options.dart';
import 'package:quiz_app/presentation/routers.dart';
import 'package:quiz_app/presentation/screens/home_screen.dart';

import 'color_schemes.g.dart';
import 'presentation/screens/intro_slider_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    if (await AppTrackingTransparency.trackingAuthorizationStatus ==
        TrackingStatus.notDetermined) {
      await Future.delayed(const Duration(milliseconds: 1000));
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  } on PlatformException catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);

  final routerProvider = Provider<GoRouter>(
    (ref) {
      final authStateStream =
          ref.watch(authRepositoryProvider).authStateChanges;
      User? authState;

      authStateStream.listen((User? user) {
        authState = user;
      });

      return GoRouter(
        debugLogDiagnostics: true,
        routes: $appRoutes,
        redirect: (context, state) {
          final isSplash = state.uri.toString() == HomeScreen.routeLocation;
          log('[GoRouter] current route is ${state.uri.toString()}');
          if (isSplash) {
            log('authState: $authState');
            return authState == null
                ? IntroSliderScreen.routeLocation
                : HomeScreen.routeLocation;
          }
          return null;
        },
      );
    },
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    // return MaterialApp(
    //   title: 'Quiz-app',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
    //   darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
    //   home: StreamBuilder<User?>(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const SizedBox();
    //       }
    //       if (snapshot.hasData) {
    //         // User が null でなない、つまりサインイン済みのホーム画面へ
    //         return const HomeScreen();
    //       }
    //       // User が null である、つまり未サインインのサインイン画面へ
    //       return const IntroSliderScreen();
    //     },
    //   ),
    // );
    return MaterialApp.router(
      title: 'Quiz-app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      routerConfig: router,
    );
  }
}
