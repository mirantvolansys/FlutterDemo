import 'package:flutter/material.dart';

class ForgetViewController extends StatefulWidget {
  @override
  _ForgetViewControllerState createState() => _ForgetViewControllerState();
}

class _ForgetViewControllerState extends State<ForgetViewController> {
  final TextEditingController _emailID = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Center(
        child: Container(
          height: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 12.0, left: 12.0),
                child: TextFormField(
                  controller: _emailID,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (String value) {
                    _alertShow(context, _emailID.text);
                  },
                  decoration: InputDecoration(
                    hintText: "Enter email id",
                    labelText: "Email ID",
                    icon: Icon(Icons.email),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 80.0)),
              Center(
                child: RaisedButton(
                  onPressed: () {
                    _alertShow(context, _emailID.text);
                  },
                  color: Colors.blue,
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _alertShow(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Note!"),
          content: message.isNotEmpty
              ? (_isValidEmailID(message)
                  ? Text("Change password link successfully sent to $message")
                  : Text("Please enter valid email id"))
              : Text("Please enter your email id"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();

                if (message.isNotEmpty && _isValidEmailID(message)) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  bool _isValidEmailID(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
