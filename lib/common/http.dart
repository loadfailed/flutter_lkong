import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio/adapter.dart';
import 'package:myapp/common/global.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

final String baseUrl = "http://lkong.cn/index.php?mod=";
final int connectTimeout = 50000;
final int receiveTimeout = 10000;

class Http {
  CancelToken cancelToken = new CancelToken();

  static final Http _instance = Http._internal();
  Dio dio;
  factory Http() => _instance;

  Http._internal() {
    // print(dio);
    // 初始化
    if (dio == null) {
      // 配置网络请求
      Map<String, dynamic> _headers = {
        'Accept': 'application/json, text/plain, */*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept-Language': 'zh-CN,zh;q=0.9',
        'Connection': 'keep-alive',
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',
      };
      BaseOptions options = new BaseOptions(
        baseUrl: baseUrl,
        contentType: 'application/x-www-form-urlencoded',
        headers: _headers,
      );
      dio = new Dio(options);
      // if (Global.isRelease) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        // config the http client
        client.findProxy = (uri) {
          return "PROXY 192.168.1.107:8888";
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
      // }
      _setCookie();
    }
  }

  _setCookie() async {
    // cookie持久化保存
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    var cookieJar = PersistCookieJar(dir: appDocPath + "/.cookies/");
    dio.interceptors.add(CookieManager(cookieJar));
  }

  get(url, {data}) async {
    Response response;
    try {
      response = await dio.get(baseUrl + url, queryParameters: data);
      print('Get Success --- ${response.data}');
      // 响应体
    } on DioError catch (e) {
      formatError(e);
    }
    return response.data;
  }

  post(url, {data}) async {
    Response response;
    try {
      // cookieJar.loadForRequest(Uri.parse("http://lkong.cn/"));
      response = await dio.post(baseUrl + url, data: data);
      print('Post Success --- $response');
    } on DioError catch (e) {
      print('Post Error --- $e');
      formatError(e);
    }
    return jsonDecode(response.data);
  }

  downloadFile(url, savePath) async {
    Response response;
    try {
      response = await dio.download(url, savePath,
          onReceiveProgress: (int count, int total) {
        // 进度
        print('$count $total');
      });
      print('Download Success --- ${response.data}');
    } on DioError catch (e) {
      print('DownloadFile Error --- $e');
      formatError(e);
    }
  }

  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      print('连接超时');
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      print('请求超时');
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      print('响应超市');
    } else if (e.type == DioErrorType.RESPONSE) {
      print('出现异常');
    } else if (e.type == DioErrorType.CANCEL) {
      print('请求取消');
    } else {
      print('未知错误');
    }
  }
}
