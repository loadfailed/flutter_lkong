import 'package:flutter/material.dart';
import 'package:myapp/components/ImageWidget/ImageWidget.dart';
import 'package:myapp/util/getAvatarUrl.dart';

class UserInfo extends StatelessWidget {
  UserInfo({Key key, @required this.data}) : super(key: key);
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(left: width / 20, right: width / 20),
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/mine_bg.jpg"), fit: BoxFit.cover),
        border: Border(
          bottom: BorderSide(width: 40, color: Color(0xFFf6f6f6)),
          top: BorderSide(width: 20, color: Colors.transparent),
        ),
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
              bottom: 120,
              child: Chip(
                padding: EdgeInsets.all(2.0),
                labelPadding: EdgeInsets.only(right: 20, left: 4.0),
                avatar: CircleAvatar(
                  child: Icon(
                    Icons.accessible_forward,
                    color: Colors.white,
                    size: 26.0,
                  ),
                  backgroundColor: Colors.cyan,
                ),
                backgroundColor: Colors.white,
                label: Container(
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                    data == null ? '' : data['username'].toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )),
          Positioned(
            bottom: 80,
            width: width,
            child: DefaultTextStyle(
              style: TextStyle(fontSize: 12.0, decoration: TextDecoration.none),
              textAlign: TextAlign.start,
              child: Wrap(children: <Widget>[
                buildTagWidget(0xFFE2F6E1, 0xFF3AB865,
                    '${(data == null) ? 0 : data['extcredits2'].toString()} 龙币'),
                buildTagWidget(0xFFF7F8DD, 0xFFC9AB23,
                    '${(data == null) ? 0 : data['extcredits3'].toString()} 龙晶'),
                buildTagWidget(0xFFEEE1E8, 0xFFC96A9A,
                    '${(data == null) ? 0 : data['followuidnum'].toString()} 关注'),
                buildTagWidget(0xFFD5DEED, 0xFF4F7DD0,
                    '${(data == null) ? 0 : data['fansnum'].toString()} 粉丝')
              ]),
            ),
          ),
          Positioned(
            bottom: -40,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Color(0xFFf6f6f6)),
                  borderRadius: BorderRadius.circular(100)),
              child: ClipOval(
                child: ImageWidget(
                  url: (data == null)
                      ? ''
                      : getAvatarUrl(
                          'avatar', data['uid'].toString(), 'middle'),
                  width: 80,
                  height: 80,
                  errorImagePath: 'images/noavatar_middle.png',
                ),
              ),
            ),
          ),
          Positioned(
              bottom: -30,
              left: 90,
              child: Container(
                width: width - 130,
                child: Text(
                  data == null ? '' : data['customstatus'],
                  style: TextStyle(color: Color(0xFF999999)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ))
        ],
      ),
    );
  }

  buildTagWidget(int bgColor, int fontColor, String text) {
    return Container(
      padding: EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 10),
      margin: EdgeInsets.only(right: 6, bottom: 4),
      decoration: BoxDecoration(
        color: Color(bgColor),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        text,
        style: TextStyle(color: Color(fontColor)),
      ),
    );
  }
}
