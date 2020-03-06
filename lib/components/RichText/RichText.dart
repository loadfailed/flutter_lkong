import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// 继承TextSpan，设置空白占位字符
class SpaceSpan extends TextSpan {
  SpaceSpan(
      {this.contentWidth,
      this.contentHeight,
      GestureRecognizer recognizer,
      this.widgetChild})
      : super(
            style: TextStyle(
                color: Colors.transparent,
                letterSpacing: contentWidth,
                height: 1.0,
                fontSize: contentHeight),
            text: '\u200B',
            recognizer: recognizer);
  final double contentWidth;
  final double contentHeight;
  final Widget widgetChild;
}

class ResetText extends StatelessWidget {
  const ResetText(
      {Key key, this.contentWidth, this.contentHeight, this.widgetChild})
      : super(key: key);
  final double contentWidth;
  final double contentHeight;
  final Widget widgetChild;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text.rich(SpaceSpan());
  }
}
