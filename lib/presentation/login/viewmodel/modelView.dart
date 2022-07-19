import 'dart:async';

import 'package:tutapp/domain/useCase/login/use_case.dart';
import 'package:tutapp/presentation/common/freezed.dart';
import 'package:tutapp/presentation/common/stateRender/satate_render_impl.dart';
import 'package:tutapp/presentation/common/stateRender/state_render_enum.dart';

import '../../base/base_view_model.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutPut {
  final StreamController _nameStreamController =
  StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
  StreamController<String>.broadcast();

  final StreamController _allDataValidController =
  StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  // ------input
  @override
  void dispose() {
    super.dispose();
    _nameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  login() async {
    inputState.add(LoadingState(stateRenderType: StateRenderType.popupLoadingState));
    (await _loginUseCase.execute(
        LoginUseCaseInput(loginObject.userName, loginObject.userPassword)))
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
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    inputAllDataValid.add(null);
  }

  @override
  setUserPassword(String userPassword) {
    inputPasswordName.add(userPassword);
    loginObject = loginObject.copyWith(userPassword: userPassword);
    inputAllDataValid.add(null);
  }

  @override
  Sink get inputPasswordName => _nameStreamController.sink;

  @override
  Sink get inputUserName => _passwordStreamController.sink;


  @override
  Sink get inputAllDataValid => _allDataValidController.sink;

  //----- output

  @override
  Stream<bool> get outIsUserNameValid =>
      _nameStreamController.stream.map((userName) => _userNameValid(userName));

  @override
  Stream<bool> get outIsUserPasswordValid =>
      _passwordStreamController.stream
          .map((password) => _userPasswordValid(password));


  @override
  Stream<bool> get outIsAllDataValid =>
      _allDataValidController.stream.map((_) => _areAllDataValid());


// ---- private function

  bool _areAllDataValid() {
    return _userNameValid(loginObject.userName) && _userPasswordValid(loginObject.userPassword);
  }

  bool _userNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _userPasswordValid(String password) {
    return password.isNotEmpty;
  }

}
abstract class LoginViewModelInput {
  Sink get inputUserName;
  Sink get inputPasswordName;
  Sink get inputAllDataValid;
  setUserName(String userName);
  setUserPassword(String userPassword);
  login();
}

abstract class LoginViewModelOutPut {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsUserPasswordValid;
  Stream<bool> get outIsAllDataValid;
}
