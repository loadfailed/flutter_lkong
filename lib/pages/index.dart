import 'package:flutter/material.dart';
import 'package:myapp/api/mineApi/mineApi.dart';
import 'package:myapp/components/BottomNav/BottomNav.dart';
import 'package:myapp/pages/home/home.dart';
import 'package:myapp/pages/mine/mine.dart';

class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<Index> {
  Map<String, dynamic> userInfo;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<Widget> widgetList = [
      Mine(
        userInfo: userInfo,
      ),
      Home(),
      Home(),
      Home()
    ];
    return Scaffold(
        body: widgetList[_currentIndex],
        bottomNavigationBar: BottomNav(
          onChanged: onChangedCurNav,
        ));
  }

  void onChangedCurNav(int current) {
    _currentIndex = current;
    setState(() {});
  }

  //获取用户信息
  getUserInfo() async {
    userInfo = await MineApi.getUserInfo();
    setState(() {});
  }
}
