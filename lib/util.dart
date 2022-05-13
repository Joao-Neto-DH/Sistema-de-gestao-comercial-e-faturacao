import 'package:flutter/material.dart';

class AppUtil {
  static const defaultPadding =
      Padding(padding: EdgeInsets.symmetric(vertical: 10));
  static const paddingBody = EdgeInsets.all(16);
  static const spaceLabelField = SizedBox(
    height: 16,
  );
  static const spaceFields = SizedBox(
    height: 24,
  );
  static const styleHeader =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static void snackBar(BuildContext context, String info) {
    final snackBar =
        SnackBar(duration: const Duration(seconds: 3), content: Text(info));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
