import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/domain/repository/auth_repository.dart';
import 'package:quiz_app/presentation/controller/auth_controller.dart';
import 'package:quiz_app/presentation/controller/signup_text_controller.dart';
import 'package:quiz_app/presentation/controller/validator/signup_validator_provider.dart';
import 'package:quiz_app/presentation/screens/home_screen.dart';
import 'package:quiz_app/presentation/widgets/apple_signin_button.dart';
import 'package:quiz_app/presentation/widgets/custom_text_field.dart';
import 'package:quiz_app/presentation/widgets/google_signin_button.dart';
import 'package:quiz_app/presentation/widgets/link_button.dart';
import 'package:quiz_app/presentation/widgets/signup_button.dart';

class SignupScreen extends HookConsumerWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final emailController = ref.watch(signupEmailControllerStateProvider);
    final passwordController = ref.watch(signupPasswordControllerStateProvider);
    final obscureText = ref.watch(signupObscureTextStateProvider);
    final obscureTextControllerNotifier =
        ref.watch(signupObscureTextStateProvider.notifier);
    final signupValidator = ref.watch(signupValidatorProvider);
    final signupValidatorNotifier = ref.watch(signupValidatorProvider.notifier);

    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 0.025 * screenHeight),
              _buildCustomTextField(
                "メールアドレス",
                emailController,
                signupValidator.form.email.errorMessage,
                screenWidth,
                (email) {
                  signupValidatorNotifier.setEmail(email);
                },
                false,
              ),
              SizedBox(height: 0.05 * screenHeight),
              _buildCustomTextField(
                  "パスワード",
                  passwordController,
                  signupValidator.form.password.errorMessage,
                  screenWidth,
                  (password) {
                    signupValidatorNotifier.setPassword(password);
                  },
                  true,
                  obscureText: obscureText,
                  toggleObscureText: () {
                    obscureTextControllerNotifier.state = !obscureText;
                  }),
              SizedBox(height: 0.04 * screenHeight),
              SignUpButton(emailController.text, passwordController.text),
              SizedBox(height: 0.04 * screenHeight),
              _buildAnnonymousSignupButton(context, ref, screenWidth),
              SizedBox(height: 0.02 * screenHeight),
              _buildDivider(screenWidth),
              const Padding(
                padding: EdgeInsets.all(6.0),
                child: GoogleSignInButton(),
              ),
              const Padding(
                padding: EdgeInsets.all(6.0),
                child: AppleSignInButton(),
              ),
              _buildLoginButton(context, screenWidth),
              _buildTermsAndPrivacyText(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text("新規登録"),
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildCustomTextField(
      String title,
      TextEditingController controller,
      String? error,
      double screenWidth,
      ValueChanged<String> onChanged,
      bool isPassword,
      {bool obscureText = false,
      VoidCallback? toggleObscureText}) {
    return SizedBox(
      width: 0.9 * screenWidth,
      child: CustomTextField(
        title: title,
        controller: controller,
        error: error,
        onChanged: onChanged,
        obscureText: obscureText,
        suffixIcon: isPassword
            ? IconButton(
                onPressed: toggleObscureText,
                icon:
                    Icon(obscureText ? Icons.visibility_off : Icons.visibility),
              )
            : null,
      ),
    );
  }

  Widget _buildAnnonymousSignupButton(
      BuildContext context, WidgetRef ref, double screenWidth) {
    return SizedBox(
      height: 40,
      width: 0.9 * screenWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary),
        onPressed: () async {
          await ref.watch(authControllerProvider.notifier).signInAnnonymously();
          User? user = ref.watch(authRepositoryProvider).getCurrentUser();
          if (user != null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        },
        child: Text(
          "アカウントなしで登録",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }

  Widget _buildDivider(double screenWidth) {
    return Divider(
      height: 0.05 * screenWidth,
      thickness: 0.5,
      indent: 0.05 * screenWidth,
      endIndent: 0.05 * screenWidth,
      color: Colors.grey[400],
    );
  }

  Widget _buildLoginButton(BuildContext context, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: 0.9 * screenWidth,
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: const Text("アカウントをお持ちの方はこちら",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildTermsAndPrivacyText(BuildContext context) {
    final linkButton = LinkButton();
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              const TextSpan(
                  text: '登録をすることで',
                  style: TextStyle(color: Colors.black, fontSize: 12)),
              TextSpan(
                  text: '利用規約',
                  style: const TextStyle(color: Colors.blue, fontSize: 12),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      linkButton.launchUriWithString(
                          context, "https://terms-of-service-tech.web.app/");
                    }),
              const TextSpan(
                  text: "と",
                  style: TextStyle(color: Colors.black, fontSize: 12)),
              TextSpan(
                  text: 'プライバシーポリシー',
                  style: const TextStyle(color: Colors.blue, fontSize: 12),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      linkButton.launchUriWithString(
                          context, "https://quiz-app-dc8a1.web.app");
                    }),
            ],
          ),
        ),
        const Text("に同意したことになります", style: TextStyle(fontSize: 12)),
        const Text("ご利用になる前に必ずお読みください", style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
