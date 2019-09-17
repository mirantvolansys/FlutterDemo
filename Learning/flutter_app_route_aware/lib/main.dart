import 'package:flutter/material.dart';
import 'package:flutter_app_route_aware/FutureRouteAware.dart';
import 'package:flutter_app_route_aware/NewScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScreenOne(),
      navigatorObservers: [routeObserver],
    );
  }
}


class ScreenOne extends StatefulWidget {
  @override
  _ScreenOneState createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listArrayClass.add("Screen One");
  }

  @override
  Widget build(BuildContext context) {
    return FeatureFlagWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Screen A"),
          backgroundColor: Colors.green,
        ),

        body: Container(
          child: Center(
            child: RaisedButton(onPressed: (){
              pushMaterialPageRoute(context, ScreenOther());

            },
              child: Text("Next Screen"),),
          ),
        ),
      ),
    );
  }
}




