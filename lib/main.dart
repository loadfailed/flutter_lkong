import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:myapp/common/global.dart';
import 'package:myapp/pages/index.dart';
import 'package:myapp/pages/login/login.dart';

import 'package:provider/provider.dart';

Dio dio = Dio();

/// System overlays should be drawn with a dark color. Intended for
/// applications with a light background.

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
        ChangeNotifierProvider.value(value: LoginStatusModel()),
      ],
      child: Consumer<LoginStatusModel>(
        builder: (BuildContext context, themeModel, Widget child) {
          LoginStatusModel loginStatusModel =
              Provider.of<LoginStatusModel>(context);
          return MaterialApp(
            title: '我的APP',
            theme: ThemeData(
                primaryColor: Color(0xFF4AA5FB),
                backgroundColor: Color(0xFFf6f6f6)),
            home: loginStatusModel.isLogin ? Index() : Login(),
            routes: <String, WidgetBuilder>{
              "login": (context) => Login(),
              "home": (context) => Index()
            },
          );
        },
      ),
    );
  }
}
