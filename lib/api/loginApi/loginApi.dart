import 'package:myapp/common/http.dart';

// export Map ext;
class LoginApi {
  static final String baseUrl = "http://lkong.cn/index.php?mod=";
  static final HttpUtil httpUtil = HttpUtil();

  static login() async {
    Map<String, dynamic> data = {
      "action": 'login',
      "email": "190766630@qq.com",
      "password": "lyr266419",
      "rememberme": "on"
    };
    return await HttpUtil().post('/index.php?mod=login', data: data);
  }
}
