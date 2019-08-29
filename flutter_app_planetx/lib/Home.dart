import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int radioValue = 0;

  String _formatedString = '';
  final TextEditingController _weightTextField = new TextEditingController();

  void handleRadioChanged(int value) {

    double _finalValue = 0.0;

    setState(() {
      radioValue = value;

      switch(radioValue) {
        case 0:
          _finalValue = convertAsPerPlanet(_weightTextField.text, 0.06);
          _formatedString = 'Your weight on pluto is ${_finalValue.toStringAsFixed(1)} lbs';
          break;
        case 1:
          _finalValue = convertAsPerPlanet(_weightTextField.text, 0.38);
          _formatedString = 'Your weight on mars is ${_finalValue.toStringAsFixed(1)} lbs';
          break;
        case 2:
          _finalValue = convertAsPerPlanet(_weightTextField.text, 0.91);
          _formatedString = 'Your weight on venus is ${_finalValue.toStringAsFixed(1)} lbs';
          break;
      }
    });

    print(radioValue);
  }

  double convertAsPerPlanet(String weight, double multiplier) {
    if(weight.isNotEmpty && int.parse(weight).toString().isNotEmpty && int.parse(weight) > 0) {
      return int.parse(weight) * multiplier;
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight on planet X'),
        centerTitle: true,
        backgroundColor: Colors.black38,
      ),
      backgroundColor: Colors.blueGrey,
      body: new Container(
        alignment: Alignment.topCenter,
        child: ListView(
          padding: new EdgeInsets.all(2.5),
          children: <Widget>[
            new Image.asset(
              'images/planet.png',
              width: 200,
              height: 200,
            ),
            new Container(
              margin: const EdgeInsets.all(3.0),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  new TextField(
                    decoration: InputDecoration(
                      hintText: 'Weight in pound',
                      labelText: 'Your weight on earth',
                      icon: Icon(Icons.person_outline),
                    ),
                    controller: _weightTextField,
                    keyboardType: TextInputType.number,
                  ),
                  new Padding(padding: EdgeInsets.all(20.0)),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Radio<int>(
                          activeColor: Colors.brown,
                          value: 0,
                          groupValue: radioValue,
                          onChanged: handleRadioChanged),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          'Pluto',
                          style: TextStyle(
                            color: Colors.white30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      new Radio<int>(
                          activeColor: Colors.red,
                          value: 1,
                          groupValue: radioValue,
                          onChanged: handleRadioChanged),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          'Mars',
                          style: TextStyle(
                            color: Colors.white30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      new Radio<int>(
                          activeColor: Colors.orangeAccent,
                          value: 2,
                          groupValue: radioValue,
                          onChanged: handleRadioChanged),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          'Venus',
                          style: TextStyle(
                            color: Colors.white30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  new Padding(padding: EdgeInsets.all(20.0)),

                  new Text(
                    _weightTextField.text.isEmpty ? 'Textfield is empty' : '${_formatedString}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 19.4,
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
