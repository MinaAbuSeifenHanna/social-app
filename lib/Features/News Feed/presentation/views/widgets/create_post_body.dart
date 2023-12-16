import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/utils/my_colors.dart';
import 'package:social_app/Core/utils/styles.dart';

import '../../manager/news_feed_cubit/news_feed_cubit.dart';

class CreatePostBody extends StatelessWidget {
  const CreatePostBody({super.key, required this.postController});
  final TextEditingController postController;

  @override
  Widget build(BuildContext context) {
    var postImage = BlocProvider.of<NewsFeedCubit>(context).postImage;
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: TextFormField(
              controller: postController,
              keyboardType: TextInputType.text,
              // validator: validator,
              maxLines: 100,
              decoration: InputDecoration(
                hintText: 'What\'s on your mind...',
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                hintStyle: Styles.textStyle20,
                border: InputBorder.none,
              ),
              style: Styles.textStyle30,
            ),
          ),
          if (postImage != null && postImage.path.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Image.file(
                      postImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                    onPressed: () => BlocProvider.of<NewsFeedCubit>(context)
                        .removePostImage(),
                    icon: const CircleAvatar(
                      backgroundColor: MyColors.myRed,
                      radius: 20,
                      child: Icon(
                        Icons.close,
                        color: MyColors.myWhite,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
