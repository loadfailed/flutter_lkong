import 'package:flutter/material.dart';
import 'package:myapp/common/global.dart';
import 'package:myapp/components/index.dart';
import 'package:myapp/models/index.dart';
import 'package:provider/provider.dart';

import 'package:myapp/api/loginApi/loginApi.dart';

// 登录页面
class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  AnimationController zoomOutController;
  Animation _zoomOutAnimation;
  AnimationController squeezeBtnController;
  Animation _squeezeBtnAnimation;
  Animation _containerCircleAnimation;

  TextEditingController _uEmailController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();

  bool isShowPwd = false; //密码是否明文显示
  bool _nameAutoFocus = true; //是否自动聚焦到输入框

  @override
  void initState() {
    // 自动填写上次输入的用户邮箱
    _uEmailController.text = Global.profile.lastLogin;
    if (_uEmailController.text != null) {
      _nameAutoFocus = false;
    }
    super.initState();
    // 按钮动画
    squeezeBtnController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 300),
    );
    _squeezeBtnAnimation = new Tween(
      begin: 240.0,
      end: 48.0,
    ).animate(
      new CurvedAnimation(
          parent: squeezeBtnController, curve: new Interval(0.0, 0.500)),
    )..addListener(() {
        setState(() {});
      });
    // 缩放动画
    zoomOutController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _zoomOutAnimation = new Tween(begin: 48.0, end: 1000.0).animate(
      new CurvedAnimation(
        parent: zoomOutController,
        curve: new Interval(
          0.0,
          1.0,
          curve: Curves.bounceOut,
        ),
      ),
    )..addListener(() {
        setState(() {});
      });
    _containerCircleAnimation = new Tween(begin: 500.0, end: 0.0).animate(
      new CurvedAnimation(
        parent: zoomOutController,
        curve: new Interval(0.25, 0.5),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Image(
            image: AssetImage("images/login.png"),
          ),
          ListView(
            children: <Widget>[
              Container(
                  height: 60,
                  padding: EdgeInsets.only(top: 20),
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 3 / 4 - 70),
                  // padding: EdgeInsets.only(top: 70, bottom: 20, left: 40, right: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)),
                  )),
              TextFormField(
                controller: _uEmailController,
                decoration: InputDecoration(
                    hintText: '请输入邮箱',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0xff28c4ea),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _uEmailController.text = '';
                      },
                      color: Colors.black26,
                    ),
                    border: InputBorder.none),
              ).intoContainer(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 40, right: 40, top: 10)),
              TextFormField(
                controller: _pwdController,
                decoration: InputDecoration(
                    hintText: '请输入密码',
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Color(0xff28c4ea),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _pwdController.text = '';
                      },
                      color: Colors.black26,
                    ),
                    border: InputBorder.none),
              ).intoContainer(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 40, right: 40, top: 10)),
              // 登录按钮
            ],
          ),
          _loginButton(),
          // Text(
          //   '本软件完全开源，代码仓库Github',
          //   style: TextStyle(
          //     color: Color(0xFF999999),
          //   ),
          //   textAlign: TextAlign.center,
          // ).intoContainer(padding: EdgeInsets.all(30)),
        ],
      ).intoContainer(color: Colors.white),
    );
  }

  // 登录方法
  void _onLogin() async {
    if (_uEmailController.toString().isEmpty) {
      print('邮箱不能为空');
    } else if (_pwdController.toString().isEmpty) {
      // showToast();
      print('密码不能为空');
    } else {
      LoginStatus loginStatus;
      try {
        var res = await LoginApi.login();
        loginStatus = LoginStatus.fromJson(res);
        await zoomOutController.forward();
        Provider.of<LoginStatusModel>(context, listen: false).loginStatus =
            loginStatus;
      } catch (e) {
        // 登录失败就提示
        print(e);
        print('登录失败');
      }
    }
  }

  _onTap() async {
    // _playAnimation();
    await squeezeBtnController.forward();
  }

  // 动画界面
  //// 动画按钮
  _loginButton() {
    return Button(
      borderRadius: _zoomOutAnimation.value > 48.0
          ? BorderRadius.circular(0)
          : BorderRadius.circular(100),
      width: _zoomOutAnimation.value == 48.0
          ? _squeezeBtnAnimation.value
          : _zoomOutAnimation.value,
      height: _zoomOutAnimation.value == 48.0 ? 48.0 : _zoomOutAnimation.value,
      colors: [Colors.cyan, Colors.blue, Colors.blueAccent],
      child: _squeezeBtnAnimation.value > 48.0
          ? Text(
              '登 录',
              style: TextStyle(fontSize: 18),
            )
          : new CircularProgressIndicator(
              value: null,
              strokeWidth: 1.0,
              valueColor: new AlwaysStoppedAnimation(Colors.white),
            ),
      onPressed: () {
        _onLogin();
        _onTap();
      },
    ).intoContainer(
      margin: EdgeInsets.only(top: _containerCircleAnimation.value),
    );
  }

  @override
  void dispose() {
    squeezeBtnController.dispose();
    zoomOutController.dispose();
    super.dispose();
  }
}

extension _WidgeExt on Widget {
  Container intoContainer({
    Key key,
    AlignmentGeometry alignment,
    EdgeInsetsGeometry padding,
    Color color,
    Decoration decoration,
    Decoration foregroundDecoration,
    double width,
    double height,
    BoxConstraints constraints,
    EdgeInsetsGeometry margin,
    Matrix4 transform,
  }) {
    return Container(
      key: key,
      alignment: alignment,
      padding: padding,
      color: color,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      transform: transform,
      child: this,
    );
  }
}
