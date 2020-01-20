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
  List<String> _titles = ['我关注的', '主题帖', '与我相关'];
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
        backgroundColor: Color(0xFFFFFFFF),
        appBarHeight: 54,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.search,
              color: Color(0xFF666666),
            ),
          )
        ],
        // gradientColors: [Colors.cyan, Colors.blue, Colors.blueAccent],
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (BuildContext context, int index) {
          Map item = _posts[index];
          DateTime dateTime = new DateTime.fromMillisecondsSinceEpoch(
              int.parse(item['dateline']) * 1000);
          return Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Image(
                    image: NetworkImage(
                        "http://b-ssl.duitang.com/uploads/item/201607/26/20160726185736_yPmrE.thumb.224_0.jpeg"),
                  ),
                  title: Text(item['username']),
                  subtitle: Text(dateTime.toString().substring(0, 16)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildTabBar() {
    return CustomizedTabBar(
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color(0x0B000000),
        // border: Border.all(color: Color(0xFFFFFFFF), width: 6),
      ),
      tabs: _titles.map((String title) {
        return CustomizedTab(
          tabHeight: 30.0,
          child: Text(
            title,
            style: TextStyle(fontSize: 16),
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
