import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/widgets/custom_text_form_field.dart';
import '../../manager/login_cubit/login_cubit.dart';

class LoginFormSection extends StatelessWidget {
  LoginFormSection({
    super.key,
    required this.emailController,
    required this.passwordController,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: emailController,
          labelText: 'Email Address',
          prefixIcon: const Icon(Icons.email_outlined),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Email Address is required';
            } else if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextFormField(
          controller: passwordController,
          labelText: 'Password',
          prefixIcon: const Icon(Icons.lock_outline),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Password is required';
            } else if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
          suffixIcon: IconButton(
            onPressed: () =>
                BlocProvider.of<LoginCubit>(context).changePasswordVisibility(),
            icon: Icon(BlocProvider.of<LoginCubit>(context).suffixIcon),
          ),
          obscureText: BlocProvider.of<LoginCubit>(context).isPassword,
        ),
      ],
    );
  }
}
