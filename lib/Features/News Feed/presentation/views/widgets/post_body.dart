import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/Core/utils/app_router.dart';
import 'package:social_app/Core/utils/my_colors.dart';
import 'package:social_app/Core/utils/styles.dart';
import 'package:social_app/Features/News%20Feed/presentation/manager/news_feed_cubit/news_feed_cubit.dart';

import '../../../../../Core/utils/icon_broken.dart';
import '../../../../Home/presentation/manager/home_cubit/home_cubit.dart';
import '../../../data/models/post_model.dart';

class PostBody extends StatelessWidget {
  const PostBody({super.key, required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (post.text! != '')
            Text(
              post.text!,
              style: Styles.textStyle20,
            ),
          if (post.postImage != '')
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 4),
              child: InkWell(
                onDoubleTap: () => BlocProvider.of<NewsFeedCubit>(context)
                    .updateLikePost(postModel: post),
                child: CachedNetworkImage(
                  imageUrl: post.postImage!,
                  width: double.infinity,
                  height: 220.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          BlocBuilder<NewsFeedCubit, NewsFeedState>(
            builder: (context, state) {
              int likes = BlocProvider.of<NewsFeedCubit>(context)
                  .posts
                  .firstWhere((element) => element.postId == post.postId)
                  .likes!
                  .length;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  if (likes != 0)
                    TextButton.icon(
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.kLikesView,
                            extra: BlocProvider.of<HomeCubit>(context)
                                .usersModel
                                .where((element) =>
                                    post.likes!.contains(element.uId))
                                .toList());
                      },
                      icon: Text(
                        likes.toString(),
                        style: const TextStyle(color: MyColors.myGrey),
                      ),
                      label: const Icon(
                        IconBroken.Heart,
                        color: MyColors.myGrey,
                      ),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    ),
                  if (post.comments!.isNotEmpty)
                    TextButton.icon(
                      onPressed: () => GoRouter.of(context).push(
                        AppRouter.kCommentsView,
                        extra: post,
                      ),
                      icon: Text(
                        post.comments!.length.toString(),
                        style: const TextStyle(color: MyColors.myGrey),
                      ),
                      label: const Icon(
                        IconBroken.Chat,
                        color: MyColors.myGrey,
                      ),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
