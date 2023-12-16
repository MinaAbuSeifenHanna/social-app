import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../Core/utils/app_router.dart';
import '../../../../../Core/utils/my_colors.dart';
import '../../../../../Core/utils/styles.dart';

class RegisterToLoginSection extends StatelessWidget {
  const RegisterToLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: Styles.textStyle16,
        ),
        TextButton(
          onPressed: () => GoRouter.of(context).go(AppRouter.kLoginView),
          child: Text(
            'Sign In',
            style: Styles.textStyle16.copyWith(
              color: MyColors.mySteelBlue,
            ),
          ),
        ),
      ],
    );
  }
}
