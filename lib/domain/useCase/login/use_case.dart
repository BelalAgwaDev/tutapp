import 'package:dartz/dartz.dart';
import 'package:tutapp/data/network/failure.dart';
import 'package:tutapp/data/network/request.dart';
import 'package:tutapp/domain/model/login_model.dart';
import 'package:tutapp/domain/useCase/baseUseCase/base_use_case.dart';

import '../../repository/repository.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput,Authentiacation>{
  final Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentiacation>> execute(LoginUseCaseInput input) async{
       return await _repository.login(LoginRequest(input.email, input.password));
  }

}

class LoginUseCaseInput{
  String email;
  String password;
  LoginUseCaseInput(this.email,this.password);
}