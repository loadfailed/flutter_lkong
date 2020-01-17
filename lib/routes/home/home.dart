import 'package:flutter/material.dart';
import 'package:myapp/common/http.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  List _posts = [];
  int _nexttime = -1;
  int _curtime = -1;

  @override
  Widget build(BuildContext context) {
    _getPosts();
    return Scaffold(
      appBar: AppBar(
        title: Text('信息流'),
      ),
      body: ListView.builder(
          itemCount: _posts.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text(_posts[index]['message']));
          }),
    );
  }

  _getPosts() async {
    // mod=data&sars=index/&_=${new Date().getTime()}
    int currentTimeMillis = new DateTime.now().millisecondsSinceEpoch;
    var res = await http.post('data&sars=index/&_=$currentTimeMillis');
    setState(() {
      _posts = res['data'];
      _nexttime = res['nexttime'];
      _curtime = res['curtime'];
    });
  }
}
