import 'dart:async';

import 'package:analyzer/file_system/file_system.dart';
import 'package:tutapp/domain/useCase/register/use_case.dart';
import 'package:tutapp/presentation/base/base_view_model.dart';

import '../../common/freezed.dart';
import '../../common/stateRender/satate_render_impl.dart';
import '../../common/stateRender/state_render_enum.dart';

class RegisterViewModel extends BaseViewModel with RegisterViewModelInput,RegisterViewModelOutPut {
  final StreamController _nameStreamController =
      StreamController.broadcast();
  final StreamController _passwordStreamController =
      StreamController.broadcast();
  final StreamController _phoneStreamController =
  StreamController.broadcast();
  final StreamController _emailStreamController =
  StreamController.broadcast();
  final StreamController _pictureStreamController =
  StreamController<File>.broadcast();
  final StreamController _allDataValidController =
      StreamController<void>.broadcast();

  String countryCode = "+20";

  var registerObject =RegisterObject("","","","","","");
  final RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _nameStreamController.close();
    _passwordStreamController.close();
    _phoneStreamController.close();
    _emailStreamController.close();
    _pictureStreamController.close();
    _allDataValidController.close();
    super.dispose();
  }

  @override
  register() async{
    inputState.add(LoadingState(stateRenderType: StateRenderType.popupLoadingState));
    (await _registerUseCase.execute(
    RegisterUseCaseInput( registerObject.username,
        registerObject.countryMobileCode,
        registerObject.mobileNumber,
        registerObject.email,
        registerObject.password,
        registerObject.picture)))
        .fold(
    (left) =>
    {
    //left failure
    inputState.add(ErrorState(stateRenderType: StateRenderType.popupErrorState,message: left.message))
    },
    (data) =>
    {
    //right ->data (success)
//content
    inputState.add(ContentState())
    //navigate to main screen
    });

  }

  @override
  Sink get inputAllDataValid => _allDataValidController.sink;

  @override
  Sink get inputPasswordName => _passwordStreamController.sink;

  @override
  Sink get inputPhone => _phoneStreamController.sink;

  @override
  Sink get inputPicture => _pictureStreamController.sink;

  @override
  Sink get inputUserEmail => _emailStreamController.sink;

  @override
  Sink get inputUserName => _nameStreamController.sink;



  // ---OUTPUT----

  @override
  Stream<bool> get outIsAllDataValid => _allDataValidController.stream.map((_) => _allDataValid());

  @override
  Stream<bool> get outIsUserEmailValid => _emailStreamController.stream.map((data1) => _emailValid(data1));

  @override
  Stream<bool> get outIsUserNameValid => _nameStreamController.stream.map((data2) => _nameValid(data2));

  @override
  Stream<bool> get outIsUserPasswordValid => _passwordStreamController.stream.map((data3) => _dataValid(data3));

  @override
  Stream<bool> get outIsUserPhoneValid => _phoneStreamController.stream.map((phone) => _phoneValid(phone));

  @override
  Stream<File> get outIsUserPictureValid => _pictureStreamController.stream.map((file) => file);


  // private function
 bool _phoneValid(String phone){
    return phone.length <=12;
  }

  bool _dataValid(String data){
   return data.isNotEmpty;
  }

  bool _emailValid(String data){
    return data.isNotEmpty;
  }

  bool _nameValid(String data){
    return data.isNotEmpty;
  }



  bool _allDataValid(){
   return registerObject.email.isNotEmpty&&
    registerObject.password.isNotEmpty&&
    registerObject.mobileNumber.isNotEmpty&&
    registerObject.countryMobileCode.isNotEmpty&&
    registerObject.username.isNotEmpty;
  }

  @override
  setUserEmail(String userEmail) {
    inputUserName.add(userEmail);
    registerObject = registerObject.copyWith(email: userEmail);
    inputAllDataValid.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    registerObject = registerObject.copyWith(username: userName);
    inputAllDataValid.add(null);
  }

  @override
  setUserPassword(String userPassword) {
    inputUserName.add(userPassword);
    registerObject = registerObject.copyWith( password: userPassword);
    inputAllDataValid.add(null);
  }

  @override
  setUserPhone(String userPhone) {
    inputUserName.add(userPhone);
    registerObject = registerObject.copyWith( mobileNumber: userPhone);
    inputAllDataValid.add(null);
  }

  @override
  setUserPhoneCode(String phoneCode) {
    inputUserName.add(phoneCode);
    registerObject = registerObject.copyWith( countryMobileCode: phoneCode);
    inputAllDataValid.add(null);
  }

  @override
  setUserPicture(String userPicture) {
    inputUserName.add(userPicture);
    registerObject = registerObject.copyWith( picture: userPicture);
    inputAllDataValid.add(null);
  }


}

abstract class RegisterViewModelInput {
  Sink get inputUserName;
  Sink get inputPasswordName;
  Sink get inputAllDataValid;
  Sink get inputUserEmail;
  Sink get inputPhone;
  Sink get inputPicture;
  setUserName(String userName);
  setUserPassword(String userPassword);
  setUserEmail(String userEmail);
  setUserPicture(String userPicture);
  setUserPhone(String userPhone);
  setUserPhoneCode(String phoneCode);
  register();
}

abstract class RegisterViewModelOutPut {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsUserPasswordValid;
  Stream<bool> get outIsAllDataValid;
  Stream<bool> get outIsUserEmailValid;
  Stream<File> get outIsUserPictureValid;
  Stream<bool> get outIsUserPhoneValid;
}
