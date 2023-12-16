part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitialState extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {
  final String uId;

  const LoginSuccessState({required this.uId});
}

final class LoginFailureState extends LoginState {
  final String errorMessage;

  const LoginFailureState({required this.errorMessage});
}

final class LoginChangePasswordVisibilityLoadingState extends LoginState {}

final class LoginChangePasswordVisibilitySuccessState extends LoginState {}
