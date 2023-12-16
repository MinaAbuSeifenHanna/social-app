import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/Core/utils/icon_broken.dart';
import 'package:social_app/Core/utils/my_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.ctx,
    this.title,
    this.actions,
    this.isBack = true,
  });

  final BuildContext ctx;
  final Widget? title;
  final List<Widget>? actions;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isBack)
          IconButton(
            onPressed: () => GoRouter.of(ctx).pop(),
            icon: const Icon(
              IconBroken.Arrow___Left_2,
              color: MyColors.myWhite,
            ),
          ),
        const SizedBox(width: 5),
        title != null ? title! : const SizedBox(),
        const Spacer(),
        actions != null ? Row(children: actions!) : const SizedBox(),
      ],
    );
  }
}
