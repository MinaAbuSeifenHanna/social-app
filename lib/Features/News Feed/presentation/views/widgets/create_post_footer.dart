import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/utils/styles.dart';

import '../../../../../Core/utils/icon_broken.dart';
import '../../../../../Core/utils/my_colors.dart';
import '../../manager/news_feed_cubit/news_feed_cubit.dart';

class CreatePostFooter extends StatelessWidget {
  const CreatePostFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          onPressed: () =>
              BlocProvider.of<NewsFeedCubit>(context).getPostImage(),
          icon: const Icon(
            IconBroken.Image,
            color: MyColors.myAquamarine,
            size: 20,
          ),
          label: Text(
            'add photo',
            style: Styles.textStyle18.copyWith(color: MyColors.myAquamarine),
          ),
        ),
      ],
    );
  }
}
