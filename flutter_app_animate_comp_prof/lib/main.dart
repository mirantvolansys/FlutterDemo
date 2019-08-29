import 'package:flutter/material.dart';
import 'package:flutter_app_animate_comp_prof/ui/CompanyDetailsAnimator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new CompanyDetailsAnimator(),
    );
  }
}


