import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:social_app/Core/errors/failures.dart';

import '../../../../Core/models/user_model.dart';
import '../../../../Core/utils/constants.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  @override
  Future<Either<Failure, UserModel>> getUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userData =
          await FirebaseFirestore.instance.collection('users').doc(uId).get();
      UserModel userModel = UserModel.fromMap(userData.data()!);
      user = userModel;
      return right(userModel);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers() async {
    try {
      List<UserModel> users = [];

      QuerySnapshot<Map<String, dynamic>> data =
          await FirebaseFirestore.instance.collection('users').get();

      for (var item in data.docs) {
        users.add(UserModel.fromMap(item.data()));
      }
      return right(users);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
