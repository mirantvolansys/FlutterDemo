import 'package:flutter/material.dart';
import 'package:flutter_app_login_form/CustomLoginForm.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override

  final appTitle = "Login";

  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),

        backgroundColor: Colors.grey.shade50,
        body: CustomLoginForm(),
      ),
    );
  }
}

