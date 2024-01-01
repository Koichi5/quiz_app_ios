import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAlertDialog {
  static void showCustomAlert(
      BuildContext context, String title, String message,
      {String buttonText = "OK"}) {
    var alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        ElevatedButton(
            onPressed: () {
              context.pop();
            },
            child: Text(buttonText)),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
