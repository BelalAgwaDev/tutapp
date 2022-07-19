class ForgetPasswordResponse {
  int? status;
  String? message;
  String? support;

  ForgetPasswordResponse({this.status, this.message, this.support});

  ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    support = json['support'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['support'] = support;
    return data;
  }
}