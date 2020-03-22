import 'package:json_annotation/json_annotation.dart';
import "package:myapp/models/index.dart";
import "cacheConfig.dart";
part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile();

  LoginStatus loginStatus;
  num theme;
  CacheConfig cache;
  String lastLogin;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
