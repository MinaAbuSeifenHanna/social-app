import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/Core/utils/functions/show_toast.dart';
import 'package:social_app/Core/utils/my_colors.dart';
import 'package:social_app/Features/News%20Feed/data/models/post_model.dart';
import 'package:social_app/Features/News%20Feed/presentation/manager/news_feed_cubit/news_feed_cubit.dart';
import 'package:social_app/Features/News%20Feed/presentation/views/widgets/create_post_footer.dart';
import 'package:social_app/Features/News%20Feed/presentation/views/widgets/custom_divider.dart';
import 'package:social_app/Features/News%20Feed/presentation/views/widgets/edit_post_body.dart';
import 'package:social_app/Features/News%20Feed/presentation/views/widgets/edit_post_header.dart';

import '../../../../Core/utils/enums/image_status.dart';

class EditPostView extends StatelessWidget {
  const EditPostView({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NewsFeedCubit>(context).postImage =
        File(postModel.postImage!);
    final TextEditingController postController =
        TextEditingController(text: postModel.text);
    ImageStatus imageStatus = ImageStatus.original;

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<NewsFeedCubit, NewsFeedState>(
          listener: (context, state) async {
            if (state is EditPostSuccessState) {
              GoRouter.of(context).pop();
              showToast(
                message: 'Post edited successfully!',
                backgroundColor: Colors.green,
              );
              BlocProvider.of<NewsFeedCubit>(context).postImage = null;
            } else if (state is EditPostFailureState) {
              GoRouter.of(context).pop();
              showToast(
                message: 'Post editing failed!',
                backgroundColor: Colors.red,
              );
              BlocProvider.of<NewsFeedCubit>(context).postImage = null;
            } else if (state is PostImagePickedSuccessState) {
              imageStatus = ImageStatus.edited;
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                EditPostHeader(
                  postController: postController,
                  postModel: postModel,
                ),
                const SizedBox(height: 5),
                (state is EditPostLoadingState)
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: LinearProgressIndicator(
                          color: MyColors.mySteelBlue,
                        ),
                      )
                    : const CustomDivider(),
                const SizedBox(height: 5),
                EditPostBody(
                  postController: postController,
                  post: postModel,
                  imageStatus: imageStatus,
                ),
                const CreatePostFooter(),
              ],
            );
          },
        ),
      ),
    );
  }
}
