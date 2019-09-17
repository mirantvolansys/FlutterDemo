import 'package:flutter/material.dart';

import 'package:flutter_app_signup_exercise/LoginViewController.dart';
import 'package:flutter_app_signup_exercise/ProfileViewController.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  Future<Widget> _loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool("isLoggedin") != null &&
        preferences.getBool('isLoggedin') == true) {
      return ProfileViewController();
    } else {
      return LoginViewController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<Widget>(
          future: _loadData(),
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot){
            if(snapshot.hasData)
              return snapshot.data;

            return Container(child: CircularProgressIndicator());
          }
      ),
    );
  }
}

