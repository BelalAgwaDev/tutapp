import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tutapp/data/response/forgetPassword/response.dart';
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

  @POST("/customer/register")
  Future<AuthentiacationResponse> register(
      @Field("user_name") String userName,
      @Field("country_mobile_code") String countryMobileCode,
      @Field("mobile_number") String mobileNumber,
      @Field("email") String email,
      @Field("password") String password,
      @Field("picture") String picture
      );


  @POST("/customer/forgetPassword")
  Future<ForgetPasswordResponse> forgetPassword(
      @Field("email") String email);



}
