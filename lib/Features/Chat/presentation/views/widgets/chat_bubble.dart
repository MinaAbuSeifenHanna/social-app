import 'package:flutter/material.dart';
import 'package:social_app/Core/utils/my_colors.dart';
import 'package:social_app/Core/utils/styles.dart';

import '../../../data/models/message_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.message,
  }) : super(key: key);
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          color: MyColors.mySteelBlue,
        ),
        child: Text(
          message.text!,
          style: Styles.textStyle20,
        ),
      ),
    );
  }
}
