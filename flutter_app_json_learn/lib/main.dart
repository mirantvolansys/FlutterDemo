import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {

  List _dataJson = await getJson();

  runApp(
      new MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Json Parsing'),
            backgroundColor: Colors.orange,
          ),

          body: new ListView.builder(itemCount: _dataJson.length,
          padding: EdgeInsets.all(15.0),
          itemBuilder: (BuildContext context, int position){
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(_dataJson[position]['title'],
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  subtitle: Text(_dataJson[position]['body']),

                  leading: CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Text(_dataJson[position]['title'][0]),
                  ),

                  onTap: () => showMessage(context, _dataJson[position]['title']),

                ),

                Divider(height: 4.0,),
              ],
            );
          }),

        ),
      ));
}

void showMessage (BuildContext context, String title) {
  var _alertDialog = AlertDialog(
    title: Text(title),
    actions: <Widget>[
      FlatButton(onPressed: () => Navigator.of(context).pop(),
          child: Text('Ok'))
    ],
  );

  showDialog(context: context, builder: (context) {
    return _alertDialog;
  });
}

Future<List> getJson() async{
//    String apiURL = 'http://jsonplaceholder.typicode.com/users';
    String apiURL = 'https://jsonplaceholder.typicode.com/posts';

    http.Response response = await http.get(apiURL);

    return json.decode(response.body);
}

