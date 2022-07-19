import 'package:dartz/dartz.dart';
import 'package:tutapp/domain/model/forget_model.dart';
import 'package:tutapp/domain/model/login_model.dart';

import '../../data/network/failure.dart';
import '../../data/network/request.dart';

abstract class Repository {
  Future<Either<Failure, Authentiacation>> login(LoginRequest loginRequest);
  Future<Either<Failure, Authentiacation>> register(RegisterRequest registerRequest);
  Future<Either<Failure, ForgetPasswordModel>> forgetPassword(ForgetPasswordRequest passwordRequest);
}
