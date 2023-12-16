import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../Core/errors/failures.dart';

abstract class EditProfileRepo {
  Future<Either<Failure, void>> editProfile({
    required String name,
    required String phone,
    required String bio,
    required File? profileImage,
    required File? coverImage,
  });

  // logout
  Future<Either<Failure, void>> logoutUser();
}
