import 'package:flutter/material.dart';
import 'package:flutter_app_scroll_tabbar/Bike.dart';
import 'package:flutter_app_scroll_tabbar/Car.dart';

class TabbarLikeiOS extends StatefulWidget {
  @override
  _TabbarLikeiOSState createState() => _TabbarLikeiOSState();
}

class _TabbarLikeiOSState extends State<TabbarLikeiOS> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: tabContent.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(tabContent[_currentIndex].title),
          ),
          body: tabContent[_currentIndex].content,
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(
                    () {
                  _currentIndex = index;
                },
              );
            }, // new
            currentIndex: _currentIndex, // new
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.mail),
                title: Text('Tab1'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.verified_user),
                title: Text('Tab2'),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class TabContent {
  String title;
  Widget content;
  TabContent({this.title, this.content});
}

List<TabContent> tabContent = [
  TabContent(
    title: 'Tab1',
    content: CarTravel(),
  ),
  TabContent(
    title: 'Tab2',
    content: BikeTravel(),
  )
];