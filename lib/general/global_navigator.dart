import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class GlobalNavigator {
  static void showErrorDialog(
      String title,
      String description, {
        String buttonText = 'OK',
        void Function()? onButtonPressed,
      }) {
    if (navigatorKey.currentContext == null) {
      return;
    }
    showDialog(context: navigatorKey.currentContext!, builder: (context) {
      return SimpleDialog(
        title: Text(title),
        children: [
          Text(description),
        ],
      );
    });
  }

  static void pop() {
    if (navigatorKey.currentContext == null) {
      return;
    }
    Navigator.of(navigatorKey.currentContext!).pop();
  }
}
