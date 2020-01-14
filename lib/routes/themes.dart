import 'package:flutter/material.dart';

class Themes extends StatefulWidget {
  @override
  _ThemesState createState() => new _ThemesState();
}

class _ThemesState extends State<Themes> {
  void _onAdd() async {
    // setState(() {
    //   _list.add(todo);
    // });
    Map data = {
      "action": 'Themes',
      "email": "190766630@qq.com",
      "password": "lyr266419",
      "rememberme": "on"
    };
    // http.post('Themes', data: data);
    //     await dio.post("http://lkong.cn/index.php?mod=Themes", data: );
  }

  void test() {
    // http.post('ajax&action=userconfig&_=1578718495633');
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Todo'),
        ),
        body: FlatButton(
          color: Colors.blue,
          highlightColor: Colors.blue[700],
          colorBrightness: Brightness.dark,
          splashColor: Colors.grey,
          child: Text("Submit"),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          onPressed: test,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onAdd,
        ));
  }
}
