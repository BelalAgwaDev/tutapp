import 'package:tutapp/data/network/app_api.dart';
import 'package:tutapp/data/network/request.dart';
import 'package:tutapp/data/response/forgetPassword/response.dart';
import 'package:tutapp/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthentiacationResponse> login(LoginRequest loginRequest);
  Future<AuthentiacationResponse> register(RegisterRequest registerRequest);
  Future<ForgetPasswordResponse> forgetPassword(
      ForgetPasswordRequest forgetPasswordRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppSerivceClient _appSerivceClient;
  RemoteDataSourceImpl(this._appSerivceClient);
  @override
  Future<AuthentiacationResponse> login(LoginRequest loginRequest) async {
    return await _appSerivceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(
      ForgetPasswordRequest forgetPasswordRequest) async {
    return await _appSerivceClient.forgetPassword(forgetPasswordRequest.email);
  }

  @override
  Future<AuthentiacationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appSerivceClient.register(
        registerRequest.username,
        registerRequest.countryMobileCode,
        registerRequest.mobileNumber,
        registerRequest.email,
        registerRequest.password,
        registerRequest.picture);
  }
}
