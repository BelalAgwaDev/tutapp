import 'package:flutter/material.dart';
import 'package:tutapp/presentation/forget_password/view/view_forget_password.dart';
import 'package:tutapp/presentation/login/view/login_view.dart';
import 'package:tutapp/presentation/main/view/main_view.dart';
import 'package:tutapp/presentation/register/view/register_view.dart';
import 'package:tutapp/presentation/resources/strings_manger.dart';
import 'package:tutapp/presentation/splach/view/splach_view.dart';
import 'package:tutapp/presentation/store_details/view/stoew_details_view.dart';

import '../../application/di.dart';
import '../onboarding/view/onboarding_view.dart';

class Routes {
  static const String splachRoute = "/";
  static const String onBordingRoute = "/onBording";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splachRoute:
        return MaterialPageRoute(
          builder: (context) => const SplachView(),
        );

      case Routes.onBordingRoute:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingView(),
        );

      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );

      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(
          builder: (context) => const RegisterView(),
        );

      case Routes.mainRoute:
        return MaterialPageRoute(
          builder: (context) => const MainView(),
        );

      case Routes.forgetPasswordRoute:
        initForgetPasswordModule();
        return MaterialPageRoute(
          builder: (context) => const ForgetPassword(),
        );
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(
          builder: (context) => const StoreDetailsView(),
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text(AppStringsManger.noRouteFound)),
        body: const Center(child: Text(AppStringsManger.noRouteFound)),
      ),
    );
  }
}
