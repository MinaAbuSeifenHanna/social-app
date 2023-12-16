import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Features/Profile/presentation/views/widgets/profile_actions.dart';
import 'package:social_app/Features/Profile/presentation/views/widgets/profile_bio.dart';
import 'package:social_app/Features/Profile/presentation/views/widgets/profile_header.dart';
import 'package:social_app/Features/Profile/presentation/views/widgets/profile_stats.dart';

import '../../../../Core/utils/constants.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    print(user);
    return const Column(
      children: [
        ProfileHeader(),
        SizedBox(height: 20),
        ProfileBio(),
        ProfileStats(),
        ProfileActions()
      ],
    );
  }
}
