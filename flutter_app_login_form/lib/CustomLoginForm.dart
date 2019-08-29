import 'package:flutter/material.dart';

class CustomLoginForm extends StatefulWidget {
  @override
  _CustomLoginFormState createState() => _CustomLoginFormState();
}


class _LoginData {
  String name = "";
  String password = "";
}

class _CustomLoginFormState extends State<CustomLoginForm> {
  final _formKey = GlobalKey<FormState>();

  _LoginData _data = _LoginData();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.asset(
              "images/face.png",
              width: 90,
              height: 90,
              color: Colors.blueGrey,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  gapPadding: 3.3,
                  borderRadius: BorderRadius.circular(3.3)
                )
              ),
              validator: (value){
                if (value.isEmpty) {
                  setState(() {
                    _data.name = '';
                  });
                  return 'Please enter name';
                } else {
                  _data.name = value;
                }
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      gapPadding: 3.3,
                      borderRadius: BorderRadius.circular(3.3)
                  )
              ),
              validator: (value){
                if (value.isEmpty) {
                  setState(() {
                    _data.password = '';
                  });
                  return 'Please enter password';
                } else {
                  _data.password = value;
                }
              },
            ),
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()) {
                        setState(() {
                          _data.name = _data.name;
                        });
                        Scaffold. of(context).showSnackBar(SnackBar(content: Text('All is good')));
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      _formKey.currentState.reset();
                      setState(() {
                        _data.name = '';
                      });
                    },
                    child: Text('Clear'),
                  ),
                ),

              ],
            )
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(child: _data.name.isEmpty ? Text('') : Text('Hello ${_data.name}',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            )),
          )

        ],
      ),
    );
  }
}
