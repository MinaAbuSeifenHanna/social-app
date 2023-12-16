import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/utils/my_colors.dart';

import '../../../../../Core/utils/styles.dart';
import '../../../../../Core/widgets/custom_app_bar.dart';

import '../../manager/news_feed_cubit/news_feed_cubit.dart';

class CreatePostHeader extends StatelessWidget {
  const CreatePostHeader({
    super.key,
    required this.postController,
  });

  final TextEditingController postController;

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      ctx: context,
      title: Text('Create Post', style: Styles.textStyle20),
      actions: [
        TextButton(
          onPressed: () {
            BlocProvider.of<NewsFeedCubit>(context).createPost(
              text: postController.text,
              dateTime: DateTime.now().toString(),
            );
          },
          child: Text(
            'POST',
            style: Styles.textStyle18.copyWith(color: MyColors.myAquamarine),
          ),
        ),
        const SizedBox(width: 10)
      ],
    );
  }
}
