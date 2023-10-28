import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/repository/auth_repository.dart';
import 'package:quiz_app/general/general_provider.dart';
import 'package:quiz_app/presentation/controller/auth_controller.dart';
import 'package:quiz_app/presentation/routers.dart';

class GoogleSignInButton extends HookConsumerWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    final authRepository = ref.watch(authRepositoryProvider);
    final isDark = isDarkMode(context);
    final textColor = isDark
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.onBackground;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.9,
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: textColor,
              ),
            ),
            onPressed: ([bool mounted = true]) async {
              await authController.signInWithGoogle();
              User? user = authRepository.getCurrentUser();
              if (user != null) {
                if (!mounted) return;
                //   Navigator.of(context).push(MaterialPageRoute(
                //       builder: (context) => const HomeScreen()));
                // }
                const HomeRoute().go(context);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/google_logo.png",
                  width: 20,
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Googleで続ける",
                    style: TextStyle(color: textColor),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
