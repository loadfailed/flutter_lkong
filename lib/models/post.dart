import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  Post();

  bool isquote;
  String uid;
  String username;
  String dateline;
  String message;
  bool isthread;
  String id;
  num replynum;
  String subject;
  num sortkey;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
