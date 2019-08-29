import 'package:flutter/material.dart';
import 'package:flutter_app_planetx/Home.dart';

void main() => runApp(planetX());

class planetX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weight on planet X',
      home: Home(),
    );
  }
}

