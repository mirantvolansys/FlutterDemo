import 'package:flutter/material.dart';
import 'package:flutter_app_scroll_tabbar/tabBar.dart';
import 'package:flutter_app_scroll_tabbar/tabLikeiOS.dart';

//void main() => runApp(MyApp());
void main() => runApp(TabbarLikeiOS());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          title: Text("ScrollView Demo"),
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 200,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  // A fixed-height child.
                  color: const Color(0xff808000), // Yellow
                  height: 400.0,
                ),
                Container(
                  // Another fixed-height child.
                  color: const Color(0xff008000), // Green
                  height: 400.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


