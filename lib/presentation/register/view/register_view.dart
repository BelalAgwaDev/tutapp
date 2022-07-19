import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:tutapp/presentation/register/viewmodel/viewModel.dart';

import '../../../application/di.dart';
import '../../common/stateRender/satate_render_impl.dart';
import '../../resources/assest_manger.dart';
import '../../resources/color_manger.dart';
import '../../resources/routes_manger.dart';
import '../../resources/strings_manger.dart';
import '../../resources/values_manger.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();

  final TextEditingController _userName = TextEditingController();
  final TextEditingController _userPassword = TextEditingController();
  final TextEditingController _userEmail = TextEditingController();
  final TextEditingController _userPhone = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _bind() {
    _userName.addListener(() => _viewModel.setUserName(_userName.text));
    _userPassword.addListener(() => _viewModel.setUserPassword(_userPassword.text));
    _userPhone.addListener(() => _viewModel.setUserPhone(_userPhone.text));
    _userEmail.addListener(() => _viewModel.setUserEmail(_userEmail.text));
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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: AppSizeMange.s20,right:  AppSizeMange.s20,top:  AppSizeMange.s96),
            child: SingleChildScrollView(
              child: Column(

                children: [
                  const Center(child: Image(image: AssetImage(AppImage.splach))),
                  const SizedBox(
                    height: AppSizeMange.s18,
                  ),
                  StreamBuilder<bool>(
                    stream: _viewModel.outIsUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _userName,
                        keyboardType: TextInputType.name,
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
                    height: AppSizeMange.s18,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: CountryCodePicker(
                            onChanged: (value) {
                              _viewModel.countryCode = value.dialCode!;
                              _viewModel.setUserPhoneCode(_viewModel.countryCode);

                            },
                            initialSelection: "+20",
                            favorite: const ["+20", "+39", "FR", "+966"],
                            showCountryOnly: true,
                            hideMainText: true,
                            showOnlyCountryWhenClosed: true,
                          )),
                      Expanded(
                        flex: 4,
                        child: StreamBuilder<bool>(
                          stream: _viewModel.outIsUserPhoneValid,
                          builder: (context, snapshot) {
                            return TextFormField(
                              controller: _userPhone,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  labelText: AppStringsManger.userPhone,
                                  hintText: AppStringsManger.userPhone,
                                  errorText: (snapshot.data ?? true)
                                      ? null
                                      : AppStringsManger.userPhoneError),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizeMange.s18,
                  ),
                  StreamBuilder<bool>(
                    stream: _viewModel.outIsUserEmailValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _userEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: AppStringsManger.email,
                            hintText: AppStringsManger.email,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStringsManger.emailError),
                      );
                    },
                  ),
                  const SizedBox(
                    height: AppSizeMange.s18,
                  ),
                  StreamBuilder<bool>(
                    stream: _viewModel.outIsUserPasswordValid,
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
                    height: AppSizeMange.s18,
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
                              _viewModel.register();
                            }
                                : null,
                            child: const Text(AppStringsManger.register)),
                      );
                    },
                  ),
                  TextButton(onPressed: (){
                    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
                  }, child:  Text(AppStringsManger.haveAccount,style: TextStyle(
                      color: ColorManger.primary
                  ),))
                ],
              ),
            ),
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
