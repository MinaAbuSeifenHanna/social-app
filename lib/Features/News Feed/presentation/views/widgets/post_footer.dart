import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/Core/utils/constants.dart';
import 'package:social_app/Core/utils/my_colors.dart';
import 'package:social_app/Features/Home/presentation/manager/home_cubit/home_cubit.dart';

import '../../../../../Core/utils/app_router.dart';
import '../../../../../Core/utils/icon_broken.dart';
import '../../../data/models/post_model.dart';
import '../../manager/news_feed_cubit/news_feed_cubit.dart';

class PostFooter extends StatelessWidget {
  const PostFooter({super.key, required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    bool isLike = BlocProvider.of<NewsFeedCubit>(context)
        .posts
        .firstWhere((element) => element.postId == post.postId)
        .likes!
        .contains(uId);
    return Row(
      children: [
        Expanded(
          child: TextButton.icon(
            onPressed: () => BlocProvider.of<NewsFeedCubit>(context)
                .updateLikePost(postModel: post),
            icon: Icon(
              IconBroken.Heart,
              color: isLike ? MyColors.myRed : MyColors.myGrey,
            ),
            label: Text(
              'Like',
              style:
                  TextStyle(color: isLike ? MyColors.myRed : MyColors.myGrey),
            ),
          ),
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: () {
              BlocProvider.of<HomeCubit>(context)
                  .getAllUsers();
              GoRouter.of(context).push(
              AppRouter.kCommentsView,
              extra: post,
            );
            },
            icon: const Icon(
              IconBroken.Chat,
              color: MyColors.myGrey,
            ),
            label: const Text(
              'Comment',
              style: TextStyle(color: MyColors.myGrey),
            ),
          ),
        ),
      ],
    );
  }
}
