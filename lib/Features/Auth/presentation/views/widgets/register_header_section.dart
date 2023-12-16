import 'package:flutter/material.dart';

import '../../../../../Core/utils/styles.dart';

class RegisterHeaderSection extends StatelessWidget {
  const RegisterHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        'Welcome !',
        style: Styles.textStyle34,
      ),
    );
  }
}
