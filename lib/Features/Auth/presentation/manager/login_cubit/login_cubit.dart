import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_app/Features/Auth/data/repos/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitialState());

  final AuthRepo authRepo;

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_outlined;

  void changePasswordVisibility() {
    emit(LoginChangePasswordVisibilityLoadingState());
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilitySuccessState());
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    var result = await authRepo.userLogin(email: email, password: password);

    result.fold(
      (failure) => emit(LoginFailureState(errorMessage: failure.errMessage)),
      (credential) => emit(LoginSuccessState(uId: credential)),
    );
  }
}
