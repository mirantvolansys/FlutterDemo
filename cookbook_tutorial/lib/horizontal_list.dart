import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Horizontal List"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 0.0),
        height: 200.0,
        child:  ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            getContainer(context, 0),
            getContainer(context, 1),
            getContainer(context, 2),
            getContainer(context, 3),
            getContainer(context, 4),
            getContainer(context, 5),
          ],
        ),
      ),
    );
  }

  Widget getContainer(BuildContext context, int index) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      color: Color.fromARGB(255, 230, 230, 230),
      child: Container(
          margin: EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  (index % 2 == 0)
                      ? "images/nature1.png"
                      : "images/nature2.png",
                  fit: BoxFit.fill,
                  height: 165,
                ),
                Container(
                  margin: EdgeInsets.only(top: 2),
                  height: 15,
                  child: Text(
                    "The Beauty of Nature.",
                    maxLines: 1,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.indigo,
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

}
