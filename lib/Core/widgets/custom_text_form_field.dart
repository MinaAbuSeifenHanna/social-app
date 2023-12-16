import 'package:flutter/material.dart';
import 'package:social_app/Core/utils/styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.border = const OutlineInputBorder(),
    this.maxLines = 1,
    this.validator,
  });

  final TextEditingController controller;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final InputBorder? border;
  final int? maxLines;

  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        border: border,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorStyle: Styles.textStyle16,
      ),
      style: Styles.textStyle18,
      obscureText: obscureText,
    );
  }
}
