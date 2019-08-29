import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  Map _dataQuake = await getDataJson();
  List _dataQuakeList = _dataQuake['features'];

  runApp(new MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Quakes'),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          itemCount: _dataQuakeList.length,
          padding: EdgeInsets.all(15.0),
          itemBuilder: (BuildContext context, int position) {
            final DateFormat format = new DateFormat.yMMMMd('en_US').add_jm(); //('MMMM dd,yyyy HH:mm a')

            return Column(
              children: <Widget>[

                ListTile(

                  title: Text(format.format(DateTime.fromMillisecondsSinceEpoch(
                      _dataQuakeList[position]['properties']['time'])),
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),),
                  subtitle:
                      Text(_dataQuakeList[position]['properties']['place'],
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          fontSize: 18.0,
                        ),),
                  leading: CircleAvatar(
                    radius: 45.0,
                    backgroundColor: Colors.green,
                    child: Text(_dataQuakeList[position]['properties']['mag'].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),),
                  ),

                  onTap: () => onTapClickManageList(context,_dataQuakeList[position]),
                ),

                Divider(
                  height: 40.0,
                ),

              ],
            );
          }),
    ),
  ));
}

void onTapClickManageList(BuildContext context, Map _dataObject) {
  var _alertDialog = new AlertDialog(
    title: Text('Quakes',
    style: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),),
    content: Text(_dataObject['properties']['title'],
    style: TextStyle(
      fontSize: 18.0,
    ),),
    actions: <Widget>[
      FlatButton(onPressed: () => Navigator.of(context).pop(),
          child: Text('OK'))
    ],
  );
  
  showDialog(context: context, builder: (context) {
    return _alertDialog;
  });
}

Future<Map> getDataJson() async {
  String apiURL =
      'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';

  http.Response response = await http.get(apiURL);

  return json.decode(response.body);
}
