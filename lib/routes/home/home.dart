import 'package:flutter/material.dart';
import 'package:myapp/common/http.dart';
import 'package:myapp/api/homeApi/homeApi.dart';
import 'package:myapp/components/CustomizedAppBar/CustomizedAppBar.dart';
import 'package:myapp/components/CustomizedTabBar/CustomizedTabBar.dart';
import 'package:myapp/components/PullToRefreshAndLoadingMore/PullToRefreshAndLoadingMore.dart';

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

  _onRefresh() async {
    var res = await HomeApi.getPosts();
    return res;
  }

  _onLoading() async {
    var res = await HomeApi.getPosts();
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
      // body: ListView.builder(
      //   itemCount: _posts.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     Map item = _posts[index];
      //     DateTime dateTime = new DateTime.fromMillisecondsSinceEpoch(
      //         int.parse(item['dateline']) * 1000);
      //     return Card(
      //       child: Container(
      //         padding: EdgeInsets.all(10),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: <Widget>[
      //             // leading: Image(
      //             //   image: NetworkImage(
      //             //       "http://b-ssl.duitang.com/uploads/item/201607/26/20160726185736_yPmrE.thumb.224_0.jpeg"),
      //             // ),
      //             _buildUserAvatar(item['username'], dateTime),
      //             _buildPostContent(item['message'])
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // ),
      body: PullToRefreshAndLoadingMore(
        onRefresh: _onRefresh,
        onLoading: _onLoading,
      ),
    );
  }

  // 返回用户头像和用户名
  Widget _buildUserAvatar(String username, DateTime dateTime) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://b-ssl.duitang.com/uploads/item/201607/26/20160726185736_yPmrE.thumb.224_0.jpeg"),
              fit: BoxFit.cover,
            ),
            color: Color(0xFFB8C7E0),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      backgroundColor: Color(0xFFFFFFFF),
      label: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            username,
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          Text(
            dateTime.toString().substring(0, 16),
            style: TextStyle(fontSize: 12, color: Color(0xFF999999)),
          )
        ],
      ),
      // subtitle: Text(dateTime.toString().substring(0, 16)),
    );
  }

  // 帖子内容的建设
  Widget _buildPostContent(String content) {
    return Container(
      child: Text(
        content,
        style: TextStyle(fontSize: 16),
      ),
    );
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
