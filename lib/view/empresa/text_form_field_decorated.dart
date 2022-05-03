import 'package:flutter/material.dart';

/// Campo de ytexto formatado
class TextFormFieldDecorated extends StatelessWidget {
  TextFormFieldDecorated({Key? key, required this.hintText, this.validator})
      : super(key: key);
  String? Function(String?)? validator;
  String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
          hintText: hintText, border: const OutlineInputBorder()),
    );
  }
}
