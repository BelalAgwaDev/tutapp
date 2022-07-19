import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String userPassword) = _LoginObject;
}

@freezed
class ForgetObject with _$ForgetObject {
  factory ForgetObject(String email) = _ForgetObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
      String username,
      String countryMobileCode,
      String mobileNumber,
      String email,
      String password,
      String picture) = _RegisterObject;
}
