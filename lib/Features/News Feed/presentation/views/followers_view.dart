import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/models/user_model.dart';
import 'package:social_app/Core/widgets/custom_app_bar.dart';
import 'package:social_app/Features/News%20Feed/presentation/views/widgets/custom_divider.dart';

import '../../../../Core/utils/constants.dart';
import '../../../../Core/utils/my_colors.dart';
import '../../../../Core/utils/styles.dart';
import '../manager/news_feed_cubit/news_feed_cubit.dart';

class FollowersView extends StatelessWidget {
  const FollowersView({super.key, required this.usersFollowers});

  final List<UserModel> usersFollowers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<NewsFeedCubit, NewsFeedState>(
          builder: (context, state) {
            return Column(
              children: [
                CustomAppBar(
                  ctx: context,
                  title: Text('Followers ', style: Styles.textStyle20),
                ),
                const CustomDivider(),
                (usersFollowers.isEmpty)
                    ? Expanded(
                        child: Center(
                          child: Text(
                            'No Followers',
                            style: Styles.textStyle18,
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: defaultRadius,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(defaultRadius),
                                      child: Image.network(
                                        usersFollowers[index].image!,
                                        height: double.infinity,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    usersFollowers[index].name!,
                                    style: Styles.textStyle18,
                                  ),
                                  const Spacer(),
                                  // follow & not follow
                                  if (usersFollowers[index].uId != uId)
                                    BlocBuilder<NewsFeedCubit, NewsFeedState>(
                                      builder: (context, state) {
                                        bool isFollow = user.following!
                                            .contains(
                                                usersFollowers[index].uId);
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
                                              BlocProvider.of<NewsFeedCubit>(
                                                      context)
                                                  .updateFollowUser(
                                                      uid: usersFollowers[index]
                                                          .uId!),
                                        );
                                      },
                                    ),
                                ],
                              ),
                            );
                          },
                          itemCount: usersFollowers.length,
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
