import 'dart:convert';

import 'package:flutter/material.dart';
import './utils.dart' as utils;
import 'package:http/http.dart' as http;

class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {
  String _cityString;

  Future _gotoNextScreen(BuildContext context) async {
    Map _results = await Navigator.of(context)
        .push(new MaterialPageRoute<Map>(builder: (BuildContext context) {
      return new ChangeCity();
    }));

    if (_results != null && _results.containsKey('enter')) {
      _cityString = _results['enter'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Klimatic'),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _gotoNextScreen(context);
              })
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: Image.asset(
              'images/rain_um.jpg',
              width: 700,
              height: 1500,
              fit: BoxFit.fill,
            ),
          ),
          new Container(
            child: Text(
              _cityString == null ? utils.defaultCity : _cityString,
              style: cityStyle(),
            ),
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 0.0),
            alignment: Alignment.topRight,
          ),
          new Container(
            alignment: Alignment.center,
            child: Image.asset(
              'images/Rain.png',
              height: 100,
              width: 100,
              color: Colors.white,
            ),
          ),
          updateTempWidget(
              _cityString == null ? utils.defaultCity : _cityString),
        ],
      ),
    );
  }

  Future<Map> getWhether(String cityName) async {
    String apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?q=${cityName == null ? utils.defaultCity : cityName}&appid=${utils.appId}&units=imperial';

    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);
  }

  Widget updateTempWidget(String city) {
    return new FutureBuilder(
        future: getWhether(city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map _containerData = snapshot.data;
            return Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 450, 0, 0),
                    child: ListTile(
                      title: Center(
                        child: Text(
                          '${_containerData['main']['temp'].toString()}F',
                          style: tempStyle(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}

class ChangeCity extends StatelessWidget {
  var _cityGetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Change City'),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: <Widget>[
          new Center(
            child: Image.asset(
              'images/snow.jpg',
              width: 700,
              height: 1500,
              fit: BoxFit.fill,
            ),
          ),
          new ListView(
            children: <Widget>[
              new ListTile(
                title: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter City',
                  ),
                  keyboardType: TextInputType.text,
                  controller: _cityGetController,
                ),
              ),
              new ListTile(
                title: FlatButton(
                  onPressed: () {
                    Navigator.pop(context, {'enter': _cityGetController.text});
                  },
                  child: Text('Get City Temprature'),
                  color: Colors.redAccent,
                  textColor: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

TextStyle cityStyle() {
  return TextStyle(
    fontStyle: FontStyle.italic,
    color: Colors.white,
    fontSize: 22.0,
  );
}

TextStyle tempStyle() {
  return TextStyle(
    fontSize: 49.0,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
}
