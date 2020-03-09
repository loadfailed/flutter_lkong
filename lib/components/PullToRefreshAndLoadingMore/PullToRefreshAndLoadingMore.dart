import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:myapp/models/index.dart';
import 'package:myapp/util/getAvatarUrl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullToRefreshAndLoadingMore extends StatefulWidget {
  const PullToRefreshAndLoadingMore({
    Key key,
    this.onRefresh,
    this.onLoading,
  }) : super(key: key);
  final Function onRefresh;
  final Function onLoading;
  @override
  _PullToRefreshAndLoadingMoreState createState() =>
      new _PullToRefreshAndLoadingMoreState();
}

class _PullToRefreshAndLoadingMoreState
    extends State<PullToRefreshAndLoadingMore> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List datas = [];
  int nexttime = -1;
  int curtime = -1;

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() async {
    var res = await widget.onRefresh();
    setState(() {
      datas = res['data'];
      nexttime = res['nexttime'];
      curtime = res['curtime'];
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await widget.onLoading();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      // header: WaterDropMaterialHeader(),
      header: WaterDropMaterialHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text('加载成功');
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text('加载失败');
          } else if (mode == LoadStatus.canLoading) {
            body = Text('松手，加载更多');
          } else {
            body = Text('没有更多数据了');
          }
          return Container(
            height: 50.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
          itemCount: datas.length,
          itemBuilder: (BuildContext context, int index) {
            Map post = datas[index];
            DateTime dateline = new DateTime.fromMicrosecondsSinceEpoch(
                int.parse(post['dateline']) * 1000);
            return Card(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildUserAvatar(post['username'], post['uid'], dateline),
                    Container(
                      height: 1.0,
                      margin: EdgeInsets.only(top: 6.0, bottom: 6.0),
                      color: Color(0xFFEEEEEE),
                    ),
                    _buildPostContent(post['message'])
                  ],
                ),
              ),
            );
          }),
    );
  }

  // 返回用户头像和用户名
  Widget _buildUserAvatar(
    String username,
    String uid,
    DateTime dateTime,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          username,
          style:
              TextStyle(fontSize: 14, height: 1.4, fontWeight: FontWeight.bold),
        ),
        Text(
          dateTime.toString().substring(0, 16),
          style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
        )
      ],
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
}
