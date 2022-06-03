import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  static String formatNumber(double number) {
    final format = NumberFormat("#,###.00 Kz", "pt_BR");
    return format.format(number);
  }

  static double toNumber(String number) {
    // final format = NumberFormat("#,###.00 Kz", "pt_BR");
    // print(number.replaceAll(RegExp(r'.'), ''));
    return double.tryParse(number
            .replaceFirst(r'Kz', '')
            .replaceAll(r'.', "")
            .replaceFirst(r',', '.')) ??
        0;
  }
}
