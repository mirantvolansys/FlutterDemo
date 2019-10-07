import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_app_learnui_1/TableInColumn.dart';
import 'package:flutter_app_learnui_1/profileView.dart';
//import 'package:flutter_app_learnui_1/TableviewCellWithBlur.dart';
//import 'package:flutter_app_learnui_1/test.dart';
//import 'package:flutter_app_learnui_1/stackwithscroll.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: ProfileView(),
    );
  }
}

class Nutri extends StatefulWidget {
  @override
  _NutriState createState() => _NutriState();
}

class _NutriState extends State<Nutri> {
  List arrayData = List();
  int selectedIndex = -1;
  double sliderValue = 0.5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.addData();
  }

  void addData() {
    var data = Map();
    data["title"] = "Camamber";
    data["cal"] = 145;
    arrayData.add(data);

    data = Map();
    data["title"] = "Brie";
    data["cal"] = 120;
    arrayData.add(data);

    data = Map();
    data["title"] = "Caraway";
    data["cal"] = 214;
    arrayData.add(data);

    data = Map();
    data["title"] = "Chedder";
    data["cal"] = 203;
    arrayData.add(data);

    data = Map();
    data["title"] = "Provolone";
    data["cal"] = 204;
    arrayData.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        centerTitle: Platform.isIOS,
        title: Text(
          "Cheese",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              debugPrint("Menu");
            },
            icon: Icon(
              Icons.menu,
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
      body: Container(
          color: Colors.white,
          child: ListView.separated(
            itemCount: itemBuilderLength(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: height(index),
                color: colorSelected(index),
                child: (selectedIndex != -1 && selectedIndex == (index - 1))
                    ? selectedTile()
                    : normalTile(indexManageBySelected(index)),
              );
            },
            separatorBuilder: (context, index) => Divider(
              height: 0,
              color: Colors.grey,
            ),
          )),
    );
  }

  void listTileTap(int index) {
//    if (selectedIndex != -1 && (selectedIndex == (index - 1))) {
//      return;
//    }

    setState(() {
      if (selectedIndex == index) {
        selectedIndex = -1;
      } else {
        selectedIndex = index;
      }
    });
  }

  Color colorSelected(int index) {
    if (selectedIndex != -1 &&
        ((selectedIndex == index) || (selectedIndex == (index - 1)))) {
      return Colors.grey.withOpacity(0.1);
    }

    return Colors.white;
  }

  double height(int index) {
    if (selectedIndex != -1 && (selectedIndex == (index - 1))) {
      return 260;
    }

    return 80;
  }

  int itemBuilderLength() {
    if (selectedIndex != -1) {
      return arrayData.length + 1;
    }

    return arrayData.length;
  }

  int indexManageBySelected(int index) {
    if (selectedIndex != -1 && (index > selectedIndex)) {
      return (index - 1);
    }
    return index;
  }

  ListTile normalTile(int index) {
    return ListTile(
      onTap: () => listTileTap(index),
      title: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            arrayData[index]["title"],
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w700,
              fontSize: 17.0,
            ),
          )),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                  alignment: Alignment.centerLeft,
                  width: 80,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "${arrayData[index]["cal"]}",
                        style: TextStyle(
                          fontFamily: 'Marker felt',
                          color: Colors.black.withOpacity(0.65),
                          fontWeight: FontWeight.w100,
                          fontSize: 22.0,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 5.0)),
                      Text(
                        "cal",
                        style: TextStyle(
                          fontFamily: 'Times New Roman',
                          color: Colors.black.withOpacity(0.65),
                        ),
                      ),
                    ],
                  )),
              Icon(selectedIndex == index
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right),
            ],
          )),
        ],
      ),
    );
  }

  ListTile selectedTile() {
    return ListTile(
      title: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 80.0,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Center(
                    child: Text(
                      "SODIUM'\n'450 g",
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                      ),
                    ),
                  )),
                  Expanded(
                      child: Center(
                    child: Text(
                      "CARB.'\n'0.6 g",
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                      ),
                    ),
                  )),
                  Expanded(
                      child: Center(
                    child: Text(
                      "FAT'\n'25.4 g",
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                      ),
                    ),
                  )),
                  Expanded(
                      child: Center(
                    child: Text(
                      "PROTEIN'\n'20.6 g",
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Divider(
              height: 1.0,
              color: Colors.grey,
            ),
            Container(
              height: 179,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 20.0, bottom: 2.0),
                        child: Text(
                          "CALORIES",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w700,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 20.0, bottom: 2.0),
                        child: Text(
                          "WEIGHT",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w700,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 2.0, left: 5.0),
                        child: Text(
                          "200 g",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, left: 20.0),
                        child: Text(
                          "155",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 50.0,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        height: 60,
                        width: double.infinity,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              color: Colors.white,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10.0),
                                child: CupertinoSlider(
                                  activeColor: Colors.green,
                                  value: sliderValue,
                                  onChanged: (value) {
                                    setState(() {
                                      sliderValue = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                            onPressed: () {
                              print("Eat ${arrayData[selectedIndex]["title"]}");
                            },
                            child: Text(
                              "EAT THIS",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
