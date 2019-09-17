import 'package:flutter/material.dart';
import 'package:flutter_app_route_aware/FutureRouteAware.dart';

class ScreenOther extends StatefulWidget {
  @override
  _ScreenOtherState createState() => _ScreenOtherState();
}

class _ScreenOtherState extends State<ScreenOther> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listArrayClass.add("Screen Two");
  }

  @override
  Widget build(BuildContext context) {
    return FeatureFlagWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Screen B"),
          backgroundColor: Colors.green,
        ),

        body: Container(),
      ),
    );
  }
}
