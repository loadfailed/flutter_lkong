import 'package:flutter/material.dart';
import 'package:myapp/components/ImageWidget/ImageWidget.dart';

class PostCard extends StatelessWidget {
  PostCard({Key key, @required this.post, this.fontSize}) : super(key: key);
  final String post;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    RegExp reg = RegExp(r"<img[\S\s]+?>{1}");
    List<Match> matchs = reg.allMatches(post).toList();
    List<InlineSpan> list = [];
    final String value =
        matchs.length == 0 ? post : post.substring(0, matchs[0].start);
    if (value.isNotEmpty) list.add(TextSpan(text: value));
    for (int i = 0; i < matchs.length; i++) {
      list.add(WidgetSpan(
          child: ImageWidget(
              url: matchs[i]
                  .group(0)
                  .substring(10, matchs[i].group(0).length - 18),
              width: 32,
              height: 32)));
      final String value = post.substring(matchs[i].end,
          i + 1 == matchs.length ? post.length : matchs[i + 1].start);

      if (value.isNotEmpty) list.add(TextSpan(text: value));
    }
    return Text.rich(
      TextSpan(children: list),
      style: TextStyle(fontSize: fontSize ?? 14),
    );
  }
}
