part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

// profile image picked
final class ProfileImagePickedSuccessState extends ProfileState {}

final class ProfileImagePickedFailureState extends ProfileState {}

final class ProfileImagePickedLoadingState extends ProfileState {}

// cover image picked
final class CoverImagePickedSuccessState extends ProfileState {}

final class CoverImagePickedFailureState extends ProfileState {}

final class CoverImagePickedLoadingState extends ProfileState {}

// edit profile
final class EditProfileLoadingState extends ProfileState {}

final class EditProfileSuccessState extends ProfileState {}

final class EditProfileFailureState extends ProfileState {
  final String errorMessage;

  const EditProfileFailureState({required this.errorMessage});
}

// logout

final class LogoutLoadingState extends ProfileState {}

final class LogoutSuccessState extends ProfileState {}

final class LogoutFailureState extends ProfileState {
  final String errorMessage;

  const LogoutFailureState({required this.errorMessage});
}
