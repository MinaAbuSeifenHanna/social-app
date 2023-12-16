import 'package:flutter/material.dart';
import 'package:social_app/Core/utils/my_colors.dart';
import 'package:social_app/Features/News%20Feed/data/models/post_model.dart';
import 'package:social_app/Features/News%20Feed/presentation/views/widgets/post_body.dart';
import 'package:social_app/Features/News%20Feed/presentation/views/widgets/post_footer.dart';
import 'package:social_app/Features/News%20Feed/presentation/views/widgets/post_header.dart';

import 'custom_divider.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.myDarkCerulean.withOpacity(0.0001),
      elevation: 0.05,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostHeader(post: post),
            const CustomDivider(),
            PostBody(post: post),
            const CustomDivider(),
            PostFooter(post: post),
          ],
        ),
      ),
    );
  }
}
