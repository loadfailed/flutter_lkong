import 'package:myapp/common/http.dart';

// export Map ext;
class HomeApi {
  static final String baseUrl = "http://lkong.cn/index.php?mod=";
  static final HttpUtil httpUtil = HttpUtil();
  static final int currentTimeMillis =
      new DateTime.now().millisecondsSinceEpoch;
  static getPosts() async {
    return await httpUtil
        .post('/index.php?mod=data&sars=index/&_=$currentTimeMillis');
  }

  static getMorePosts(nexttime) async {
    return await httpUtil.post(
        '/index.php?mod=data&sars=index/&nexttime=$nexttime&_=$currentTimeMillis');
  }
}
