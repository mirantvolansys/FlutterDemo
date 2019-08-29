import 'package:flutter/material.dart';
import 'package:flutter_app_todo/ui/NoToDo.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NoToDo'),
        backgroundColor: Colors.black54,
      ),
      body: NoToDo(),
    );
  }
}

