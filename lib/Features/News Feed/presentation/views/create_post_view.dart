import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/Core/utils/functions/show_toast.dart';
import 'package:social_app/Core/utils/my_colors.dart';
import 'package:social_app/Features/News%20Feed/presentation/manager/news_feed_cubit/news_feed_cubit.dart';
import 'package:social_app/Features/News%20Feed/presentation/views/widgets/create_post_body.dart';
import 'package:social_app/Features/News%20Feed/presentation/views/widgets/create_post_footer.dart';
import 'package:social_app/Features/News%20Feed/presentation/views/widgets/create_post_header.dart';
import 'package:social_app/Features/News%20Feed/presentation/views/widgets/custom_divider.dart';

class CreatePostView extends StatelessWidget {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController postController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<NewsFeedCubit, NewsFeedState>(
          listener: (context, state) async {
            if (state is CreatePostSuccessState) {
              GoRouter.of(context).pop();
              showToast(
                message: 'Post created successfully!',
                backgroundColor: Colors.green,
              );
              BlocProvider.of<NewsFeedCubit>(context).postImage = null;
            } else if (state is CreatePostFailureState) {
              GoRouter.of(context).pop();
              showToast(
                message: 'Post creation failed!',
                backgroundColor: Colors.red,
              );
              BlocProvider.of<NewsFeedCubit>(context).postImage = null;
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                CreatePostHeader(postController: postController),
                const SizedBox(height: 5),
                (state is CreatePostLoadingState)
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: LinearProgressIndicator(
                          color: MyColors.mySteelBlue,
                        ),
                      )
                    : const CustomDivider(),
                const SizedBox(height: 5),
                CreatePostBody(postController: postController),
                const CreatePostFooter(),
              ],
            );
          },
        ),
      ),
    );
  }
}
