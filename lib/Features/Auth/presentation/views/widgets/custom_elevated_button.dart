import 'package:flutter/material.dart';

import '../../../../../Core/utils/my_colors.dart';
import '../../../../../Core/utils/styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: MyColors.mySteelBlue,
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: Styles.textStyle22,
            ),
          ),
        ),
      ],
    );
  }
}
