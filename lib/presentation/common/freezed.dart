import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed.freezed.dart';

@freezed
class LoginObject with _$LoginObject{
  factory LoginObject(String userName,String userPassword)=_LoginObject;
}