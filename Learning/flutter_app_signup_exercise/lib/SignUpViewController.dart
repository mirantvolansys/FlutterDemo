import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_signup_exercise/ProfileViewController.dart';
import 'package:flutter_app_signup_exercise/UserInfo.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

class SignUpViewController extends StatefulWidget {
  @override
  _SignUpViewControllerState createState() => _SignUpViewControllerState();
}

class _SignUpViewControllerState extends State<SignUpViewController> {
  File _imagePick;

  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();

  final FocusNode _userNameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  UserInfo userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Builder(
        builder: (context) =>  SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 200.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(20.0)),
                Center(
                  child: FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      getImage();
                    },
                    child: new Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: (_imagePick == null
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.5),
                            )
                          : BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: FileImage(_imagePick),
                                fit: BoxFit.cover,
                              ),
                            )),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(20.0)),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: _firstName,
                    focusNode: _firstNameFocus,
                    onFieldSubmitted: (String value) {
                      _fieldFocusChange(context, _firstNameFocus, _lastNameFocus);
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Enter Firstname",
                      labelText: "Firstname",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: _lastName,
                    focusNode: _lastNameFocus,
                    onFieldSubmitted: (String value) {
                      _fieldFocusChange(context, _lastNameFocus, _userNameFocus);
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Enter Lastname",
                      labelText: "Lastname",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: _userName,
                    focusNode: _userNameFocus,
                    onFieldSubmitted: (String value) {
                      _fieldFocusChange(context, _userNameFocus, _emailFocus);
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Enter Username",
                      labelText: "Username",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _email,
                    focusNode: _emailFocus,
                    onFieldSubmitted: (String value) {
                      _fieldFocusChange(context, _emailFocus, _passwordFocus);
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Enter email address",
                      labelText: "Email",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: _password,
                    focusNode: _passwordFocus,
                    onFieldSubmitted: (String value) {
                      _fieldFocusChange(
                          context, _passwordFocus, _confirmPasswordFocus);
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      labelText: "Password",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: _confirmPassword,
                    focusNode: _confirmPasswordFocus,
                    onFieldSubmitted: (String value) {
                      signUpPress(context);
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Confirm Password",
                      labelText: "Confirm Password",
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      signUpPress(context);
                    },
                    color: Colors.blue,
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(20.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (Platform.isIOS){
      var image1 = await cropImage(image);

      setState(() {
        _imagePick = image1;
      });
    } else {
      setState(() {
        _imagePick = image;
      });
    }
  }

  Future<File> cropImage(File imageFile) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      ratioX: 1,
      ratioY: 1,
    );
    return croppedFile;
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void signUpPress(BuildContext context) {
    if (_firstName.text.isEmpty) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter firstname.')));
    } else if (_lastName.text.isEmpty) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter lastname.')));
    } else if (_userName.text.isEmpty) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter username.')));
    } else if (_email.text.isEmpty) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter username.')));
    } else if (!_isValidEmailID(_email.text)) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Please enter valid email id.')));
    } else if (_password.text.isEmpty) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter password.')));
    } else if (_confirmPassword.text.isEmpty) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Please enter confirm password.')));
    } else if (_password.text != _confirmPassword.text) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Password & confirm password should be same.')));
    } else {
      userData = UserInfo(_userName.text, _password.text, _email.text,
          _lastName.text, _firstName.text);
      if (_imagePick != null) {
        userData.file = _imagePick.path;
      }

      _userDataSave(userData);

      var _controller = ProfileViewController();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return _controller;
      }));
    }
  }

  bool _isValidEmailID(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  _userDataSave(UserInfo userdata) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var objectUser = json.encode(userdata.toMap());
    preferences.setString('userLatest', objectUser);
    preferences.setBool("isLoggedin", true);
  }
}
