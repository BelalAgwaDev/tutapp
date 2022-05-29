import 'package:dio/dio.dart';
import 'package:tutapp/data/network/failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      //dio Error so its an error from response of the api or from dio itself
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.unKnown.getFailure();
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSource.connectTimeOut.getFailure();

    case DioErrorType.sendTimeout:
      return DataSource.sendTimeOut.getFailure();

    case DioErrorType.receiveTimeout:
      return DataSource.recieveTimeOut.getFailure();

    case DioErrorType.response:
      if (error.response?.statusCode != null &&
          error.response?.statusMessage != null &&
          error.response != null) {
        return Failure(error.response?.statusCode ?? 0,
            error.response?.statusMessage ?? "");
      } else {
        return DataSource.unKnown.getFailure();
      }

    case DioErrorType.cancel:
      return DataSource.cancel.getFailure();

    case DioErrorType.other:
      return DataSource.unKnown.getFailure();
  }
}

enum DataSource {
  success,
  noContent,
  badRequest,
  forBidden,
  unAutorised,
  notFound,
  internetServerError,
  connectTimeOut,
  cancel,
  recieveTimeOut,
  sendTimeOut,
  cashError,
  noInternetConnection,
  unKnown
}

extension DataSourcEextension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forBidden:
        return Failure(ResponseCode.forBidden, ResponseMessage.forBidden);
      case DataSource.unAutorised:
        return Failure(ResponseCode.unAutorised, ResponseMessage.unAutorised);
      case DataSource.internetServerError:
        return Failure(ResponseCode.internetServerError,
            ResponseMessage.internetServerError);
      case DataSource.connectTimeOut:
        return Failure(
            ResponseCode.connectTimeOut, ResponseMessage.connectTimeOut);
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.recieveTimeOut:
        return Failure(
            ResponseCode.recieveTimeOut, ResponseMessage.recieveTimeOut);
      case DataSource.sendTimeOut:
        return Failure(ResponseCode.sendTimeOut, ResponseMessage.sendTimeOut);
      case DataSource.cashError:
        return Failure(ResponseCode.cashError, ResponseMessage.cashError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      case DataSource.unKnown:
        return Failure(ResponseCode.unKnown, ResponseMessage.unKnown);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
    }
  }
}

class ResponseCode {
  static const int success = 200; //success with data
  static const int noContent = 201; //success with no data (no content)
  static const int badRequest = 400; //failure ,api rejected request
  static const int forBidden = 403; //failure ,api rejected request
  static const int notFound = 404; //failure ,api rejected request
  static const int unAutorised =
      401; // failure user is not authorised   (token)
  static const int internetServerError = 500; //failure crash in server side

// local status code
  static const int connectTimeOut = -1;
  static const int cancel = -2;
  static const int recieveTimeOut = -3;
  static const int sendTimeOut = -4;
  static const int cashError = -5;
  static const int noInternetConnection = -6;
  static const int unKnown = -7;
}

class ResponseMessage {
  static const String success = "success"; //success with data
  static const String notFound =
      "some thing went ,try again later"; //success with data
  static const String noContent = "success"; //success with no data (no content)
  static const String badRequest =
      "bad request, try again later"; //failure ,api rejected request
  static const String forBidden =
      "Forbidden request, try again later"; //failure ,api rejected request
  static const String unAutorised =
      "user is unauthorised ,try again later"; // failure user is not authorised   (token)
  static const String internetServerError =
      "some thing went ,try again later"; //failure crash in server side

// local status code
  static const String connectTimeOut = "time out error try again later";
  static const String cancel = "request was cancelled ,try again later";
  static const String recieveTimeOut = "time out error try again later";
  static const String sendTimeOut = "time out error try again later";
  static const String cashError = "cash error try again later";
  static const String noInternetConnection =
      "please check your internet connection";
  static const String unKnown = "some thing went ,try again later";
}




class ApiInternalStatus{
  static const int success=0;
  static const int failure=1;
}