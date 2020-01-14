import 'package:myapp/common/http.dart';

// export Map ext;
class LoginApi {
  static login() {
    Map data = {
      "action": 'login',
      "email": "190766630@qq.com",
      "password": "lyr266419",
      "rememberme": "on"
    };
    http.post('login', data: data);
  }
}
