import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinkButton {
  Future<void> launchUriWithString(BuildContext context, String url,
      [bool mounted = true]) async {
    final canLaunch = await canLaunchUrlString(url);
    if (!canLaunch || !mounted) {
      _showErrorSnackBar(context);
      return;
    }

    try {
      await launchUrlString(url);
    } catch (e) {
      _showErrorSnackBar(context);
    }
  }

  void _showErrorSnackBar(BuildContext context) {
    final alertSnackBar = SnackBar(
      content: const Text('このURLは開けませんでした'),
      action: SnackBarAction(
        label: '戻る',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(alertSnackBar);
  }
}
