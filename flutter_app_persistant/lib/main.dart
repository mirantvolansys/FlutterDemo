import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() async {
  String _data = await readToFile();

  if (_data != null) {
    print(_data);
  }

  runApp(new MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _textController = TextEditingController();

  String _dataSaved = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadDataSave();
  }

  _loadDataSave() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getString('mike') != null &&
        preferences.getString('mike').isNotEmpty) {
      _dataSaved = preferences.getString('mike');
      print('Mirant $_dataSaved');
    } else {
      print('Empty');
    }
  }

  _getDataSave(String msg) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('mike', msg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Write'),
        backgroundColor: Colors.redAccent,
      ),
      body: new Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _textController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Add text in file',
              ),
            ),
          ),

          FlatButton(
            onPressed: () {
              _getDataSave(_textController.text);
//            writeToFile(_textController.text);
//            _textController.text = "";
//            FocusScope.of(context).requestFocus(new FocusNode());
            },
//
            child: Text('Write in File'),
            textColor: Colors.white,
            color: Colors.redAccent,
          ),

//          FutureBuilder(
//            future: readToFile(),
//            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//              if(snapshot.hasData) {
//                return Text(snapshot.data);
//              } else {
//                return Text('Nothing as of now');
//              }
//            },
//          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(_dataSaved)),
          )
        ],
      ),
    );
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return new File('$path/data.txt');
}

Future<File> writeToFile(String message) async {
  final file = await _localFile;
  return file.writeAsString(message);
}

Future<String> readToFile() async {
  try {
    final file = await _localFile;
    String data = await file.readAsString();

    return data;
  } catch (e) {
    return 'Nothing saved yet.';
  }
}
