import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomWidgetWithStream(),
    );
  }
}

class CustomWidgetWithStream extends StatelessWidget {
  final CustomBlock block = CustomBlock();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
                stream: block.stream,
                builder: (context, stream) {
                  return Text("${stream.data.toString()}");
                }),
            RaisedButton(
              onPressed: () {
                block.incrementNumber();
              },
              child: Text("Increment"),
            )
          ],
        ),
      ),
    );
  }
}

class CustomBlock {
  num counter = 0;
  final StreamController<num> _controller = StreamController();

  Stream<num> get stream => _controller.stream;

  CustomBlock() {
    _controller.onListen = () {
      _controller.add(counter); // triggered when the first subscriber is added
    };
  }

  void incrementNumber() {
    counter += 1;
    _controller.add(counter); // ADD NEW EVENT TO THE STREAM
  }

  dispose() {
    _controller.close();
  }
}




