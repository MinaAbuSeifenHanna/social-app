import 'package:dartz/dartz.dart';

import '../../../../Core/errors/failures.dart';
import '../../../../Core/models/user_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, UserModel>> getUserData();
  Future<Either<Failure, List<UserModel>>> getAllUsers();
}
