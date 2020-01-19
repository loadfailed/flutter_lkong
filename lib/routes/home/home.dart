import 'package:flutter/material.dart';
import 'package:myapp/common/http.dart';
import 'package:myapp/api/homeApi/homeApi.dart';
import 'package:myapp/components/CustomizedAppBar/CustomizedAppBar.dart';
import 'package:myapp/components/CustomizedTabBar/CustomizedTabBar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List _posts = [];
  int _nexttime = -1;
  int _curtime = -1;
  List<String> _titles = ['我关注的', '只看主题', '与我相关'];
  TabController _tabController;

  Http http = new Http();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: _titles.length, vsync: this);
    _getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(
        title: buildTabBar(),
        centerTitle: true,
        backgroundColor: Color(0xFFFFFFFF),
        appBarHeight: 48,
        // gradientColors: [Colors.cyan, Colors.blue, Colors.blueAccent],
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(title: Text(_posts[index]['message']));
        },
      ),
    );
  }

  Widget buildTabBar() {
    return CustomizedTabBar(
      // indicator: BoxDecoration(),
      tabs: _titles.map((String title) {
        return CustomizedTab(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        );
      }).toList(),
      controller: _tabController,
    );
  }

  _getPosts() async {
    // mod=data&sars=index/&_=${new Date().getTime()}
    var res = await HomeApi.getPosts();
    setState(() {
      _posts = res['data'];
      _nexttime = res['nexttime'];
      _curtime = res['curtime'];
    });
  }
}
