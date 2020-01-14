import 'package:flutter/material.dart';
import 'package:myapp/common/global.dart';
import 'package:provider/provider.dart';
import 'index.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}

Widget _buildBody(BuildContext context) {
  UserModel userModel = Provider.of<UserModel>(context);
  if (!userModel.isLogin) {
    return Scaffold(
      body: LoginForm(),
    );
  } else {
    return Scaffold(
      appBar: AppBar(
        title: Text('信息流'),
      ),
    );
  }
}
