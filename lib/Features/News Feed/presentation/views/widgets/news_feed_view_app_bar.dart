import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/Features/Home/presentation/manager/home_cubit/home_cubit.dart';

import '../../../../../Core/utils/app_router.dart';
import '../../../../../Core/utils/constants.dart';
import '../../../../../Core/utils/my_colors.dart';
import '../../../../../Core/utils/styles.dart';

class NewsFeedViewAppBar extends StatelessWidget {
  const NewsFeedViewAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              'SocialWave',
              style: Styles.textStyle34,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: user.image!,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(

                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'What\'s on your mind?',
                        hintMaxLines: 1,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: MyColors.mySteelBlue.withOpacity(0.2),
                        filled: true,
                        hintStyle: Styles.textStyle18,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      readOnly: true,
                      onTap: () =>
                          GoRouter.of(context).push(AppRouter.kNewPostView),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
