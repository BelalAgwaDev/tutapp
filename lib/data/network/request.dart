class LoginRequest {
  String email;
  String password;
  LoginRequest(this.email, this.password);
}

class RegisterRequest {
  String username;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String picture;

  RegisterRequest(this.username, this.countryMobileCode, this.mobileNumber,
      this.email, this.password, this.picture);
}

class ForgetPasswordRequest {
  String email;
  ForgetPasswordRequest(this.email);
}
