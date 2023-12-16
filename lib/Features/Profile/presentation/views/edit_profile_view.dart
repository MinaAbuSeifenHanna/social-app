import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_app/Core/utils/functions/show_snack_bar.dart';
import 'package:social_app/Features/News%20Feed/presentation/manager/news_feed_cubit/news_feed_cubit.dart';
import 'package:social_app/Features/Profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:social_app/Features/Profile/presentation/views/widgets/edit_images_section.dart';
import 'package:social_app/Features/Profile/presentation/views/widgets/edit_profile_header.dart';
import 'package:social_app/Features/Profile/presentation/views/widgets/edit_profile_stats.dart';

import '../../../../Core/utils/constants.dart';
import '../../../../Core/utils/enums/image_status.dart';
import '../../../Home/presentation/manager/home_cubit/home_cubit.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: user.name);
    final TextEditingController bioController =
        TextEditingController(text: user.bio);

    final TextEditingController phoneController =
        TextEditingController(text: user.phone);

    ImageStatus imageProfileStatus = ImageStatus.original;
    ImageStatus imageCoverStatus = ImageStatus.original;

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) async {
          if (state is EditProfileSuccessState) {
            GoRouter.of(context).pop();
            await BlocProvider.of<HomeCubit>(context).getUserData();
            await BlocProvider.of<NewsFeedCubit>(context).getPosts();

          } else if (state is EditProfileFailureState) {
            showSnackBar(context, state.errorMessage);
          } else if (state is ProfileImagePickedSuccessState) {
            imageProfileStatus = ImageStatus.edited;
          } else if (state is CoverImagePickedSuccessState) {
            imageCoverStatus = ImageStatus.edited;
          }
        }, builder: (context, state) {
          var profileImage =
              BlocProvider.of<ProfileCubit>(context).profileImage;
          var coverImage = BlocProvider.of<ProfileCubit>(context).coverImage;
          return ModalProgressHUD(
            inAsyncCall: state is EditProfileLoadingState,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  EditProfileHeader(
                    nameController: nameController,
                    bioController: bioController,
                    phoneController: phoneController,
                  ),
                  EditProfileImagesSection(
                    coverImage: coverImage,
                    profileImage: profileImage,
                    imageCoverStatus: imageCoverStatus,
                    imageProfileStatus: imageProfileStatus,
                  ),
                  const SizedBox(height: 10),
                  EditProfileStats(
                    nameController: nameController,
                    bioController: bioController,
                    phoneController: phoneController,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
