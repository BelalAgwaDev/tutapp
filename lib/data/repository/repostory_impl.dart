import 'package:tutapp/data/dataSource/remote_data_source.dart';
import 'package:tutapp/data/mapper/forget_mapper.dart';
import 'package:tutapp/data/mapper/mapper.dart';
import 'package:tutapp/data/network/error_handler.dart';
import 'package:tutapp/data/network/network_info.dart';
import 'package:tutapp/domain/model/forget_model.dart';
import 'package:tutapp/domain/model/login_model.dart';
import 'package:tutapp/data/network/request.dart';
import 'package:tutapp/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tutapp/domain/repository/repository.dart';


class RespostoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RespostoryImpl(this._networkInfo, this._remoteDataSource);

  @override
  Future<Either<Failure, Authentiacation>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
// its connect to internet its safe to call api
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.success) {
          // success
          // return data
          return Right(response.toDomain());
        } else {
          // failure --business error
          return left(Failure(ApiInternalStatus.failure,
              response.message ?? ResponseMessage.unKnown));
        }
      } catch (error) {
        return Left(ErrorHandler
            .handle(error)
            .failure);
      }
    } else {
      //return internet connect error
      return left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ForgetPasswordModel>> forgetPassword(
      ForgetPasswordRequest passwordRequest) async {
    if (await _networkInfo.isConnected) {
// its connect to internet its safe to call api
      try {
        final response = await _remoteDataSource.forgetPassword(
            passwordRequest);
        if (response.status == ApiInternalStatus.success) {
          // success
          // return data
          return Right(response.toDomain());
        } else {
          // failure --business error
          return left(Failure(ApiInternalStatus.failure,
              response.message ?? ResponseMessage.unKnown));
        }
      } catch (error) {
        return Left(ErrorHandler
            .handle(error)
            .failure);
      }
    } else {
      //return internet connect error
      return left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentiacation>> register(RegisterRequest registerRequest) async{

    if (await _networkInfo.isConnected) {
// its connect to internet its safe to call api
      try {
        final response = await _remoteDataSource.register(registerRequest);
        if (response.status == ApiInternalStatus.success) {
          // success
          // return data
          return Right(response.toDomain());
        } else {
          // failure --business error
          return left(Failure(ApiInternalStatus.failure,
              response.message ?? ResponseMessage.unKnown));
        }
      } catch (error) {
        return Left(ErrorHandler
            .handle(error)
            .failure);
      }
    } else {
      //return internet connect error
      return left(DataSource.noInternetConnection.getFailure());
    }
  }
}
