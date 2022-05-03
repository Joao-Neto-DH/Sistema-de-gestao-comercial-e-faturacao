import 'package:flutter/material.dart';

/// Campo de texto formatado
class TextFormFieldDecorated extends StatelessWidget {
  TextFormFieldDecorated(
      {Key? key,
      required this.hintText,
      this.validator,
      this.keyboardType,
      this.enabled})
      : super(key: key);
  String? Function(String?)? validator;
  String? hintText;
  TextInputType? keyboardType;
  bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          hintText: hintText, border: const OutlineInputBorder()),
    );
  }
}
