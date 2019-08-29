import 'package:flutter/material.dart';

//Category Model
class Category {
  const Category({this.name, this.icon});
  final String name;
  final IconData icon;
}

// List of Category Data objects.
const List<Category> arrCategory = <Category>[
  Category(name: 'General', icon: Icons.assessment),
  Category(name: 'Tech', icon: Icons.code),
  Category(name: 'Lifestyle', icon: Icons.people),
  Category(name: 'Finance', icon: Icons.account_balance),
  Category(name: 'Education', icon: Icons.school),
  Category(name: 'Sports', icon: Icons.settings_input_composite),
];

class SwipeTabCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return tabController();
  }
}

Widget tabController() {
  return DefaultTabController(
      length: arrCategory.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tabbed AppBar"),
          bottom: TabBar(
            isScrollable: true,
            tabs: arrCategory.map((Category choice) {
              return Tab(
                text: choice.name,
                icon: Icon(choice.icon),
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: arrCategory.map((Category choice) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: TabCard(choice: choice),
            );
          }).toList(),
        ),
      ));
}


class TabCard extends StatelessWidget {

  const TabCard({Key key, this.choice}) : super(key: key);
  final Category choice;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(choice.icon, size: 128.0, color: textStyle.color),
          Text(choice.name, style: textStyle)
        ],
      ),
    );
  }
}


