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
          UserModel userModel = Provider.of<UserModel>(context);
          return MaterialApp(
            title: '我的APP',
            theme: ThemeData(
                primaryColor: Color(0xff0099cc),
                backgroundColor: Color(0xFFf6f6f6)),
            home: userModel.isLogin ? Home() : Login(),
            routes: <String, WidgetBuilder>{
              "login": (context) => Login(),
              "themes": (context) => Themes(),
            },
          );
        },
      ),
    );
  }
}
