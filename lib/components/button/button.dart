import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({
    this.colors,
    this.width,
    this.height,
    this.onPressed,
    this.borderRadius,
    this.boxShadow,
    @required this.child,
  });

  final List<Color> colors;
  final double width;
  final double height;
  final Widget child;
  final List<BoxShadow> boxShadow;
  final BorderRadius borderRadius;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    // 初始化颜色
    List<Color> _colors = colors ??
        [theme.primaryColor, theme.primaryColorDark ?? theme.primaryColor];
    // 初始化阴影
    List<BoxShadow> _boxShadow = boxShadow ??
        [
          BoxShadow(
              color: Color(0x99999999), blurRadius: 4, offset: Offset(0, 4))
        ];
    // 初始化圆角
    BorderRadius _borderRadius = borderRadius ?? BorderRadius.circular(100);
    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: _colors),
          borderRadius: _borderRadius,
          boxShadow: _boxShadow),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: _borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: DefaultTextStyle(
                  style: TextStyle(),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
