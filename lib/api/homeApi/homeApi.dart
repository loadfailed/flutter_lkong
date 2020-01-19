import 'package:myapp/common/http.dart';

// export Map ext;
class HomeApi {
  static Http _http = new Http();
  static getPosts() async {
    int currentTimeMillis = new DateTime.now().millisecondsSinceEpoch;
    return await _http.post('data&sars=index/&_=$currentTimeMillis');
  }

  static test() {
    int currentTimeMillis = new DateTime.now().millisecondsSinceEpoch;
    var res = _http.post('data&sars=index/&_=$currentTimeMillis');
    print(res);
    return res;
  }
}
