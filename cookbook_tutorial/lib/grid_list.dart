import 'package:flutter/material.dart';

class GridList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grid List"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, "Grid List Visited");
            }
        ),
      ),
      body: GridView.count(
          crossAxisCount: 3,
          children: List.generate(100, (index) {
            return Card(
              child: GridTile(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset(
                      (index % 2 == 0) ? "images/nature1.png" : "images/nature2.png",
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                    //Icon(Icons.satellite),
                    Container(
                      height: 4,
                    ),
                    Text(
                      "Item $index",
                      style: Theme.of(context).textTheme.subhead,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ),
            );
          }),
      ),
    );
  }

  // Pop from content
  Widget getBackButton({context: BuildContext}) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          Navigator.pop(context, "Grid List Visited");
        },
        child: Text("Go Back!"),
      ),
    );
  }

}
