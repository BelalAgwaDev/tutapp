import 'dart:async';

import 'package:tutapp/domain/useCase/forget/useCase.dart';
import 'package:tutapp/presentation/base/base_view_model.dart';
import 'package:tutapp/presentation/common/freezed.dart';

import '../../common/stateRender/satate_render_impl.dart';
import '../../common/stateRender/state_render_enum.dart';

class ForgetPasswordViewModel extends BaseViewModel with ForgetPasswordViewModelInput,ForgetPasswordViewModelOutput{

  final StreamController _email =StreamController<bool>.broadcast();
  final StreamController _valid =StreamController<void>.broadcast();
  var forgetObject = ForgetObject("");
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  ForgetPasswordViewModel(this._forgetPasswordUseCase);
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _email.close();
    _valid.close();
    super.dispose();
  }

  @override
  forgetPassword() async{
    inputState.add(LoadingState(stateRenderType: StateRenderType.popupLoadingState));
    (await _forgetPasswordUseCase.execute(
        ForgetPasswordUseCaseInput(forgetObject.email)))
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
      inputState.add(SuccessState(stateRenderType: StateRenderType.popupSuccess)),

      Timer(const Duration(seconds: 2),() {
        inputState.add(ContentState());
      },)
    });
  }

  @override
  Sink get inputAllDataValid =>_valid.sink;

  @override
  Sink get inputUserName => _email.sink;


  @override
  Stream<bool> get outIsAllDataValid =>_valid.stream.map((_) => _dataValid());

  @override
  Stream<bool> get outIsUserNameValid => _email.stream.map((email) => _emailValid(email));

  @override
  setEmail(String userName) {
    forgetObject = forgetObject.copyWith(email: userName);
    inputAllDataValid.add(null);
  }




  // private function
 bool _emailValid(String email){
    return email.isNotEmpty;
  }

  bool _dataValid(){
    return forgetObject.email.isNotEmpty;
  }
}


abstract class ForgetPasswordViewModelInput{
  Sink get inputUserName;
  Sink get inputAllDataValid;
  setEmail(String userName);
  forgetPassword();
}

abstract class ForgetPasswordViewModelOutput{
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsAllDataValid;
}