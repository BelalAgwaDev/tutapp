import 'package:tutapp/data/network/app_api.dart';
import 'package:tutapp/data/network/request.dart';
import 'package:tutapp/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthentiacationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppSerivceClient _appSerivceClient;
  RemoteDataSourceImpl(this._appSerivceClient);
  @override
  Future<AuthentiacationResponse> login(LoginRequest loginRequest) async {
    return await _appSerivceClient.login(
        loginRequest.email, loginRequest.password);
  }
}
