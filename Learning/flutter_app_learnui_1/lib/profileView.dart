import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List arrayData = ["FACEBOOK", "LINKEDIN", "TWITTER"];

  var isFacebook = false;
  var isLinkedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        centerTitle: Platform.isIOS,
        title: Text(
          "Title",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              debugPrint("back");
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            )),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              debugPrint("Search");
            },
            icon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: profileContainer(),
    );
  }

  Widget profileContainer() {
    return Column(
      children: <Widget>[
        Container(
          height: 320,
          child: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/5.jpeg'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: new BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: new Container(
                    decoration: new BoxDecoration(
                        color: Colors.black.withOpacity(0.25)),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Expanded(
                      child: Container(
                          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          child: CircleAvatar(
                            child: ClipOval(
                                child: Image.asset("assets/1.jpg",
                                    fit: BoxFit.fill)),
                            radius: 40.0,
                          )),
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Text(
                        "Samantha Ayrton",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontFamily: 'Times New Roman'),
                      ),
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "London, England",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontFamily: 'Times New Roman'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))),
                  Container(
                    color: Colors.black.withOpacity(0.95),
                    height: 60,
                    child: Center(
                      child: Container(
                        height: 40,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Center(
                                    child: Text(
                              "FOLLOWING\n321",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ))),
                            VerticalDivider(
                              color: Colors.white,
                              width: 1,
                            ),
                            Expanded(
                                child: Center(
                                    child: Text(
                              "FOLLOWERS\n125",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ))),
                            VerticalDivider(
                              color: Colors.white,
                              width: 1,
                            ),
                            Expanded(
                                child: Center(
                                    child: Text(
                              "FRIENDS\n258",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ))),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 80,
          child: Center(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                child: Text(
                  "FIND FRIENDS",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              color: Colors.green,
            ),
          ),
        ),
        Divider(
          height: 0.5,
          color: Colors.grey,
        ),
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: listCell(index),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 0.5,
                  color: Colors.grey,
                );
              },
              itemCount: arrayData.length),
        )
      ],
    );
  }

  Widget listCell(int index) {
    return Container(
      height: 60.0,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(Icons.tag_faces),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    arrayData[index],
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ],
            ),
          )),
          Expanded(
              child: Container(
                  alignment: Alignment.centerRight,
                  child: widgetIndexWise(index))),
        ],
      ),
    );
  }

  Widget widgetIndexWise(int index) {
    if (index == 0 || index == 1) {
      return CupertinoSwitch(
          activeColor: Colors.black,
          value: index == 0 ? isFacebook : isLinkedIn,
          onChanged: (value) {
            setState(() {
              if (index == 0) {
                isFacebook = !isFacebook;
              } else {
                isLinkedIn = !isLinkedIn;
              }
            });
          });
    } else {
      return RaisedButton(
        onPressed: () {
          print("Connect");
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0,right: 12.0,top: 5.0,bottom: 5.0),
          child: Text("CONNECT"),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0)),
        color: Colors.blue,
      );
    }
  }
}
