// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..uid = json['uid'] as num
    ..customstatus = json['customstatus'] as String
    ..regdate = json['regdate'] as String
    ..username = json['username'] as String
    ..tmpphone = json['tmpphone'] as String
    ..fansnum = json['fansnum'] as num
    ..followuidnum = json['followuidnum'] as num
    ..posts = json['posts'] as num
    ..threads = json['threads'] as num
    ..digestposts = json['digestposts'] as num
    ..punchallday = json['punchallday'] as num
    ..punchday = json['punchday'] as num
    ..punchhighestday = json['punchhighestday'] as num
    ..punchtime = json['punchtime'] as num;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'customstatus': instance.customstatus,
      'regdate': instance.regdate,
      'username': instance.username,
      'tmpphone': instance.tmpphone,
      'fansnum': instance.fansnum,
      'followuidnum': instance.followuidnum,
      'posts': instance.posts,
      'threads': instance.threads,
      'digestposts': instance.digestposts,
      'punchallday': instance.punchallday,
      'punchday': instance.punchday,
      'punchhighestday': instance.punchhighestday,
      'punchtime': instance.punchtime
    };
