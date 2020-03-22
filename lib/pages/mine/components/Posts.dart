import 'package:flutter/cupertino.dart';

class Posts extends StatefulWidget {
  @override
  State<Posts> createState() => PostsState();
}

class PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 1000,
      color: Color(0xFFffffff),
      child: Text('111'),
    );
  }
}
