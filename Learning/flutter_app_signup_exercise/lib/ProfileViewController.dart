import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_signup_exercise/LoginViewController.dart';
import 'package:flutter_app_signup_exercise/NoAnimationRoute.dart';
import 'package:flutter_app_signup_exercise/UserInfo.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

class ProfileViewController extends StatefulWidget {
  @override
  _ProfileViewControllerState createState() => _ProfileViewControllerState();
}

class _ProfileViewControllerState extends State<ProfileViewController> {
  final _formKey = GlobalKey<FormState>();
  bool _isEdit = false;
  File _imagePick;

  UserInfo userLastLogin;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadDataSave();
  }

  _loadDataSave() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map obj = json.decode(preferences.getString('userLatest'));
    print(obj);

    userLastLogin = UserInfo.map(obj);

    setState(() {
      _imagePick = File(userLastLogin.file);

      _firstName.text = userLastLogin.firstname;
      _lastName.text = userLastLogin.lastname;
      _email.text = userLastLogin.email;
      _userName.text = userLastLogin.username;
      _password.text = userLastLogin.password;
      _confirmPassword.text = userLastLogin.password;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? "Edit Profile" : "Profile"),
        leading: Container(),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                setState(() {
                  if (_isEdit) {
                    signUpPress(context);
                  } else {
                    _isEdit = !_isEdit;
                  }
                });
              },
              child: _isEdit
                  ? Icon(
                      Icons.save,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.edit,
                      color: Colors.white,
                    )),
        ],
      ),
      body: Builder(
        builder: (context) => Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(20.0)),
                  Center(
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: _isEdit ? _imageProfileButtonClick : null,
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
                      enabled: _isEdit,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (String value) {
                        _fieldFocusChange(
                            context, _firstNameFocus, _lastNameFocus);
                      },
                      decoration:
                          _decorationTextField("Enter Firstname", "Firstname"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: _lastName,
                      focusNode: _lastNameFocus,
                      enabled: _isEdit,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (String value) {
                        _fieldFocusChange(
                            context, _lastNameFocus, _passwordFocus);
                      },
                      decoration:
                          _decorationTextField("Enter Lastname", "Lastname"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: _userName,
                      focusNode: _userNameFocus,
                      enabled: false,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: InputBorder.none,
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
                      enabled: false,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter email address",
                        labelText: "Email",
                      ),
                    ),
                  ),
                  _getPasswordFields(context),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: RaisedButton(
                        onPressed: () async {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.setBool("isLoggedin", false);

                          var _controller = LoginViewController();

                          Navigator.of(context).push(
                              NoAnimationMaterialPageRoute(
                                  builder: (BuildContext context) {
                            return _controller;
                          }));
                        },
                        color: Colors.red,
                        child: Text(
                          "LOGOUT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
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
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (Platform.isIOS) {
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

  InputDecoration _decorationTextField(String hint, String label) {
    return _isEdit
        ? InputDecoration(
            hintText: hint,
            labelText: label,
          )
        : InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            labelText: label,
          );
  }

  void _imageProfileButtonClick() {
    getImage();
  }

  Widget _getPasswordFields(BuildContext context) {
    if (_isEdit) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: _password,
              focusNode: _passwordFocus,
              obscureText: true,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (String value) {
                _fieldFocusChange(
                    context, _passwordFocus, _confirmPasswordFocus);
              },
              decoration: _decorationTextField("Enter Password", "Password"),
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
              decoration: _decorationTextField(
                  "Enter Confirm Password", "Confirm Password"),
            ),
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextFormField(
          controller: _password,
          focusNode: _passwordFocus,
          enabled: false,
          obscureText: true,
          textInputAction: TextInputAction.next,
          decoration: _decorationTextField("Enter Password", "Password"),
        ),
      );
    }
  }

  void signUpPress(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
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
      userLastLogin = UserInfo(_userName.text, _password.text, _email.text,
          _lastName.text, _firstName.text);
      if (_imagePick != null) {
        userLastLogin.file = _imagePick.path;
      }

      _userDataSave(userLastLogin);

      setState(() {
        _isEdit = !_isEdit;
      });
    }
  }

  bool _isValidEmailID(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  _userDataSave(UserInfo userdata) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var objectUser = json.encode(userdata.toMap());
    preferences.setString('userLatest', objectUser);
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
