import 'package:flutter/material.dart';
import 'package:social_app/Core/utils/styles.dart';

class LoginHeaderSection extends StatelessWidget {
  const LoginHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        'Welcome Back !',
        textAlign: TextAlign.center,
        style: Styles.textStyle34,
      ),
    );
  }
}
