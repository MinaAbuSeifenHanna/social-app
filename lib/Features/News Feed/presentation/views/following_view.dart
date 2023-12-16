import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/models/user_model.dart';
import 'package:social_app/Core/widgets/custom_app_bar.dart';
import 'package:social_app/Features/News%20Feed/presentation/views/widgets/custom_divider.dart';

import '../../../../Core/utils/constants.dart';
import '../../../../Core/utils/my_colors.dart';
import '../../../../Core/utils/styles.dart';
import '../../../Home/presentation/manager/home_cubit/home_cubit.dart';
import '../manager/news_feed_cubit/news_feed_cubit.dart';

class FollowingView extends StatelessWidget {
  FollowingView({super.key, required this.usersFollowings});

  List<UserModel> usersFollowings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<NewsFeedCubit, NewsFeedState>(
          builder: (context, state) {
            if (state is UpdateFollowUserSuccessState) {
              usersFollowings = BlocProvider.of<HomeCubit>(context)
                  .usersModel
                  .where((element) => user.following!.contains(element.uId))
                  .toList();
            }
            return Column(
              children: [
                CustomAppBar(
                  ctx: context,
                  title: Text('Followings', style: Styles.textStyle20),
                ),
                const CustomDivider(),
                (usersFollowings.isEmpty)
                    ? Expanded(
                        child: Center(
                          child: Text(
                            'No Followings Yet',
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
                                        usersFollowings[index].image!,
                                        height: double.infinity,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    usersFollowings[index].name!,
                                    style: Styles.textStyle18,
                                  ),
                                  const Spacer(),
                                  // follow & not follow
                                  if (usersFollowings[index].uId != uId)
                                    BlocBuilder<NewsFeedCubit, NewsFeedState>(
                                      builder: (context, state) {
                                        bool isFollow = user.following!
                                            .contains(
                                                usersFollowings[index].uId);
                                        return TextButton(
                                          child: Text(
                                            isFollow ? 'Unfollow' : 'Follow',
                                            style: Styles.textStyle16.copyWith(
                                              color: isFollow
                                                  ? MyColors.myGrey
                                                  : MyColors.myBlue,
                                            ),
                                          ),
                                          onPressed: () => BlocProvider.of<
                                                  NewsFeedCubit>(context)
                                              .updateFollowUser(
                                                  uid: usersFollowings[index]
                                                      .uId!),
                                        );
                                      },
                                    ),
                                ],
                              ),
                            );
                          },
                          itemCount: usersFollowings.length,
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
