import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/repository/auth_repository/auth_repository.dart';
import 'package:quiz_app/presentation/controller/auth_controller/auth_controller.dart';
import 'package:quiz_app/presentation/controller/validator/signup_validator_provider.dart';
import 'package:quiz_app/presentation/routes/routes.dart';

class SignUpButton extends HookConsumerWidget {
  const SignUpButton(this.email, this.password, {super.key});
  final String email;
  final String password;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authControllerProviderNotifier =
    // ref.watch(authControllerProvider.notifier);
    final authRepositoryProviderNotifier = ref.watch(authRepositoryProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: ref.watch(signupValidatorProvider).form.isValid
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary),
            onPressed: ([bool mounted = true]) async {
              if (ref.watch(signupValidatorProvider).form.isValid) {
                await ref
                    .watch(authControllerProvider.notifier)
                    .createUserWithEmailAndPassword(email, password);
                User? user = authRepositoryProviderNotifier.getCurrentUser();
                if (user != null) {
                  if (!mounted) return;
                  const CategoryListRoute().pushReplacement(context);
                }
              } else {
                null;
              }
            },
            child: Text(
              "新 規 登 録",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            )),
      ),
    );
  }
}
