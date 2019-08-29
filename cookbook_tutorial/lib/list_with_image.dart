import 'package:flutter/material.dart';

class ListWithImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List with Image"),
      ),
      body: Container(
        child: ListView(
          children: cards,
        ),
      ),
    );
  }

  List get cards => List.generate(50, (i) => CustomCard(i)).toList();
}

class CustomCard extends StatelessWidget {

  final int index;
  CustomCard(this.index);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
            child: Image.asset(
              (index % 2) == 0 ? "images/nature1.png" : "images/nature2.png",
              fit: BoxFit.fill,
              height: 200,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4, top: 4, right: 4),
            child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(4),
                child: IconButton(
                  onPressed: () {
                    print("°°°°°°° LIKE °°°°°°°");
                  },
                  icon: Icon(Icons.thumb_up),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Text("Like", style: TextStyle(fontSize: 17.0)),
              ),
              Padding(
                padding: EdgeInsets.all(4),
                child: IconButton(
                  onPressed: () {
                    print("°°°°° COMMENT °°°°°°");
                  },
                  icon: Icon(Icons.comment),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Text("Comment", style: TextStyle(fontSize: 17.0)),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
