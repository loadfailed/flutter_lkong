import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:myapp/components/Post/PostCard.dart';

import 'components/CustomSliverPersistentHeader.dart';
import 'components/Posts.dart';
import 'components/UserInfo.dart';

class Mine extends StatefulWidget {
  Mine({Key key, @required this.userInfo}) : super(key: key);
  final Map<String, dynamic> userInfo;
  @override
  State<StatefulWidget> createState() => MineState();
}

class MineState extends State<Mine> with TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();

  double height = 0.0;
  double maxHeight = 300.0;
  double pinHeight = 120;
  double userInfoHeight = 120;

  @override
  void initState() {
    _scrollController.addListener(offsetListener);
    super.initState();
  }

  offsetListener() {
    height = _scrollController.offset;
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.removeListener(offsetListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (ctx, b) {
            return [
              SliverPersistentHeader(
                delegate: CustomSliverPersistentHeader(
                    child: Container(
                      height: maxHeight - height >= userInfoHeight
                          ? maxHeight - height
                          : userInfoHeight,
                      child: UserInfo(data: widget.userInfo),
                    ),
                    maxHeight: maxHeight,
                    minHeigth: userInfoHeight),
              ),
            ];
          },
          pinnedHeaderSliverHeightBuilder: () {
            return pinHeight;
          },
          innerScrollPositionKeyBuilder: () {
            return Key('tab1');
          },
          body: PostCard(
            post:
                "<img src='http://img.lkong.cn/bq/em110.gif' class='smallbq'>同意安安<img src='http://img.lkong.cn/bq/em110.gif' class='smallbq'>",
          ),
        ),
      ],
    );
  }
}
