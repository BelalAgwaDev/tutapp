import 'package:dartz/dartz.dart';
import 'package:tutapp/domain/model/login_model.dart';

import '../../data/network/failure.dart';
import '../../data/network/request.dart';

abstract class Repository {
  Future<Either<Failure, Authentiacation>> login(LoginRequest loginRequest);
}
