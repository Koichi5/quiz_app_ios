import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/general/general_provider.dart';
import 'package:quiz_app/presentation/controller/auth_controller/auth_controller.dart';
import 'package:quiz_app/presentation/routes/routes.dart';

class AppleSignInButton extends HookConsumerWidget {
  const AppleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDark = isDarkMode(context);
    final authControllerProviderNotifier =
        ref.watch(authControllerProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        width: screenWidth * 0.9,
        child: _buildOutlinedButton(
            context, authControllerProviderNotifier, isDark),
      ),
    );
  }

  OutlinedButton _buildOutlinedButton(BuildContext context,
      AuthController authControllerProviderNotifier, bool isDark) {
    final themeColor = isDark
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.onBackground;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: themeColor),
      ),
      onPressed: () async {
        User? user = await authControllerProviderNotifier.signInWithApple();
        if (user != null) {
          CategoryListRoute().go(context);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            isDark
                ? "assets/images/apple_logo_dark.png"
                : "assets/images/apple_logo.png",
            width: 20,
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Appleで続ける",
              style: TextStyle(color: themeColor),
            ),
          ),
        ],
      ),
    );
  }
}
