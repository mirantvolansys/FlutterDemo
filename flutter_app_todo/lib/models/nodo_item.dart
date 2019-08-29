import 'package:flutter/material.dart';

class NoDoItem extends StatelessWidget {

  String _itemName;
  String _dateCreated;
  int _id;

  NoDoItem(this._itemName, this._dateCreated);

  NoDoItem.map(dynamic obj) {
    this._itemName = obj['itemName'];
    this._dateCreated = obj['dateCreated'];
    this._id = obj['id'];
  }

  String get itemName => this._itemName;
  String get dateCreated => this._dateCreated;
  int get id => this._id;

  Map<String,dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['itemName'] = this._itemName;
    map['dateCreated'] = this._dateCreated;

    if(this._id != null) {
      map['id'] = this._id;
    }
    
    return map;
  }

  NoDoItem.formMap(Map<String,dynamic> map) {
    this._itemName = map['itemName'];
    this._dateCreated = map['dateCreated'];
    this._id = map['id'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_itemName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.9,
          ),),

          new Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text('Created on: $_dateCreated',
              style: TextStyle(
                color: Colors.white70,
                fontStyle: FontStyle.italic,
                fontSize: 13.5,
              ),),
          )
        ],
      ),
    );
  }
}
