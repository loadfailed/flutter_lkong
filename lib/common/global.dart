import 'package:flutter/material.dart';
import 'package:myapp/models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

// 提供五套可选主题色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

// 全局设置
class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();
  // 网络缓存对象
  // ...
  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;
  // 是否为release版
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  // 初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }
    // ...
  }

  // 持久化Profile信息
  static saveProfile() => {
        _prefs.setString(
            "profile",
            jsonEncode(
              profile.toJson(),
            ))
      };
}

// 共享状态基类
class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;
  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}

class UserModel extends ProfileChangeNotifier {
  User get user => _profile.user;
  // 是否登陆
  bool get isLogin => user != null;
  // 用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(User user) {
    if (user?.uid != _profile.user?.uid) {
      _profile.user = user;
      notifyListeners();
    }
  }
}

// 主题状态
// class ThemeModel extends ProfileChangeNotifier {
//   ColorSwatch get theme => Global.themes
//       .firstWhere((e) => e.value == _profile.theme, orElse: () => Colors.blue);
//   set theme(ColorSwatch color) {
//     if (color != theme) {
//       _profile.theme = color[500].value;
//       notifyListeners();
//     }
//   }
// }
