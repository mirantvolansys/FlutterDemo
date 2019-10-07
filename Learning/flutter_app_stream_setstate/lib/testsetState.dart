import 'package:flutter/material.dart';

class testState extends StatefulWidget {
  @override
  _testStateState createState() => _testStateState();
}

class _testStateState extends State<testState> {

  var count1 = 0;
  var count2 = 1;
  var count3 = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
        actions: <Widget>[
          FlatButton(onPressed: () {
            count2++;
            setState(() {
              count1++;
            });
            count3++;
          }, child: Text("Tap Me")),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("$count1"),
            Padding(padding: EdgeInsets.all(50)),
            Text("$count2"),
            Padding(padding: EdgeInsets.all(50)),
            Text("$count3"),
          ],
        ),
      ),
    );
  }
}
