import 'package:flutter/material.dart';
import 'package:myapp/api/loginApi.dart';
import 'package:myapp/common/global.dart';
import 'package:myapp/common/http.dart';
import 'package:myapp/components/index.dart';
import 'package:myapp/models/index.dart';
import 'package:provider/provider.dart';

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
    return Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Image(
              image: AssetImage('images/login.png'),
            ),
            Container(
              height: 48,
              child: Align(
                alignment: FractionalOffset(0.1, -10),
                child: Container(
                  height: 44,
                  padding: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)),
                  ),
                  // child: Text(
                  //   'login ',
                  //   style: TextStyle(
                  //     color: Color(0xffA5EEE0),
                  //     fontSize: 20,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Form(
                child: TextFormField(
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
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 40, right: 40),
              child: Form(
                child: TextFormField(
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
                        border: InputBorder.none)),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 40, left: 40, right: 40),
                child: _LoginButton(
                  onLogin: _onLogin,
                )),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  '本软件已开源，请勿商用',
                  style: TextStyle(color: Color(0xffbbbbbb)),
                ),
              ),
            ),
          ],
        ));
  }

  void _onLogin() async {
    Map data = {
      "action": 'login',
      "email": "190766630@qq.com",
      "password": "lyr266419",
      "rememberme": "on"
    };
    if (_uEmailController.toString().isEmpty) {
      print('邮箱不能为空');
    } else if (_pwdController.toString().isEmpty) {
      // showToast();
      print('密码不能为空');
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

class _LoginButton extends StatefulWidget {
  _LoginButton({Key key, @required this.onLogin}) : super(key: key);
  final Function onLogin;

  @override
  _LoginButtonState createState() => _LoginButtonState(onLogin: onLogin);
}

class _LoginButtonState extends State<_LoginButton>
    with SingleTickerProviderStateMixin {
  _LoginButtonState({Key key, @required this.onLogin});

  final Function onLogin;
  AnimationController colorController;
  @override
  void initState() {
    super.initState();
    colorController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 3000));
  }

  @override
  Widget build(BuildContext context) {
    return Button(
      height: 48,
      colors: [Color(0xff28c4ea), Color(0xff17beb2)],
      child: Text(
        '登 录',
        style: TextStyle(fontSize: 18),
      ),
      onPressed: onLogin,
    );
  }
}
