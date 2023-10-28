import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/presentation/controller/auth_controller.dart';
import 'package:quiz_app/presentation/controller/validator/login_validator_provider.dart';
import 'package:quiz_app/presentation/routers.dart';

class LoginButton extends HookConsumerWidget {
  const LoginButton(this.email, this.password, {super.key});

  final String email;
  final String password;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerProviderNotifier =
        ref.watch(authControllerProvider.notifier);

    Color getButtonColor() {
      final isValid = ref.watch(loginValidatorProvider).form.isValid;
      final theme = Theme.of(context).colorScheme;
      return isValid ? theme.primary : theme.secondary;
    }

    void showErrorDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                  child: Text(
                "メールアドレスまたはパスワードが\n 正しくありません",
                textAlign: TextAlign.center,
              )),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("戻る"))
          ]);
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: getButtonColor()),
            onPressed: ([bool mounted = true]) async {
              if (ref.watch(loginValidatorProvider).form.isValid) {
                User? user = await authControllerProviderNotifier
                    .signInWithEmailAndPassword(email, password);
                if (user != null) {
                  if (!mounted) return;
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //     builder: (context) => const HomeScreen()));
                  const HomeRoute().pushReplacement(context);
                } else {
                  showErrorDialog();
                }
              }
            },
            child: Text(
              "ロ グ イ ン",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            )),
      ),
    );
  }
}
