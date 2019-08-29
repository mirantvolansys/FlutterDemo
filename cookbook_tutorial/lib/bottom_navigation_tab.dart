import 'package:flutter/material.dart';

class BottomNavigationTab extends StatefulWidget {
  BottomNavigationTab({Key key}) : super(key: key);
  @override
  _BottomNavigationTabState createState() => _BottomNavigationTabState();
}

class _BottomNavigationTabState extends State<BottomNavigationTab> {

  final List<Widget> _widgetOptions = <Widget> [
    Home(tabName: "Home", selectedIndex: 0,),
    Business(tabName: "Business", selectedIndex: 1),
    School(tabName: "School", selectedIndex: 3),
    Settings(tabName: "Settings", selectedIndex: 4),
  ];

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appThemeColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text("Bottom Navigation Tab"),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: appThemeColor,
        onTap: _onItemTapped,
      ),
    );
  }

}

class Home extends StatelessWidget {
  final String tabName;
  final int selectedIndex;
  Home({Key key, this.tabName, this.selectedIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: _textDetail(tabName, selectedIndex),
      ),
    );
  }
}

class Business extends StatelessWidget {
  final String tabName;
  final int selectedIndex;
  Business({Key key, this.tabName, this.selectedIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: _textDetail(tabName, selectedIndex),
      ),
    );
  }
}

class School extends StatelessWidget {
  final String tabName;
  final int selectedIndex;
  School({Key key, this.tabName, this.selectedIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: _textDetail(tabName, selectedIndex),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  final String tabName;
  final int selectedIndex;
  Settings({Key key, this.tabName, this.selectedIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: _textDetail(tabName, selectedIndex),
      ),
    );
  }
}

Text _textDetail(String tabName, int selectedIndex) {
  const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  return Text(
    "Index $selectedIndex: $tabName",
    style: optionStyle,
  );
}

