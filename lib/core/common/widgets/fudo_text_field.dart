import 'package:flutter/material.dart';

class FudoTextField extends StatelessWidget {
  const FudoTextField({
    super.key,
    this.labelText,
    this.controller,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText, hintText: hintText),
      validator: validator,
      obscureText: obscureText,
      onChanged: onChanged,
    );
  }
}
