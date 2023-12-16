import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/models/user_model.dart';
import 'package:social_app/Core/utils/assets_data.dart';
import 'package:social_app/Core/utils/functions/format_post_time.dart';
import 'package:social_app/Core/widgets/custom_app_bar.dart';
import 'package:social_app/Core/widgets/custom_empty_widget.dart';
import 'package:social_app/Features/News%20Feed/data/models/post_model.dart';
import 'package:social_app/Features/News%20Feed/presentation/manager/news_feed_cubit/news_feed_cubit.dart';
import 'package:social_app/Features/News%20Feed/presentation/views/widgets/custom_divider.dart';

import '../../../../Core/utils/constants.dart';
import '../../../../Core/utils/icon_broken.dart';
import '../../../../Core/utils/my_colors.dart';
import '../../../../Core/utils/styles.dart';
import '../../data/models/comment_model.dart';

class CommentsView extends StatelessWidget {
  CommentsView({super.key, required this.postModel});

  PostModel postModel;

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<NewsFeedCubit, NewsFeedState>(
          builder: (context, state) {
            if (state is GetPostsSuccessState) {
              postModel =
                  BlocProvider.of<NewsFeedCubit>(context).posts.firstWhere(
                        (element) => element.postId == postModel.postId,
                      );
            }
            return Column(
              children: [
                CustomAppBar(
                  ctx: context,
                  title: Text('Comments', style: Styles.textStyle20),
                ),
                const CustomDivider(),
                postModel.comments!.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) => CommentItem(
                            postModel: postModel,
                            commentModel: postModel.comments![index],
                          ),
                          itemCount: postModel.comments!.length,
                        ),
                      )
                    : const Expanded(
                        child: CustomEmptyWidget(
                          title: 'No Comments Yet',
                          subTitle: 'Be the first one to comment',
                          image: AssetsData.emptyChat,
                        ),
                      ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: MyColors.mySteelBlue),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: commentController,
                            decoration: const InputDecoration(
                              hintText: 'Write a comment...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<NewsFeedCubit>(context)
                                .createComment(
                              text: commentController.text,
                              dateTime: DateTime.now().toString(),
                              postId: postModel.postId!,
                            );
                            commentController.clear();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: MyColors.mySteelBlue,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(50, 50),
                          ),
                          child: const Icon(
                            IconBroken.Send,
                            color: MyColors.myWhite,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.postModel,
    required this.commentModel,
  });

  final PostModel postModel;
  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    final UserModel userComment = users.firstWhere(
      (element) => element.uId == commentModel.userId,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            // backgroundImage: NetworkImage(userComment.image!),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CachedNetworkImage(
                imageUrl: userComment.image!,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userComment.name!,
                style: Styles.textStyle18,
              ),
              const SizedBox(height: 5),
              Text(
                commentModel.text!,
                style: Styles.textStyle16,
              ),
              const SizedBox(height: 5),
              BlocBuilder<NewsFeedCubit, NewsFeedState>(
                builder: (context, state) {
                  bool isLike = postModel.comments!
                      .firstWhere((element) =>
                          element.commentId == commentModel.commentId)
                      .likes!
                      .contains(uId);

                  return Row(
                    children: [
                      Text(
                        formatPostTime(DateTime.parse(commentModel.dateTime!)),
                        style:
                            Styles.textStyle14.copyWith(color: MyColors.myGrey),
                      ),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<NewsFeedCubit>(context)
                              .updateLikeComment(
                            postModel: postModel,
                            commentModel: commentModel,
                          );
                        },
                        child: Text(
                          isLike ? 'Like' : 'Like',
                          style: TextStyle(
                            color: isLike ? MyColors.myRed : MyColors.myGrey,
                          ),
                        ),
                      ),
                      if (commentModel.likes!.isNotEmpty)
                        TextButton.icon(
                          onPressed: () {},
                          icon: Text(
                            commentModel.likes!.length.toString(),
                            style: const TextStyle(color: MyColors.myWhite),
                          ),
                          label: const Icon(
                            IconBroken.Heart,
                            color: MyColors.myRed,
                          ),
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
