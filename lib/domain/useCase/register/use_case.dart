import 'package:dartz/dartz.dart';
import 'package:tutapp/data/network/request.dart';

import '../../../data/network/failure.dart';
import '../../model/login_model.dart';
import '../../repository/repository.dart';
import '../baseUseCase/base_use_case.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentiacation> {
  final Repository _repository;
  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, Authentiacation>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
        input.username,
        input.countryMobileCode,
        input.mobileNumber,
        input.email,
        input.password,
        input.picture));
  }
}

class RegisterUseCaseInput {
  String username;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String picture;

  RegisterUseCaseInput(this.username, this.countryMobileCode, this.mobileNumber,
      this.email, this.password, this.picture);
}
