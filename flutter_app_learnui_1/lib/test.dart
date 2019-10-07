import 'package:flutter/material.dart';
import 'dart:ui';

class BackDropFilterDemo extends StatefulWidget {
  BackDropFilterDemo() : super();

  final String title = "Image Filter Demo";

  @override
  BackDropFilterDemoState createState() => BackDropFilterDemoState();
}

class BackDropFilterDemoState extends State<BackDropFilterDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Text('0' * 10000),
          Center(
            child: ClipRect(
              // <-- clips to the 200x200 [Container] below
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: 200.0,
                  height: 200.0,
                  child: Text('Hello World'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
