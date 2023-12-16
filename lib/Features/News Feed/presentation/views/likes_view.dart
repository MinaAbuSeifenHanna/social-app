import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/models/user_model.dart';
import 'package:social_app/Core/widgets/custom_app_bar.dart';
import 'package:social_app/Features/News%20Feed/presentation/views/widgets/custom_divider.dart';

import '../../../../Core/utils/constants.dart';
import '../../../../Core/utils/my_colors.dart';
import '../../../../Core/utils/styles.dart';
import '../manager/news_feed_cubit/news_feed_cubit.dart';

class LikesView extends StatelessWidget {
  const LikesView({super.key, required this.usersLikes});

  final List<UserModel> usersLikes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              ctx: context,
              title: Text('Likes', style: Styles.textStyle20),
            ),
            const CustomDivider(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: defaultRadius,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(defaultRadius),
                            child: Image.network(
                              usersLikes[index].image!,
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          usersLikes[index].name!,
                          style: Styles.textStyle18,
                        ),
                        const Spacer(),
                        // follow & not follow
                        if (usersLikes[index].uId != uId)
                          BlocBuilder<NewsFeedCubit, NewsFeedState>(
                            builder: (context, state) {
                              bool isFollow = user.following!
                                  .contains(usersLikes[index].uId);
                              return TextButton(
                                child: Text(
                                  isFollow ? 'Unfollow' : 'Follow',
                                  style: Styles.textStyle16.copyWith(
                                    color: isFollow
                                        ? MyColors.myGrey
                                        : MyColors.myBlue,
                                  ),
                                ),
                                onPressed: () =>
                                    BlocProvider.of<NewsFeedCubit>(context)
                                        .updateFollowUser(
                                            uid: usersLikes[index].uId!),
                              );
                            },
                          ),
                      ],
                    ),
                  );
                },
                itemCount: usersLikes.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // function to get the user data from the id
}
