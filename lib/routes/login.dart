import 'package:flutter/material.dart';
import 'package:myapp/api/loginApi.dart';
import 'package:myapp/common/global.dart';
import 'package:myapp/common/http.dart';
import 'package:myapp/components/index.dart';
import 'package:myapp/models/index.dart';
import 'package:provider/provider.dart';

// 登录页面
class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  void _onAdd() async {
    // setState(() {
    //   _list.add(todo);
    // });
    Map data = {
      "action": 'login',
      "email": "190766630@qq.com",
      "password": "lyr266419",
      "rememberme": "on"
    };
    // http.post('login', data: data);
    //     await dio.post("http://lkong.cn/index.php?mod=login", data: );
  }

  void test() {
    // http.post('ajax&action=userconfig&_=1578718495633');
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('登陆'),
        ),
        body: LoginForm(),
        floatingActionButton: FloatingActionButton(
          onPressed: _onAdd,
        ));
  }
}

// 登录表单
class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => new _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        Image(
          image: AssetImage("images/login.png"),
        ),
        ListView(
          children: <Widget>[
            Container(
                // constraints: BoxConstraints.tightFor(height: double.infinity),
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
            _LoginButton(
              onLogin: _onLogin,
            ).intoContainer(
              padding: EdgeInsets.only(top: 40),
            ),
            Text(
              '本软件完全开源，代码仓库Github',
              style: TextStyle(
                color: Color(0xFF999999),
              ),
              textAlign: TextAlign.center,
            ).intoContainer(padding: EdgeInsets.all(30)),
          ],
        ),
      ],
    ).intoContainer(color: Colors.white);
    // .intoContainer(color: Colors.white);
  }

  void _onLogin() async {
    Map data = {
      "action": 'login',
      "email": "190766630@qq.com",
      "password": "lyr266419",
      "rememberme": "on"
    };
    if (_uEmailController.toString().isEmpty) {
      print('邮箱不能为空');
    } else if (_pwdController.toString().isEmpty) {
      // showToast();
      print('密码不能为空');
    } else {
      User user;
      try {
        var res = await http.post('login', data: data);
        user = User.fromJson(res);
        Provider.of<UserModel>(context, listen: false).user = user;
      } catch (e) {
        // 登录失败就提示
        print(e);
        print('登录失败');
      }
    }
  }
}

// 登录按钮
class _LoginButton extends StatefulWidget {
  _LoginButton({Key key, @required this.onLogin}) : super(key: key);
  final Function onLogin;

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<_LoginButton>
    with SingleTickerProviderStateMixin {
  AnimationController btnController;
  Animation squeezeBtnAnimation;

  @override
  void initState() {
    super.initState();
    btnController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 1000),
    );
    squeezeBtnAnimation = new Tween(
      begin: 240.0,
      end: 48.0,
    ).animate(
      new CurvedAnimation(
          parent: btnController, curve: new Interval(0.000, 0.250)),
    )..addListener(() {
        setState(() {});
      });
  }

  onTap() {
    // _playAnimation();
    btnController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        height: 48,
        width: squeezeBtnAnimation.value,
        colors: [Color(0xff28c4ea), Color(0xff17beb2)],
        child: squeezeBtnAnimation.value > 80
            ? Text(
                '登 录',
                style: TextStyle(fontSize: 18),
              )
            : new CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation(Colors.white),
              ),
        onPressed: () {
          // widget.onLogin();
          onTap();
        },
      ),
    );
  }

  @override
  void dispose() {
    btnController.dispose();
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
