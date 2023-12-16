import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repos/auth_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepo) : super(RegisterInitialState());
  final AuthRepo authRepo;

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_outlined;

  void changePasswordVisibility() {
    emit(RegisterChangePasswordVisibilityLoadingState());
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilitySuccessState());
  }

  Future<void> userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) async {
    emit(RegisterLoadingState());

    var result = await authRepo.userRegister(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );

    result.fold(
      (failure) => emit(RegisterFailureState(errorMessage: failure.errMessage)),
      (credential) => emit(RegisterSuccessState(uId: credential)),
    );
  }
}
