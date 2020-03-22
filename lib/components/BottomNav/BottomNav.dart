import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  BottomNav({Key key, @required this.onChanged}) : super(key: key);

  final ValueChanged<int> onChanged;

  @override
  State<StatefulWidget> createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0; //选中的图标
  double _height = 48.0; //导航栏高度
  double _floatRadius; //悬浮图标半径
  double _moveTween = 0.0; //移动补间
  double _padding = 10.0; //浮动图标与圆弧的间距
  AnimationController _animationController; //动画控制器
  Animation<double> _moveAnimation; //移动动画
  List _navs = [Icons.home, Icons.view_module, Icons.mail, Icons.person];

  @override
  void initState() {
    _floatRadius = _height * 3 / 4;
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double singleWidth = width / _navs.length;
    return Container(
        color: Color(0xFFFFFFFF),
        height: _height,
        child: Stack(
          children: <Widget>[
            Positioned(
              width: width,
              bottom: 0.0,
              child: Stack(overflow: Overflow.visible, children: <Widget>[
                // 浮动图标
                Positioned(
                  top: _animationController.value <= 0.5
                      ? (_animationController.value * _height * _padding / 2) -
                          _floatRadius / 3 * 2
                      : (1 - _animationController.value) *
                              _height *
                              _padding /
                              2 -
                          _floatRadius / 3 * 2,
                  left: _moveTween * singleWidth +
                      (singleWidth - _floatRadius) / 2 -
                      _padding / 1.5,
                  child: DecoratedBox(
                    decoration:
                        ShapeDecoration(shape: CircleBorder(), shadows: [
                      BoxShadow(
                          blurRadius: _padding / 2,
                          spreadRadius: 0,
                          offset: Offset(0, 2),
                          color: Color(0xFFA1C5E7)),
                    ]),
                    child: CircleAvatar(
                      radius: _floatRadius - _padding,
                      backgroundColor: Color(0xFF4AA5FB),
                      child: Icon(
                        _navs[_currentIndex],
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // 所有图标
                CustomPaint(
                  child: SizedBox(
                    height: _height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: _navs
                          .asMap()
                          .map(
                            (i, v) => MapEntry(
                              i,
                              GestureDetector(
                                child: Container(
                                    width: singleWidth,
                                    height: 48,
                                    color: Colors.transparent,
                                    child: Icon(v,
                                        color: _currentIndex == i
                                            ? Colors.transparent
                                            : Color(0xFF8094A7))),
                                onTap: () {
                                  _switchNav(i);
                                },
                              ),
                            ),
                          )
                          .values
                          .toList(),
                    ),
                  ),
                  painter: ArcPainter(
                    navCount: _navs.length,
                    moveTween: _moveTween,
                    padding: _padding,
                  ),
                )
              ]),
            )
          ],
        ));
  }

  _switchNav(int newIndex) {
    double oldPosition = _currentIndex.toDouble();
    double newPosition = newIndex.toDouble();
    if (oldPosition != newPosition &&
        _animationController.status != AnimationStatus.forward) {
      _animationController.reset();
      _moveAnimation = Tween(begin: oldPosition, end: newPosition).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInCubic))
        ..addListener(() {
          setState(() {
            _moveTween = _moveAnimation.value;
          });
        })
        ..addStatusListener((AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            _currentIndex = newIndex;
            widget.onChanged(newIndex);
          }
        });
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class ArcPainter extends CustomPainter {
  ArcPainter({this.navCount, this.moveTween, this.padding});
  final int navCount;
  final double moveTween;
  final double padding;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = (Colors.white)
      ..style = PaintingStyle.stroke; //画笔
    double width = size.width; //导航栏总宽度
    double singleWidth = width / navCount; //单个导航栏的宽度
    double height = size.height; //导航栏的高度，即canvas的高度
    double arcRadius = height * 2 / 3; //圆弧半径
    double resetSpace = (singleWidth - arcRadius * 2) / 2; //单个导航栏减去圆弧直径后单边剩余宽度

    Path path = Path() //路径
      ..relativeLineTo(moveTween * singleWidth, 0)
      ..relativeCubicTo(resetSpace + padding, 0, resetSpace + padding / 2,
          arcRadius, singleWidth / 2, arcRadius) //圆弧左半边
      ..relativeCubicTo(arcRadius, 0, arcRadius - padding, -arcRadius,
          resetSpace + arcRadius, -arcRadius) //圆弧右半边
      ..relativeLineTo(width - (moveTween + 1) * singleWidth, 0)
      ..relativeLineTo(0, height)
      ..relativeLineTo(-width, 0)
      ..relativeLineTo(0, -height)
      ..close();
    paint.style = PaintingStyle.fill;
    canvas.drawShadow(path, Color(0xFF000000), 300, true);

    Path drawPath = Path() //路径
      ..relativeLineTo(moveTween * singleWidth, -4)
      ..relativeCubicTo(resetSpace + padding + 4, -8, resetSpace + padding / 2,
          arcRadius - 2, singleWidth / 2 + 2, arcRadius - 2) //圆弧左半边
      ..relativeCubicTo(arcRadius + 2, -2, arcRadius - padding - 10,
          -arcRadius - 6, resetSpace + arcRadius + 2, -arcRadius) //圆弧右半边
      ..relativeLineTo(width - (moveTween + 1) * singleWidth, 0)
      ..relativeLineTo(0, height)
      ..relativeLineTo(-width, 0)
      ..relativeLineTo(0, -height)
      ..close();
    canvas.drawShadow(drawPath, Colors.black26, 4, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
