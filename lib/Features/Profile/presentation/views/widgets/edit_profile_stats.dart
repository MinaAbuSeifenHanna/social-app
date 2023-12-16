import 'package:flutter/widgets.dart';

import '../../../../../Core/utils/icon_broken.dart';
import '../../../../../Core/widgets/custom_text_form_field.dart';

class EditProfileStats extends StatelessWidget {
  const EditProfileStats({
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CustomTextFormField(
            controller: nameController,
            labelText: 'Name',
            prefixIcon: const Icon(IconBroken.User),
            // validatorMessage: 'Name is required',
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: bioController,
            labelText: 'Bio',
            prefixIcon: const Icon(IconBroken.Info_Circle),
            // validatorMessage: 'Bio is required',
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: phoneController,
            labelText: 'Phone Number',
            prefixIcon: const Icon(IconBroken.Call),
            // validatorMessage: 'Phone Number is required',
          ),
        ],
      ),
    );
  }
}
