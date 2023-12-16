import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/utils/styles.dart';
import 'package:social_app/Features/Home/presentation/manager/home_cubit/home_cubit.dart';

import '../../../../../Core/utils/constants.dart';

class ProfileBio extends StatelessWidget {
  const ProfileBio({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Text(user.name!, style: Styles.textStyle28),
              Text(user.bio!, style: Styles.textStyle16),
            ],
          ),
        );
      },
    );
  }
}
