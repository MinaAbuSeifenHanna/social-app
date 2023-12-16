import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/utils/assets_data.dart';
import 'package:social_app/Core/utils/constants.dart';
import 'package:social_app/Core/widgets/custom_app_bar.dart';
import 'package:social_app/Core/widgets/custom_empty_widget.dart';
import 'package:social_app/Features/News%20Feed/presentation/views/widgets/custom_divider.dart';
import 'package:social_app/Features/News%20Feed/presentation/views/widgets/post_item.dart';

import '../../../../Core/utils/styles.dart';
import '../../../../Core/widgets/custom_failure_widget.dart';
import '../../../../Core/widgets/custom_loading_widget.dart';
import '../../data/models/post_model.dart';
import '../manager/news_feed_cubit/news_feed_cubit.dart';

class SavedPostsView extends StatelessWidget {
  const SavedPostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: BlocBuilder<NewsFeedCubit, NewsFeedState>(
            builder: (context, state) {
              if (state is GetPostsLoadingState) {
                return const Center(child: CustomLoadingWidget());
              } else if (state is GetPostsFailureState) {
                return Center(
                  child: CustomFailureWidget(errMessage: state.errorMessage),
                );
              }
              List<PostModel> matchingPosts =
                  BlocProvider.of<NewsFeedCubit>(context)
                      .posts
                      .where((post) => user.savedPosts!.contains(post.postId))
                      .toList();
              return Column(
                children: [
                  CustomAppBar(
                    ctx: context,
                    title: Text('Saved Posts', style: Styles.textStyle20),
                  ),
                  const CustomDivider(),
                  (user.savedPosts!.isNotEmpty)
                      ? Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return PostItem(post: matchingPosts[index]);
                            },
                            itemCount: matchingPosts.length,
                          ),
                        )
                      : const Expanded(
                          child: CustomEmptyWidget(
                            title: 'No Posts Yet',
                            subTitle: 'Save posts to see them here',
                            image: AssetsData.emptyPost,
                          ),
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
