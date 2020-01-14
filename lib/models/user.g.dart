// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..uid = json['uid'] as num
    ..name = json['name'] as String
    ..yousuu = json['yousuu'] as String
    ..success = json['success'] as bool;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'yousuu': instance.yousuu,
      'success': instance.success
    };
