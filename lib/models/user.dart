import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
    User();

    num uid;
    String customstatus;
    String regdate;
    String username;
    String tmpphone;
    num fansnum;
    num followuidnum;
    num posts;
    num threads;
    num digestposts;
    num punchallday;
    num punchday;
    num punchhighestday;
    num punchtime;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}
