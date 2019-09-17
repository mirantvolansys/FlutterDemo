import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_actionsheet_dropdo/actionsheetdemo.dart';
import 'package:flutter_app_actionsheet_dropdo/dropdown.dart';

void main() => runApp(DropDown());

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ActionSheetDemo();
  }
}

class ActionSheetDemo extends StatefulWidget {
  @override
  _ActionSheetDemoState createState() => _ActionSheetDemoState();
}

class _ActionSheetDemoState extends State<ActionSheetDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return Center(
                  child: RaisedButton(
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => CupertinoActionSheet(
                            title: const Text('Choose Options'),
                            message: const Text('Your options are '),
                            actions: <Widget>[
                              CupertinoActionSheetAction(
                                child: const Text('One'),
                                onPressed: () {

                                  Navigator.pop(context, 'One');
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: const Text('Two'),
                                onPressed: () {

                                  Navigator.pop(context, 'Two');
                                },
                              )
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              child: const Text('Cancel'),
                              isDefaultAction: true,
                              onPressed: () {
                                Navigator.pop(context, 'Cancel');
                              },
                            )),
                      ).then<void>((value){
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text("$value"),duration: Duration(milliseconds: 800),));
                      });
                    },
                    child: Text("Mike"),
                  )
              );
            },
          )),
    );
  }
}
