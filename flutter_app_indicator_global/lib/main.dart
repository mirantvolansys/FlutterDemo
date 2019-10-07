import 'package:flutter/material.dart';
import 'package:flutter_app_indicator_global/async.dart';
import 'package:load/load.dart'; //https://pub.dev/packages/async_loader

import 'package:flutter_app_indicator_global/Tester.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LoadingProvider(
      themeData: LoadingThemeData(
        tapDismiss: false,
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ExampleApp(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: FlatButton(
          onPressed: () {
//            showLoadingDialog();
//
//            Future.delayed(const Duration(seconds: 10 ), () {
//              hideLoadingDialog();
//            });

            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return tester();
            }));
          },
          child: Text("Hide / Show"),
          color: Colors.lightBlue,
        ),
      ),
    );
  }
}
