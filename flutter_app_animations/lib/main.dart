import 'package:flutter/material.dart';
import 'package:flutter_app_animations/anim/counter_anim.dart';

import 'anim/chain_animator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: "Animation in Flutter",),
    );
  }
}


class MyHomePage extends StatefulWidget {

  final String title;

  MyHomePage({Key key, this.title}) : super(key : key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(vsync: this,
    duration: const Duration(milliseconds: 1800));

    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
//    ..addListener(() {
//      setState(() {
////        debugPrint("${animation.value}");
//      });
//    });
    
    animation.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        controller.reverse();
      } else if(status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: ChainAnimator(animation: animation)
    );


//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Animation"),
//      ),
//
//      body: CounterAnimator(),
////      Center(
////        child: Text("Hello world!",
////          style: TextStyle(
////            fontSize: 20.0 * animation.value,
////          ),),
////      ),
//    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();

  }
}

