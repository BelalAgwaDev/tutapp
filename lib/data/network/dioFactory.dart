import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tutapp/application/app_prfs.dart';
import 'package:tutapp/application/constants.dart';

const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
const String authorization = "authorization";
const String language = "language";

class DioFactory {
  final AppPreferences _appPreferences;
  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();
    String lang = await _appPreferences.getAppLanguage();
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: Constant.token,
      language: lang //todo get language from app prefs
    };
    dio.options = BaseOptions(
        baseUrl: Constant.baseUrl,
        headers: headers,
        receiveTimeout: Constant.apiTimeOut,
        sendTimeout: Constant.apiTimeOut);

    if (!kReleaseMode) {
      // its debug mode so print app logs
      dio.interceptors.add(PrettyDioLogger(
          responseHeader: true, requestBody: true, requestHeader: true));
    }
    return dio;
  }
}
