import 'package:flutter/material.dart';
import 'package:tutapp/presentation/common/stateRender/satate_render_impl.dart';
import 'package:tutapp/presentation/login/viewmodel/modelView.dart';
import 'package:tutapp/presentation/resources/assest_manger.dart';
import 'package:tutapp/presentation/resources/color_manger.dart';
import 'package:tutapp/presentation/resources/strings_manger.dart';
import 'package:tutapp/presentation/resources/values_manger.dart';

import '../../../application/di.dart';
import '../../resources/routes_manger.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LonginViewState();
}

class _LonginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _userPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  _bind() {
    _viewModel.start();
    _userName.addListener(() => _viewModel.setUserName(_userName.text));
    _userPassword
        .addListener(() => _viewModel.setUserPassword(_userPassword.text));
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
      body: Padding(
        padding: const EdgeInsets.only(
            top: AppPaddingSizeMange.p180,
            left: AppPaddingSizeMange.p18,
            right: AppPaddingSizeMange.p18),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const Center(child: Image(image: AssetImage(AppImage.splach))),
              const SizedBox(
                height: AppSizeMange.s18,
              ),
              StreamBuilder<bool>(
                stream: _viewModel.outIsUserPasswordValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _userName,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: AppStringsManger.username,
                        hintText: AppStringsManger.username,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStringsManger.userNameError),
                  );
                },
              ),
              const SizedBox(
                height: AppSizeMange.s24,
              ),
              StreamBuilder<bool>(
                stream: _viewModel.outIsUserNameValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _userPassword,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        labelText: AppStringsManger.password,
                        hintText: AppStringsManger.password,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStringsManger.userPasswordError),
                  );
                },
              ),
              const SizedBox(
                height: AppSizeMange.s24,
              ),
              StreamBuilder<bool>(
                stream: _viewModel.outIsAllDataValid,
                builder: (context, snapshot) {
                  return SizedBox(
                    height: AppSizeMange.s50,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () {
                                _viewModel.login();
                              }
                            : null,
                        child: const Text(AppStringsManger.login)),
                  );
                },
              ),
              const SizedBox(
                height: AppSizeMange.s14,
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.forgetPasswordRoute);
                      },
                      child: Text(
                        AppStringsManger.forgetpassword,
                        style: TextStyle(color: ColorManger.primary),
                      )),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.registerRoute);
                      },
                      child: Text(
                        AppStringsManger.notamemberSignup,
                        style: TextStyle(color: ColorManger.primary),
                      ))
                ],
              )
            ]),
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
