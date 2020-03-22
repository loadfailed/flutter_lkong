import 'package:json_annotation/json_annotation.dart';

part 'loginStatus.g.dart';

@JsonSerializable()
class LoginStatus {
  LoginStatus();

  num uid;
  String name;
  String yousuu;
  bool success;

  factory LoginStatus.fromJson(Map<String, dynamic> json) =>
      _$LoginStatusFromJson(json);
  Map<String, dynamic> toJson() => _$LoginStatusToJson(this);
}
