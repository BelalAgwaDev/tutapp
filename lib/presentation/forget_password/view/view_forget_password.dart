import 'package:flutter/material.dart';
import 'package:tutapp/presentation/resources/color_manger.dart';
import 'package:tutapp/presentation/resources/values_manger.dart';

import '../../../application/di.dart';
import '../../common/stateRender/satate_render_impl.dart';
import '../../resources/assest_manger.dart';
import '../../resources/routes_manger.dart';
import '../../resources/strings_manger.dart';
import '../viewModel/view_model.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final ForgetPasswordViewModel _viewModel =
      instance<ForgetPasswordViewModel>();
  final TextEditingController _userName = TextEditingController();

  _bind() {
    _userName.addListener(() => _viewModel.setEmail(_userName.text));
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(context, _getData(), () {}) ??
            _getData();
      },
    );
  }

  Widget _getData() {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: AppPaddingSizeMange.p24,right:AppPaddingSizeMange.p24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Center(child: Image(image: AssetImage(AppImage.splach))),
              const SizedBox(
                height: AppPaddingSizeMange.p20,
              ),
              StreamBuilder<bool>(
                stream: _viewModel.outIsUserNameValid,
                builder: (context, snapshot) {
                  return TextFormField(
                      controller: _userName,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: AppStringsManger.username,
                          hintText: AppStringsManger.username,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStringsManger.userNameError));
                },
              ),
              const SizedBox(
                height: AppPaddingSizeMange.p20,
              ),
              StreamBuilder<bool>(
                stream: _viewModel.outIsAllDataValid,
                builder: (context, snapshot) {
                  return SizedBox(
                    width: double.infinity,
                    height: AppSizeMange.s50,
                    child: ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () {
                                _viewModel.forgetPassword();
                              }
                            : null,
                        child: const Text(AppStringsManger.restPassword)),
                  );
                },
              ),
              TextButton(onPressed: (){
                Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
              }, child:  Text(AppStringsManger.recieve,style: TextStyle(
                color: ColorManger.primary
              ),))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
