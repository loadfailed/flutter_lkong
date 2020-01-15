import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:myapp/common/global.dart';

import 'package:provider/provider.dart';

import 'package:myapp/routes/index.dart';

Dio dio = Dio();

void main() => Global.init().then(
      (e) => runApp(
        new MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
      ],
      child: Consumer<UserModel>(
        builder: (BuildContext context, themeModel, Widget child) {
          return MaterialApp(
            title: '我的APP',
            initialRoute: "/", //名为'/'的路由作为应用的home(首页)
            routes: <String, WidgetBuilder>{
              "/": (context) => Home(),
              "login": (context) => Login(),
              "themes": (context) => Themes(),
            },
          );
        },
      ),
    );
  }
}
