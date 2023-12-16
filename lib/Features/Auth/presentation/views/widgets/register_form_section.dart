import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/widgets/custom_text_form_field.dart';
import '../../manager/register_cubit/register_cubit.dart';

class RegisterFormSection extends StatelessWidget {
  RegisterFormSection({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.phoneController,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: nameController,
          labelText: 'User Name',
          prefixIcon: const Icon(Icons.person),
          validator: (value) {
            if (value!.isEmpty) {
              return 'User Name is required';
            } else if (value.length < 3) {
              return 'User Name must be at least 3 characters';
            } else if (value.length > 20) {
              return 'User Name must be less than 20 characters';
            } else if (!RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value)) {
              return 'User Name must be alphanumeric';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
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
            onPressed: () {
              BlocProvider.of<RegisterCubit>(context)
                  .changePasswordVisibility();
            },
            icon: Icon(BlocProvider.of<RegisterCubit>(context).suffixIcon),
          ),
          obscureText: BlocProvider.of<RegisterCubit>(context).isPassword,
        ),
        const SizedBox(
          height: 20,
        ),


        TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white60),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white60),
            ),
          labelText: 'Phone',
          prefixIcon: Icon(Icons.phone),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Phone is required';
            } else if (value.length < 11) {
              return 'Phone must be at least 11 characters';
            }
            return null;
          },
        ),
      ],
    );
  }
}
