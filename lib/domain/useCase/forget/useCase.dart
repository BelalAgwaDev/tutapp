


import 'package:dartz/dartz.dart';
import 'package:tutapp/data/network/request.dart';
import 'package:tutapp/domain/model/forget_model.dart';

import '../../../data/network/failure.dart';
import '../../repository/repository.dart';
import '../baseUseCase/base_use_case.dart';

class ForgetPasswordUseCase implements BaseUseCase<ForgetPasswordUseCaseInput,ForgetPasswordModel>{
  final Repository _repository;
  ForgetPasswordUseCase(this._repository);
  @override
  Future<Either<Failure, ForgetPasswordModel>> execute(ForgetPasswordUseCaseInput input) async{
    return await _repository.forgetPassword(ForgetPasswordRequest(input.email));
  }

}

class ForgetPasswordUseCaseInput{
  String email;

  ForgetPasswordUseCaseInput(this.email,);
}