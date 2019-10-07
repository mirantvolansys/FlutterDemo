import 'package:flutter/material.dart';

import 'package:load/load.dart';

class tester extends StatefulWidget {
  @override
  _testerState createState() => _testerState();
}

class _testerState extends State<tester> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightBlue,
        child: Center(
          child: FlatButton(
            onPressed: () {
              showLoadingDialog();
//              showCustomLoadingWidget(Container());
              Future.delayed(const Duration(seconds: 10), () {
                hideLoadingDialog();
              });
            },
            child: Text("Hide / Show"),
            color: Colors.lightGreen,
          ),
        ),
    );
  }
}
