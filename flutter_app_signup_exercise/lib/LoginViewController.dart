import 'package:flutter/material.dart';
import 'package:flutter_app_signup_exercise/ForgetViewController.dart';
import 'package:flutter_app_signup_exercise/ProfileViewController.dart';
import 'package:flutter_app_signup_exercise/SignUpViewController.dart';
import 'package:flutter_app_signup_exercise/UserInfo.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

class LoginViewController extends StatefulWidget {
  @override
  _LoginViewControllerState createState() => _LoginViewControllerState();
}

class _LoginViewControllerState extends State<LoginViewController> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FocusNode _userNameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  UserInfo userLastLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("Login");

    _loadDataSave();
  }

  _loadDataSave() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getBool("isLoggedin") != null &&
        preferences.getBool('isLoggedin') == true) {
      var _controller = ProfileViewController();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return _controller;
      }));
    } else {
      if (preferences.getString('userLatest') != null &&
          preferences.getString('userLatest').isNotEmpty) {
        Map obj = json.decode(preferences.getString('userLatest'));
        print(obj);

        userLastLogin = UserInfo.map(obj);
        _userName.text = userLastLogin.username;
        _password.text = userLastLogin.password;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text("Login"),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(12.0)),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: _userName,
                    textInputAction: TextInputAction.next,
                    focusNode: _userNameFocus,
                    onFieldSubmitted: (String value) {
                      _fieldFocusChange(
                          context, _userNameFocus, _passwordFocus);
                    },
                    decoration: InputDecoration(
                      hintText: "Enter username",
                      labelText: "Username",
                      icon: Icon(Icons.person),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: _password,
                    obscureText: true,
                    focusNode: _passwordFocus,
                    onFieldSubmitted: (String value) {
                      var _controller = ProfileViewController();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return _controller;
                      }));
                    },
                    decoration: InputDecoration(
                      hintText: "Enter password",
                      labelText: "Password",
                      icon: Icon(Icons.lock),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(12.0)),
                Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          var _controller = ForgetViewController();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return _controller;
                          }));
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 12.0)),
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      loginPress(context);
                    },
                    color: Colors.blue,
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: FlatButton(
                    onPressed: () {
                      var _controller = SignUpViewController();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return _controller;
                      }));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void loginPress(BuildContext context) {
    if (_userName.text.isEmpty) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter username.')));
    } else if (_password.text.isEmpty) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter password.')));
    } else if (userLastLogin == null ||
        _userName.text != userLastLogin.username ||
        _password.text != userLastLogin.password) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
              'Please check your credential. Credential not found into database.')));
    } else {
      _userDataSave();

      var _controller = ProfileViewController();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return _controller;
      }));
    }
  }

  _userDataSave() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var objectUser = json.encode(userLastLogin.toMap());
    preferences.setString('userLatest', objectUser);
    preferences.setBool("isLoggedin", true);
  }
}
