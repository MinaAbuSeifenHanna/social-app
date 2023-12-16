import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/Core/utils/app_router.dart';
import 'package:social_app/Core/utils/my_colors.dart';

import '../../../../../Core/utils/styles.dart';

class LoginToRegisterSection extends StatelessWidget {
  const LoginToRegisterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account?',
          style: Styles.textStyle16,
        ),
        TextButton(
          onPressed: () => GoRouter.of(context).go(AppRouter.kRegisterView),
          child: Text(
            'Sign Up',
            style: Styles.textStyle16.copyWith(
              color: MyColors.mySteelBlue,
            ),
          ),
        ),
      ],
    );
  }
}
