import 'package:flutter/material.dart';

class CustomScrollViewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                  "Sliver App bar",
              ),
              background: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                              image: AssetImage("images/nature1.png"),
                              fit: BoxFit.fill
                            ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                              Colors.grey.withOpacity(0.0),
                              Colors.black,
                            ],
                            stops: [
                              0.0,
                              1.0
                            ])),
                  )
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: Column(
                children: List<int>.generate(6, (index) => index)
                    .map((index) => Container(
                          height: 40,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          color: Colors.grey[300],
                          alignment: Alignment.center,
                          child: Text('$index item'),
                        ))
                    .toList()),
          )
        ],
      ),
    );
  }
}
