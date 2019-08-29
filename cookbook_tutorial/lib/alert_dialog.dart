import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class AlertDialogDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Alert Dialog Demo"),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            RaisedButton(
              child: Text("Alert with all options"),
              onPressed: () {
                if (Platform.isAndroid) {
                  // Android-specific code
                  var alertDialog = buildDialog(
                      title: "App Name",
                      message: "Would you like to continue?",
                      confirm: "Yes",
                      confirmFn: () {
                        print("Confirm to Continue......");
                        Navigator.pop(context);
                      },
                      cancel: "No",
                      cancelFn: () {
                        print("Cancel to Stop......");
                        Navigator.pop(context);
                      });
                  showDialog(
                      context: context, builder: (context) => alertDialog);
                } else {
                  // iOS-specific code
                  var alertDialog = buildDialogIOS(
                      title: "App Name",
                      message: "Would you like to continue?",
                      confirm: "Yes",
                      confirmFn: () {
                        print("Confirm to Continue......");
                        Navigator.pop(context);
                      },
                      cancel: "No",
                      cancelFn: () {
                        print("Cancel to Stop......");
                        Navigator.pop(context);
                      });
                  showCupertinoDialog(
                      context: context, builder: (context) => alertDialog);
                }
              },
            ),
            RaisedButton(
              child: Text("Alert with one button"),
              onPressed: () {
                if (Platform.isAndroid) {
                  // Android-specific code
                  var alertDialog = buildDialog(
                    title: "App Name",
                    message: "This is inform you that...",
                    confirm: "Ok",
                    confirmFn: () {
                      print("Confirm to Continue......");
                      Navigator.pop(context);
                    },
                  );
                  showDialog(
                      context: context, builder: (context) => alertDialog);
                } else if (Platform.isIOS) {
                  // iOS-specific code
                  var alertDialog = buildDialogWithSingleButtonIOS(
                    title: "App Name",
                    message: "This is inform you that...",
                    confirm: "Ok",
                    confirmFn: () {
                      print("Confirm to Continue......");
                      Navigator.pop(context);
                    },
                  );
                  showCupertinoDialog(
                      context: context, builder: (context) => alertDialog);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

CupertinoAlertDialog buildDialogWithSingleButtonIOS(
    {title, message, confirm, confirmFn}) {
  return CupertinoAlertDialog(
    title: title != null ? Text(title) : null,
    content: message != null ? Text(message) : null,
    actions: <Widget>[
      confirmFn != null
          ? CupertinoDialogAction(
              onPressed: confirmFn, child: Text(confirm))
          : null,
    ],
  );
}

CupertinoAlertDialog buildDialogIOS(
    {title, message, confirm, cancel, confirmFn, cancelFn}) {
  return CupertinoAlertDialog(
    title: title != null ? Text(title) : null,
    content: message != null ? Text(message) : null,
    actions: <Widget>[
      confirmFn != null
          ? CupertinoDialogAction(
              onPressed: confirmFn, child: Text(confirm))
          : null,
      cancelFn != null
          ? CupertinoDialogAction(
              onPressed: cancelFn, child: Text(cancel))
          : null
    ],
  );
}

AlertDialog buildDialog(
    {title, message, confirm, cancel, confirmFn, cancelFn}) {
  return AlertDialog(
    title: title != null ? Text(title) : null,
    content: message != null ? Text(message) : null,
    actions: <Widget>[
      confirmFn != null
          ? FlatButton(onPressed: confirmFn, child: Text(confirm))
          : null,
      cancelFn != null
          ? FlatButton(onPressed: cancelFn, child: Text(cancel))
          : null
    ],
  );
}
