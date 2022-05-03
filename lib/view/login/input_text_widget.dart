import 'package:flutter/material.dart';

/// Wrapper para TextFormField
class InputText extends StatelessWidget {
  /// label - Nome do campo
  /// validator - Callback function
  /// obscureText - Se e um campo de password
  InputText({
    Key? key,
    required this.label,
    this.validator,
    this.obscureText = false,
    this.type,
  }) : super(key: key);

  final TextInputType? type;
  final String label;
  bool obscureText;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 14),
      validator: validator,
      keyboardType: type,
      textInputAction: TextInputAction.next,
      // textAlign: TextAlign.center,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: label,
          contentPadding: const EdgeInsets.all(10),
          // floatingLabelAlignment: FloatingLabelAlignment.center,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(90)))),
    );
  }
}
