import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class TableviewCellWithBlur extends StatefulWidget {
  @override
  _TableviewCellWithBlurState createState() => _TableviewCellWithBlurState();
}

class _TableviewCellWithBlurState extends State<TableviewCellWithBlur> {
  List arrayData = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    addData();
  }

  void addData() {
    var map = Map();
    map["image"] = "1.jpg";
    map["title"] = "SUITS";
    map["item_count"] = 30;
    arrayData.add(map);

    map = Map();
    map["image"] = "5.jpeg";
    map["title"] = "DRESSES";
    map["item_count"] = 41;
    arrayData.add(map);

    map = Map();
    map["image"] = "10.jpeg";
    map["title"] = "T-SHIRTS";
    map["item_count"] = 51;
    arrayData.add(map);

    map = Map();
    map["image"] = "1.jpg";
    map["title"] = "SHIRTS";
    map["item_count"] = 21;
    arrayData.add(map);

    map = Map();
    map["image"] = "5.jpeg";
    map["title"] = "KURTAS";
    map["item_count"] = 1;
    arrayData.add(map);

    map = Map();
    map["image"] = "10.jpeg";
    map["title"] = "DRESSES1";
    map["item_count"] = 10;
    arrayData.add(map);

    map = Map();
    map["image"] = "1.jpg";
    map["title"] = "DRESSES2";
    map["item_count"] = 80;
    arrayData.add(map);

    map = Map();
    map["image"] = "5.jpeg";
    map["title"] = "DRESSES3";
    map["item_count"] = 750;
    arrayData.add(map);

    map = Map();
    map["image"] = "10.jpeg";
    map["title"] = "DRESSES4";
    map["item_count"] = 95;
    arrayData.add(map);

    map = Map();
    map["image"] = "5.jpeg";
    map["title"] = "DRESSES5";
    map["item_count"] = 65;
    arrayData.add(map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        centerTitle: Platform.isIOS,
        title: Text(
          "Shop",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 25.0,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              debugPrint("Menu");
            },
            icon: Icon(
              Icons.menu,
              color: Colors.black87,
            )),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              debugPrint("Search");
            },
            icon: Icon(
              Icons.search,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 80,
            color: Colors.grey.withOpacity(0.05),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Container(
                  color: Colors.white,
                  child: TextField(
                    controller: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: arrayData.length,
                  itemBuilder: (context, index) {
                    return indexBuilder(index);
                  }))
        ],
      ),
    );
  }

  Container indexBuilder(int index) {
    return Container(
      height: 250.0,
      child: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          Image.asset(
            "assets/${arrayData[index]["image"]}",
            height: double.infinity,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10.0,
                    sigmaY: 10.0,
                  ),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    width: double.infinity,
                    height: 60.0,
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                arrayData[index]["title"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            height: double.infinity,
                            alignment: Alignment.centerLeft,
                          )),
                          Expanded(
                              child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Text(
                                "${arrayData[index]["item_count"]} ITEMS",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            height: double.infinity,
                            alignment: Alignment.centerRight,
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
