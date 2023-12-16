import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Core/models/user_model.dart';

import '../../../../Core/errors/failures.dart';
import '../../../../Core/utils/cache_network.dart';
import '../../../../Core/utils/constants.dart';
import 'edit_profile_repo.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfileRepoImpl implements EditProfileRepo {
  @override
  Future<Either<Failure, void>> editProfile({
    required String name,
    required String phone,
    required String bio,
    required File? profileImage,
    required File? coverImage,
  }) async {
    try {
      String profileImageUrl = user.image!;
      if (profileImage != null) {
        firebase_storage.Reference refPath = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('profileImages/')
            .child(Uri.file(profileImage.path).pathSegments.last);

        Uint8List imageData = await XFile(profileImage.path).readAsBytes();
        firebase_storage.UploadTask uploadTask = refPath.putData(imageData);

        await uploadTask.then((firebase_storage.TaskSnapshot taskSnapshot) {
          return taskSnapshot.ref.getDownloadURL().then((value) {
            profileImageUrl = value.toString();
            return value;
          });
        }).catchError((e) {
          return ('Failed to upload image to storage: $e');
        });
      }

      String coverImageUrl = user.cover!;
      if (coverImage != null) {
        firebase_storage.Reference refPath = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('coverImages/')
            .child(Uri.file(coverImage.path).pathSegments.last);

        Uint8List imageData = await XFile(coverImage.path).readAsBytes();
        firebase_storage.UploadTask uploadTask = refPath.putData(imageData);

        await uploadTask.then((firebase_storage.TaskSnapshot taskSnapshot) {
          return taskSnapshot.ref.getDownloadURL().then((value) {
            coverImageUrl = value.toString();
            return value;
          });
        }).catchError((e) {
          return ('Failed to upload image to storage: $e');
        });
      }

      UserModel userModel = UserModel(
        name: name,
        phone: phone,
        bio: bio,
        cover: coverImageUrl,
        image: profileImageUrl,
        uId: user.uId,
        email: user.email,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uId)
          .update(userModel.toMap());
      // update user
      user = userModel;
      return right(null);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  // logout
  @override
  Future<Either<Failure, void>> logoutUser() async {
    try {
      CacheNetwork.deleteCacheItem(key: 'uId');
      uId = null;
      return right(null);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
