import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio/adapter.dart';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

final String baseUrl = "http://lkong.cn";
final int connectTimeout = 50000;
final int receiveTimeout = 10000;

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  Dio dio;
  factory HttpUtil() => _instance;

  HttpUtil._internal() {
    // 初始化
    if (dio == null) {
      // 配置网络请求
      Map<String, dynamic> headers = {
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
        headers: headers,
      );
      dio = new Dio(options);

      // 配置抓包代理
      // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      //     (client) {
      //   // config the http client
      //   client.findProxy = (uri) {
      //     return "PROXY 172.20.10.4:8888";
      //   };
      //   //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
      //   client.badCertificateCallback =
      //       (X509Certificate cert, String host, int port) => true;
      // };
    }
  }

  // cookie持久化保存
  setCookie() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    var cookieJar = PersistCookieJar(dir: appDocPath + "/.cookies/");
    dio.interceptors.add(CookieManager(cookieJar));
  }

  get(url, {data}) async {
    Response response;
    await setCookie();
    try {
      response = await dio.get(baseUrl + url, queryParameters: data);
      // 响应体
    } on DioError catch (e) {
      formatError(e);
    }
    return response.data;
  }

  post(url, {data}) async {
    Response response;
    await setCookie();
    try {
      response = await dio.post(baseUrl + url, data: data);
    } on DioError catch (e) {
      formatError(e);
    }
    return jsonDecode(response.data);
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
