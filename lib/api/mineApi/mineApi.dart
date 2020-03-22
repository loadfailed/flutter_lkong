import 'package:myapp/common/http.dart';

class MineApi {
  static final HttpUtil httpUtil = HttpUtil();

  static getUserInfo() async {
    final DateTime dateTime = new DateTime.now();
    return await httpUtil.post(
        '/user/index.php?mod=ajax&action=userconfig&_=${dateTime.millisecondsSinceEpoch}');
  }
}
