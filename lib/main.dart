import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/firebase_options.dart';
import 'package:quiz_app/general/custom_exception.dart';
import 'package:quiz_app/presentation/routes/routes.dart';

import 'color_schemes.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    if (await AppTrackingTransparency.trackingAuthorizationStatus ==
        TrackingStatus.notDetermined) {
      await Future.delayed(
        const Duration(
          milliseconds: 1000,
        ),
      );
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  } on PlatformException catch (e) {
    throw CustomException(message: e.message);
  }
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final rotuerProvider = Provider<GoRouter>(
  (ref) {
    // final authStateStream = FirebaseAuth.instance.authStateChanges();
    // User? authState;

    // authStateStream.listen((User? user) {
    //   authState = user;
    // });

    return GoRouter(
      debugLogDiagnostics: true,
      routes: $appRoutes,
      // redirect: (context, state) {
      // final isSplash = state.uri.toString() == HomeScreen.routeLocation;
      // if (isSplash) {
      //   return authState == null
      //       ? IntroSliderScreen.routeLocation
      //       : HomeScreen.routeLocation;
      // }
      // return null;
      // },
    );
  },
);

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(rotuerProvider);
    return MaterialApp.router(
      title: 'Quiz-app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        fontFamily: "Noto Sans JP",
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: "Noto Sans JP",
      ),
      routerConfig: router,
      // routes: {
      //   '/home': (BuildContext context) => const HomeScreen(),
      //   '/signup': (BuildContext context) => const SignupScreen(),
      //   '/login': (BuildContext context) => const LoginScreen(),
      // },
      // home: StreamBuilder<User?>(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const SizedBox();
      //     }
      //     if (snapshot.hasData) {
      //       // User が null でなない、つまりサインイン済みのホーム画面へ
      //       return const HomeScreen();
      //     }
      //     // User が null である、つまり未サインインのサインイン画面へ
      //     return const IntroSliderScreen();
      //   },
      // ),
    );
  }
}
