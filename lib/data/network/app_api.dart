import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tutapp/data/response/responses.dart';

import '../../application/constants.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppSerivceClient {
  factory AppSerivceClient(Dio dio, {String baseUrl}) = _AppSerivceClient;
  @POST("/customer/login")
  Future<AuthentiacationResponse> login(
    @Field("email") String email,
    @Field("password") String password
  );
}
