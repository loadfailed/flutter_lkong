import 'package:flutter/material.dart';
import 'package:myapp/common/http.dart';
import 'package:myapp/api/homeApi/homeApi.dart';
import 'package:myapp/components/BottomNav/BottomNav.dart';
import 'package:myapp/components/CustomizedAppBar/CustomizedAppBar.dart';
import 'package:myapp/components/CustomizedTabBar/CustomizedTabBar.dart';
import 'package:myapp/components/PullToRefreshAndLoadingMore/PullToRefreshAndLoadingMore.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List _posts = [];
  int _nexttime = -1;
  int _curtime = -1;
  List<String> _titles = ['我关注的', '主题帖', '与我相关'];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: _titles.length, vsync: this);
    _getPosts();
  }

  _onRefresh() async {
    var res = await HomeApi.getPosts();
    return res;
  }

  _onLoading() async {
    var res = await HomeApi.getMorePosts(_nexttime);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomizedAppBar(
          title: _buildTabBar(),
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
        body: PullToRefreshAndLoadingMore(
          onRefresh: _onRefresh,
          onLoading: _onLoading,
        ));
  }

  Widget _buildTabBar() {
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
