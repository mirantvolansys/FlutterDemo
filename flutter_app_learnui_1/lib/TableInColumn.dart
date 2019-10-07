import 'dart:io';

import 'package:flutter/material.dart';

class TableInColumn extends StatefulWidget {
  @override
  _TableInColumnState createState() => _TableInColumnState();
}

class _TableInColumnState extends State<TableInColumn> {
  @override

  List arrayImage = ["assets/1.jpg","assets/5.jpeg","assets/10.jpeg"];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        centerTitle: Platform.isIOS,
        title: Text(
          "Albums",
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
      body: viewListTable(),
    );
  }

  Widget viewListTable() {
    return Container(
      color: Colors.white,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return listViewCell(index);
          },
          separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
              ),
          itemCount: 10),
    );
  }

  Widget listViewCell(int index) {
    return Container(
      height: 170,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Unsorted",
                    style: TextStyle(color: Colors.grey),
                  ),
                )),
                Expanded(
                    child: Container(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      "125",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: gridView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget gridView() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: GridView.builder(
          scrollDirection: Axis.horizontal,
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 1,mainAxisSpacing: 10.0),
          itemCount: arrayImage.length * 2,
          itemBuilder: (context, index) {
            return Card(
              child: Image.asset(arrayImage[index % 3],fit: BoxFit.fill,),
            );
          }),
    );
  }
}
