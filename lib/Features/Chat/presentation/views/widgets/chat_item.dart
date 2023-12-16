import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/Core/models/user_model.dart';
import 'package:social_app/Core/utils/app_router.dart';
import 'package:social_app/Core/utils/constants.dart';
import 'package:social_app/Core/utils/styles.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => GoRouter.of(context)
          .push(AppRouter.kChatDetailsView, extra: userModel),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: defaultRadius,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(defaultRadius),
                child: CachedNetworkImage(
                  imageUrl: userModel.image!,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(userModel.name!, style: Styles.textStyle18),
          ],
        ),
      ),
    );
  }
}
