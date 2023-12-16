import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Features/News%20Feed/data/models/post_model.dart';
import 'package:social_app/Features/News%20Feed/presentation/manager/news_feed_cubit/news_feed_cubit.dart';

import '../../../../../Core/utils/my_colors.dart';
import '../../../../../Core/utils/styles.dart';
import '../../../../../Core/widgets/custom_app_bar.dart';

class EditPostHeader extends StatelessWidget {
  const EditPostHeader({
    super.key,
    required this.postController,
    required this.postModel,
  });

  final TextEditingController postController;
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      ctx: context,
      title: Text('Edit Post', style: Styles.textStyle20),
      actions: [
        TextButton(
          onPressed: () {
            BlocProvider.of<NewsFeedCubit>(context).editPost(
              text: postController.text,
              dateTime: postModel.dateTime!,
              postId: postModel.postId!,
              likes: postModel.likes!,
            );
          },
          child: Text(
            'Edit',
            style: Styles.textStyle18.copyWith(color: MyColors.myAquamarine),
          ),
        ),
        const SizedBox(width: 10)
      ],
    );
  }
}
