
import 'package:tutapp/data/response/forgetPassword/response.dart';
import 'package:tutapp/application/extensions.dart';
import '../../application/constants.dart';
import '../../domain/model/forget_model.dart';

extension ContactResponseMapper on ForgetPasswordResponse? {
  ForgetPasswordModel toDomain() {
    return ForgetPasswordModel(
        this?.status.orZero() ?? Constant.zero,
        this?.message.orEmpty() ?? Constant.empty,
        this?.support .orEmpty() ?? Constant.empty,

    );
  }
}