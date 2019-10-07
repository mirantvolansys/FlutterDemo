import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomeClass()
    );
  }
}

class HomeClass extends StatefulWidget {
  @override
  _HomeClassState createState() => _HomeClassState();
}

class _HomeClassState extends State<HomeClass> {

  var valueDrop = "Mike";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DropDown"),
      ),
      body: Center(
        child: new DropdownButton<String>(
          items: <String>['None','A', 'B', 'C', 'D'].map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          onChanged: (value){
            setState(() {
              if(value == "None") {
                valueDrop = "Mike";
              } else {
                valueDrop = value;
              }
            });
          },
          hint: Text(valueDrop),
        ),
      ),
    );
  }
}

