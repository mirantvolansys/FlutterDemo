import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
                height: 350,
                width: double.infinity,
                child: Container(
                  child: Image.asset(
                    "images/1.jpeg",
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                )),
            Expanded(
                child: Container(
              color: Colors.white,
            ))
          ],
        ),

        Column(
          children: <Widget>[
            Container(
              height: 64,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 44.0,
                    child: Center(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: 50,
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Icon(Icons.menu, color: Colors.white)),
                            ),
                          )),
                          Expanded(
                              child: Container(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 50,
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Icon(Icons.search, color: Colors.white)),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Text("Good Morning!",style: TextStyle(color: Colors.white,fontSize: 30.0,fontFamily: "Times New Roman")),

          ],
        ),
      ],
    );
  }
}
