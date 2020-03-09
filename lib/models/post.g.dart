// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post()
    ..isquote = json['isquote'] as bool
    ..uid = json['uid'] as String
    ..username = json['username'] as String
    ..dateline = json['dateline'] as String
    ..message = json['message'] as String
    ..isthread = json['isthread'] as bool
    ..id = json['id'] as String
    ..replynum = json['replynum'] as num
    ..subject = json['subject'] as String
    ..sortkey = json['sortkey'] as num;
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'isquote': instance.isquote,
      'uid': instance.uid,
      'username': instance.username,
      'dateline': instance.dateline,
      'message': instance.message,
      'isthread': instance.isthread,
      'id': instance.id,
      'replynum': instance.replynum,
      'subject': instance.subject,
      'sortkey': instance.sortkey
    };
