import 'package:tutapp/application/constants.dart';
import 'package:tutapp/data/response/responses.dart';

import '../../domain/model/login_model.dart';
import 'package:tutapp/application/extensions.dart';

extension CustomeResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id.orEmpty() ?? Constant.empty,
        this?.name.orEmpty() ?? Constant.empty,
        this?.numberOfNotification.orZero() ?? Constant.zero);
  }
}



extension ContactResponseMapper on ContactResponse? {
  Contact toDomain() {
    return Contact(
        this?.email.orEmpty() ?? Constant.empty,
        this?.phone.orEmpty() ?? Constant.empty,
        this?.link.orEmpty() ?? Constant.empty
        );
  }
}



extension AuthentiacationResponseMapper on AuthentiacationResponse? {
  Authentiacation toDomain() {
    return Authentiacation(
     this?.contacts.toDomain(),
      this?.customer.toDomain(),
     
        );
  }
}




