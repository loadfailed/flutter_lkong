import 'package:flutter/material.dart';

class EditorTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final map = Map.castFrom(ModalRoute.of(context).settings.arguments);
    String title;
    TextEditingController _content = TextEditingController();
    if (map['type'] == 'edit') {
      title = '编辑Todo';
      _content.text = map['value'];
    } else {
      title = '新建Todo';
    }

    return new Scaffold(
      appBar: AppBar(title: Text('$title')),
      body: Container(
        padding: EdgeInsets.only(left: 30, top: 20, right: 30),
        child: TextField(
          autofocus: true,
          controller: _content,
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {
          Navigator.pop(context, _content.text.trim());
        },
      ),
    );
  }
}
