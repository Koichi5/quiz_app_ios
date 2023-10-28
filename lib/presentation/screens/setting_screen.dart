import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/general/general_provider.dart';
import 'package:quiz_app/presentation/controller/auth_controller.dart';
import 'package:quiz_app/presentation/controller/deleted_user_controller.dart';
import 'package:quiz_app/presentation/routers.dart';
import 'package:quiz_app/presentation/widgets/link_button.dart';

class SettingScreen extends HookConsumerWidget {
  const SettingScreen({Key? key}) : super(key: key);
  static String get routeName => 'setting';
  static String get routeLocation => '/$routeName';
  static const _labelTextList = [
    "利用規約",
    "プライバシーポリシー",
    "Twitter",
    "Instagram",
    "単語集",
    "ログアウト",
    "アカウント削除",
  ];
  static const _linkURLs = [
    "https://terms-of-service-tech.web.app/",
    "https://quiz-app-dc8a1.web.app",
    "https://twitter.com/TechJourneyApp",
    "https://www.instagram.com/techjourneyapp/",
  ];
  static final _leadingWidget = [
    _buildIcon(Icons.list_alt),
    _buildIcon(Icons.privacy_tip_outlined),
    _buildImage("assets/images/twitter.png"),
    _buildImage("assets/images/instagram.png"),
    _buildIcon(Icons.bookmark_outline),
    _buildIcon(Icons.logout),
    _buildIcon(Icons.person_remove),
  ];

  static Icon _buildIcon(IconData data) =>
      Icon(data, size: 30, color: Colors.grey);

  static Image _buildImage(String path) =>
      Image.asset(path, width: 30, height: 30);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onTapList = _buildOnTapList(context, ref);

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: _labelTextList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(_labelTextList[index]),
          leading: _leadingWidget[index],
          trailing: const Icon(Icons.arrow_forward_ios, size: 20),
          onTap: onTapList[index],
        );
      },
    );
  }

  List<VoidCallback?> _buildOnTapList(BuildContext context, WidgetRef ref) {
    final linkButton = LinkButton();
    return [
      () => linkButton.launchUriWithString(context, _linkURLs[0]),
      () => linkButton.launchUriWithString(context, _linkURLs[1]),
      () => linkButton.launchUriWithString(context, _linkURLs[2]),
      () => linkButton.launchUriWithString(context, _linkURLs[3]),
      // () => Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const DictionaryScreen())),
      () => const DictionaryRoute().go(context),
      () => _showLogoutDialog(context, ref),
      () => _showDeleteAccountDialog(context, ref),
    ];
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) => _buildDialog(
        context,
        "ログアウトしますか？",
        () async {
          await ref
              .watch(authControllerProvider.notifier)
              .signOut()
              .then((value) {
            if (ref.watch(firebaseAuthProvider).currentUser == null) {
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (context) => const LoginScreen()));
              const LoginRoute().pushReplacement(context);
            }
          });
        },
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) => _buildDialog(
        context,
        "アカウントを削除しますか？",
        () async {
          await ref
              .watch(deletedUserControllerProvider.notifier)
              .deleteUser()
              .then((value) {
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => const LoginScreen()));
            const LoginRoute().pushReplacement(context);
          });
        },
      ),
    );
  }

  SimpleDialog _buildDialog(
      BuildContext context, String message, VoidCallback onConfirm) {
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(child: Text(message, textAlign: TextAlign.center)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("いいえ")),
            TextButton(
              onPressed: onConfirm,
              child: const Text("はい",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }
}
