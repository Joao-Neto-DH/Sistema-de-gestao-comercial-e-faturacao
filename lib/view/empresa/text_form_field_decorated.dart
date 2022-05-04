import 'package:flutter/material.dart';

/// Campo de texto formatado
// ignore: must_be_immutable
class TextFormFieldDecorated extends StatelessWidget {
  TextFormFieldDecorated(
      {Key? key,
      this.hintText,
      this.validator,
      this.keyboardType,
      this.enabled,
      this.initialValue})
      : super(key: key);
  String? Function(String?)? validator;
  String? hintText;
  TextInputType? keyboardType;
  bool? enabled;
  String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      enabled: enabled,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          hintText: hintText, border: const OutlineInputBorder()),
    );
  }
}
