import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/utils/constants.dart';
import 'package:social_app/Core/utils/enums/image_status.dart';
import 'package:social_app/Core/utils/styles.dart';

import '../../manager/profile_cubit/profile_cubit.dart';

class EditProfileImagesSection extends StatelessWidget {
  const EditProfileImagesSection({
    super.key,
    this.profileImage,
    this.coverImage,
    required this.imageProfileStatus,
    required this.imageCoverStatus,
  });

  final File? profileImage;
  final File? coverImage;

  final ImageStatus imageProfileStatus;
  final ImageStatus imageCoverStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 280,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: Container(
                  height: 230,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                  ),
                  child: imageCoverStatus == ImageStatus.original
                      ? CachedNetworkImage(
                          imageUrl: user.cover!,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        )
                      : Image.file(
                          coverImage!,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              CircleAvatar(
                radius: 65,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    // child: CachedNetworkImage(
                    //   imageUrl: profileImage == null
                    //       ? user.image!
                    //       : profileImage!.path,
                    //   height: double.infinity,
                    //   width: double.infinity,
                    //   fit: BoxFit.fill,
                    // ),
                    child: imageProfileStatus == ImageStatus.original
                        ? CachedNetworkImage(
                            imageUrl: user.image!,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          )
                        : Image.file(
                            profileImage!,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () =>
                    BlocProvider.of<ProfileCubit>(context).getProfileImage(),
                child: Text('Change Profile Photo', style: Styles.textStyle18),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () =>
                    BlocProvider.of<ProfileCubit>(context).getCoverImage(),
                child: Text('Change Cover Photo', style: Styles.textStyle18),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
