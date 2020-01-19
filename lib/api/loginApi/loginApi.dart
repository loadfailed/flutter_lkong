import 'package:myapp/common/http.dart';

// export Map ext;
class LoginApi {
  static Http _http = new Http();
  static login() async {
    Map<String, dynamic> data = {
      "action": 'login',
      "email": "190766630@qq.com",
      "password": "lyr266419",
      "rememberme": "on"
    };
    var res = await _http.post('login', data: data);
    return res;
  }
}
