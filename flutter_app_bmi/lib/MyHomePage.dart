import 'package:flutter/material.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _ageTextController = TextEditingController();
  final TextEditingController _heightTextController = TextEditingController();
  final TextEditingController _weightTextController = TextEditingController();

  final FocusNode _ageTextFocusNode = FocusNode();

  double _bmiFinal = 0.0;
  String _bmiResult = 'Underweight';

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('images/bmilogo.png',
                width: 150,
                height: 150,),
            ),

            new Container(
              alignment: Alignment.topCenter,
              color: Colors.grey.shade200,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _ageTextController,
                      focusNode: _ageTextFocusNode,
                      decoration: InputDecoration(
                          labelText: 'Age',
                          icon: Icon(Icons.person_outline)
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true),
                      controller: _heightTextController,
                      decoration: InputDecoration(
                          labelText: 'Height in feet',
                          icon: Icon(Icons.insert_chart)
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _weightTextController,
                      decoration: InputDecoration(
                          labelText: 'Weight in lbs',
                          icon: Icon(Icons.line_weight)
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {

                          if(_heightTextController.text.isNotEmpty && _weightTextController.text.isNotEmpty && _heightTextController.text.isNotEmpty) {
                            _bmiFinal = 703 * (double.parse(_weightTextController.text) / pow((double.parse(_heightTextController.text) * 12), 2));

                            if (double.parse(_bmiFinal.toStringAsFixed(1)) < 18.5){
                              _bmiResult = 'Underweight';
                            } else if (double.parse(_bmiFinal.toStringAsFixed(1)) < 24.9){
                              _bmiResult = 'Normal weight';
                            } else if (double.parse(_bmiFinal.toStringAsFixed(1)) < 29.9){
                              _bmiResult = 'Overweight';
                            } else {
                              _bmiResult = 'Obesity';
                            }
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text('All textfields are compulsory.')));
                          }
                        });


//                        FocusScope.of(context).requestFocus(_ageTextFocusNode);
                        FocusScope.of(context).requestFocus(new FocusNode());
                    },

                      color: Colors.pinkAccent,
                      child: Text('Calculate',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),),
                    ),
                  ),

                  new Padding(padding: new EdgeInsets.all(5.0)),

                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                _bmiFinal < 0 ? 'Error/Empty textfield' : 'Your BMI is: ${_bmiFinal.toStringAsFixed(1)}',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  fontSize: 30.0,
                ),),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(_bmiResult,
                style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.w500,
                  fontSize: 26.0,
                ),),
            ),

          ],
        ),
      );
  }
}
