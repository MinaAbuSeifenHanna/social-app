import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../Core/models/user_model.dart';
import '../../../../../Core/utils/constants.dart';
import '../../../../../Core/utils/styles.dart';
import '../../../../../Core/widgets/custom_app_bar.dart';
import '../../../../News Feed/presentation/views/widgets/custom_divider.dart';

class ChatDetailsViewAppBar extends StatelessWidget {
  const ChatDetailsViewAppBar({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        CustomAppBar(
          ctx: context,
          title: Row(
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
        const CustomDivider(),
      ],
    );
  }
}
