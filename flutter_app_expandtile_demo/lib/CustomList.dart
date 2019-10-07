import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Custom List"),
        ),

        body: ListView.separated(
          itemCount: 5,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context , int index) {
            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text("Test 1"),
                      ),

                      Padding(padding: EdgeInsets.only(left: 150)),

                      Text("Test 12"),
                    ],
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text("Test 2"),
                      ),

                      Padding(padding: EdgeInsets.only(left: 150)),

                      Text("Test 22"),
                    ],
                  ),
                ],
              ),

              onTap: () {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("$index")));
              },
            );
          },
        ),
      ),
    );
  }
}
