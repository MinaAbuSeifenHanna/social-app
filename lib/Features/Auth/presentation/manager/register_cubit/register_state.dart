part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitialState extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterSuccessState extends RegisterState {
  final String uId;

  const RegisterSuccessState({required this.uId});
}

final class RegisterFailureState extends RegisterState {
  final String errorMessage;

  const RegisterFailureState({required this.errorMessage});
}

final class RegisterChangePasswordVisibilityLoadingState
    extends RegisterState {}

final class RegisterChangePasswordVisibilitySuccessState
    extends RegisterState {}
