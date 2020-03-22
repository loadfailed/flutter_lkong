// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginStatus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginStatus _$LoginStatusFromJson(Map<String, dynamic> json) {
  return LoginStatus()
    ..uid = json['uid'] as num
    ..name = json['name'] as String
    ..yousuu = json['yousuu'] as String
    ..success = json['success'] as bool;
}

Map<String, dynamic> _$LoginStatusToJson(LoginStatus instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'yousuu': instance.yousuu,
      'success': instance.success
    };
