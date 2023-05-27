import 'package:flutter/material.dart';

class ThemeSnackBar {
  ThemeSnackBar();

  static SnackBar getSnackBar(String text) {
    return SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
    );
  }

  static showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    return ScaffoldMessenger.of(context)
        .showSnackBar(ThemeSnackBar.getSnackBar(text));
  }
}
