import 'package:flutter/material.dart';
import 'package:flutter_app_scroll_tabbar/Bike.dart';
import 'package:flutter_app_scroll_tabbar/Car.dart';
import 'package:flutter_app_scroll_tabbar/Transist.dart';

class TabbarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text("TabBar controller demo"),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_transit)),
                  Tab(icon: Icon(Icons.directions_bike)),
                ],
              ),
            ),

            body: TabBarView(children: [
              CarTravel(),
              Transist(),
              BikeTravel(),
            ]),
          ),
        )
    );
  }
}