import 'package:flutter/material.dart';

import '../color.dart';

class AppTextFormField extends StatelessWidget {
  final String hint;
  const AppTextFormField({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: font, fontWeight: FontWeight.w500),
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: button,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
              borderSide: BorderSide.none)),
    );
  }
}
