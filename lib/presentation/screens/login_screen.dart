import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/presentation/controller/login_text_controller/login_text_controller.dart';
import 'package:quiz_app/presentation/controller/validator/login_validator_provider.dart';
import 'package:quiz_app/presentation/screens/signup_screen.dart';
import 'package:quiz_app/presentation/widgets/apple_signin_button.dart';
import 'package:quiz_app/presentation/widgets/custom_text_field.dart';
import 'package:quiz_app/presentation/widgets/google_signin_button.dart';
import 'package:quiz_app/presentation/widgets/login_button.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final emailControllerProvider =
        ref.watch(loginEmailControllerStateProvider);
    final passwordControllerProvider =
        ref.watch(loginPasswordControllerStateProvider);
    final obscureText = ref.watch(loginObscureTextStateProvider);
    final obscureTextControllerNotifier =
        ref.watch(loginObscureTextStateProvider.notifier);
    final loginValidator = ref.watch(loginValidatorProvider);
    final loginValidatorNotifier = ref.watch(loginValidatorProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("ログイン"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenSize.height * 0.1),
            SizedBox(
              width: screenSize.width * 0.9,
              child: CustomTextField(
                title: "メールアドレス",
                controller: emailControllerProvider,
                error: loginValidator.form.email.errorMessage,
                onChanged: (email) {
                  loginValidatorNotifier.setEmail(email);
                },
              ),
            ),
            SizedBox(height: screenSize.height * 0.05),
            SizedBox(
              width: screenSize.width * 0.9,
              child: CustomTextField(
                title: "パスワード",
                controller: passwordControllerProvider,
                obscureText: obscureText,
                error: loginValidator.form.password.errorMessage,
                onChanged: (password) {
                  loginValidatorNotifier.setPassword(password);
                },
                suffixIcon: IconButton(
                  onPressed: () {
                    obscureTextControllerNotifier.toggle();
                  },
                  icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility),
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.04),
            LoginButton(
                emailControllerProvider.text, passwordControllerProvider.text),
            Divider(
              height: screenSize.height * 0.05,
              thickness: 0.5,
              indent: screenSize.width * 0.05,
              endIndent: screenSize.width * 0.05,
              color: Theme.of(context).colorScheme.primary,
            ),
            const Padding(
              padding: EdgeInsets.all(6.0),
              child: GoogleSignInButton(),
            ),
            const Padding(
              padding: EdgeInsets.all(6.0),
              child: AppleSignInButton(),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupScreen()));
                },
                child: const Text(
                  "新規登録はこちら",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
