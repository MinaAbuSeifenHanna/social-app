import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/utils/my_colors.dart';
import '../../../../../Core/utils/styles.dart';
import '../../../../../Core/widgets/custom_app_bar.dart';
import '../../manager/profile_cubit/profile_cubit.dart';

class EditProfileHeader extends StatelessWidget {
  const EditProfileHeader({
    super.key,
    required this.nameController,
    required this.bioController,
    required this.phoneController,
  });

  final TextEditingController nameController;
  final TextEditingController bioController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      ctx: context,
      title: Text('Edit Profile', style: Styles.textStyle20),
      actions: [
        TextButton(
          onPressed: () {
            BlocProvider.of<ProfileCubit>(context).editProfile(
              name: nameController.text,
              bio: bioController.text,
              phone: phoneController.text,
            );
          },
          child: Text(
            'UPDATE',
            style: Styles.textStyle18.copyWith(color: MyColors.myAquamarine),
          ),
        ),
        const SizedBox(width: 10)
      ],
    );
  }
}
