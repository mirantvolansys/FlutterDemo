import 'package:flutter/material.dart';
import 'package:flutter_app_bmi/MyHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI',
      home: Scaffold(
        appBar: AppBar(
          title: Text('BMI'),
          backgroundColor: Colors.pinkAccent,
          centerTitle: true,
        ),

        body: MyHomePage(),
      ),
    );
  }
}

