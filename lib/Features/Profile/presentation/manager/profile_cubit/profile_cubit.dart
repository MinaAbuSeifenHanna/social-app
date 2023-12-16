import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repos/edit_profile_repo_impl.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.editProfileRepo) : super(ProfileInitial());

  final EditProfileRepoImpl editProfileRepo;

  File? profileImage;
  File? coverImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    emit(ProfileImagePickedLoadingState());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      emit(ProfileImagePickedFailureState());
    }
  }

  Future<void> getCoverImage() async {
    emit(CoverImagePickedLoadingState());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      emit(CoverImagePickedFailureState());
    }
  }

  Future<void> editProfile({
    required String name,
    required String bio,
    required String phone,
  }) async {
    emit(EditProfileLoadingState());

    var result = await editProfileRepo.editProfile(
      name: name,
      bio: bio,
      phone: phone,
      profileImage: profileImage,
      coverImage: coverImage,
    );

    result.fold(
      (failure) =>
          emit(EditProfileFailureState(errorMessage: failure.errMessage)),
      (_) => emit(EditProfileSuccessState()),
    );
  }

  // logout
  Future<void> logoutUser() async {
    emit(LogoutLoadingState());

    var result = await editProfileRepo.logoutUser();

    result.fold(
      (failure) => emit(LogoutFailureState(errorMessage: failure.errMessage)),
      (_) => emit(LogoutSuccessState()),
    );
  }
}
