import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    _onRefresh();
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
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
            Map item = datas[index];
            DateTime dateline = new DateTime.fromMicrosecondsSinceEpoch(
                int.parse(item['dateline']) * 1000);
            return Card(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildUserAvatar(item['username'], dateline),
                    _buildPostContent(item['message'])
                  ],
                ),
              ),
            );
          }),
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
              image: NetworkImage(getAvatarUrl('avatar', '123456', 'middle')),
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
}
