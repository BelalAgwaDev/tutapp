import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutapp/application/app_prfs.dart';
import 'package:tutapp/data/dataSource/remote_data_source.dart';
import 'package:tutapp/data/network/app_api.dart';
import 'package:tutapp/data/network/dioFactory.dart';
import 'package:tutapp/data/network/network_info.dart';
import 'package:tutapp/domain/repository/repository.dart';
import 'package:tutapp/domain/useCase/forget/useCase.dart';
import 'package:tutapp/domain/useCase/login/use_case.dart';
import 'package:tutapp/domain/useCase/register/use_case.dart';
import 'package:tutapp/presentation/login/viewmodel/modelView.dart';

import '../data/repository/repostory_impl.dart';
import '../presentation/forget_password/viewModel/view_model.dart';
import '../presentation/register/viewmodel/viewModel.dart';

final instance =GetIt.instance;
Future<void>initAppModule()async{
  //app module , its a module where we put all generic dependencies
  //shared pref instance
  final sharedPrefs =await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //app prefs instance
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info instance
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory instance
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

   Dio dio =await instance<DioFactory>().getDio();

  //App service client instance
  instance.registerLazySingleton<AppSerivceClient>(() => AppSerivceClient(dio));

  //remote data source instance
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance()));


  // repositry instance
  instance.registerLazySingleton<Repository>(() => RespostoryImpl(instance(),instance()));
}


 initLoginModule() {
   if (!GetIt.I.isRegistered<LoginUseCase>()) {
     instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
     instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
   }
 }

  initForgetPasswordModule() {
    if (!GetIt.I.isRegistered<ForgetPasswordUseCase>()) {
      instance.registerFactory<ForgetPasswordUseCase>(() => ForgetPasswordUseCase(instance()));
      instance.registerFactory<ForgetPasswordViewModel>(() =>
          ForgetPasswordViewModel(instance()));
    }
  }

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(() =>
        RegisterViewModel(instance()));
  }
}