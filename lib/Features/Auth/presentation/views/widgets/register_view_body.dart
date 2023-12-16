import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:social_app/Core/utils/app_router.dart';
import 'package:social_app/Features/Auth/presentation/views/widgets/custom_elevated_button.dart';
import 'package:social_app/Features/Auth/presentation/views/widgets/register_header_section.dart';
import 'package:social_app/Features/Auth/presentation/views/widgets/register_to_login_section.dart';
import 'package:social_app/Features/Auth/presentation/views/widgets/register_form_section.dart';

import '../../../../../Core/utils/cache_network.dart';
import '../../../../../Core/utils/constants.dart';
import '../../../../../Core/utils/functions/show_snack_bar.dart';
import '../../../../Home/presentation/manager/home_cubit/home_cubit.dart';
import '../../manager/register_cubit/register_cubit.dart';

class RegisterViewBody extends StatelessWidget {
  RegisterViewBody({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) async {
        if (state is RegisterLoadingState) {
          isLoading = true;
        } else if (state is RegisterSuccessState) {
          isLoading = false;
          CacheNetwork.insertToCache(key: 'uId', value: state.uId);
          uId = state.uId;
          BlocProvider.of<HomeCubit>(context).changeBottomNavBarState(0);
          await BlocProvider.of<HomeCubit>(context).getUserData();
          GoRouter.of(context).go(AppRouter.kHomeView);
        } else if (state is RegisterFailureState) {
          isLoading = false;
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RegisterHeaderSection(),
                      const SizedBox(height: 60),
                      RegisterFormSection(
                        emailController: emailController,
                        passwordController: passwordController,
                        nameController: nameController,
                        phoneController: phoneController,
                      ),
                      const SizedBox(height: 60),
                      CustomElevatedButton(
                        text: 'Sign Up',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await BlocProvider.of<RegisterCubit>(context)
                                .userRegister(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      const RegisterToLoginSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
