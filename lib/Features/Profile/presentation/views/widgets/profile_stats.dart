import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/Core/utils/constants.dart';
import 'package:social_app/Core/utils/styles.dart';
import 'package:social_app/Features/News%20Feed/presentation/manager/news_feed_cubit/news_feed_cubit.dart';

import '../../../../../Core/utils/app_router.dart';
import '../../../../Home/presentation/manager/home_cubit/home_cubit.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsFeedCubit, NewsFeedState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kFollowersView,
                      extra: BlocProvider.of<HomeCubit>(context)
                          .usersModel
                          .where((element) =>
                              user.followers!.contains(element.uId))
                          .toList());
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    children: [
                      Text(
                        user.followers!.length.toString(),
                        style: Styles.textStyle18,
                      ),
                      Text(
                        'Followers',
                        style: Styles.textStyle18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kFollowingsView,
                      extra: BlocProvider.of<HomeCubit>(context)
                          .usersModel
                          .where((element) =>
                              user.following!.contains(element.uId))
                          .toList());
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    children: [
                      Text(
                        user.following!.length.toString(),
                        style: Styles.textStyle18,
                      ),
                      Text(
                        'Followings',
                        style: Styles.textStyle18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
