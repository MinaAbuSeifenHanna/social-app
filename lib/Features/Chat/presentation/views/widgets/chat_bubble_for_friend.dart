import 'package:flutter/material.dart';
import 'package:social_app/Core/utils/my_colors.dart';
import 'package:social_app/Core/utils/styles.dart';
import 'package:social_app/Features/Chat/data/models/message_model.dart';

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({
    Key? key,
    required this.message,
  }) : super(key: key);

  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: MyColors.myAquamarine.withOpacity(0.3),
        ),
        child: Text(
          message.text!,
          style: Styles.textStyle20,
        ),
      ),
    );
  }
}
