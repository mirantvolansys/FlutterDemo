import 'package:flutter/material.dart';

class StackWithScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        Container(
          color: Colors.green,
          height: 10000,
          child: Image.asset(
            "assets/1.jpg",
            fit: BoxFit.fill,
          ),
        ),
        Container(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Container(
                height: 150,
                color: Colors.grey,
              ),

              Expanded(
                child: ListView.builder(
                    itemCount: 100, itemBuilder: (BuildContext context, int index) {
                  return Text("Mike");
                }),
              )
            ],
          ),
        ),
      ],
    );
  }
}
