import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class ChainAnimator extends AnimatedWidget {

  static final _opacityTween = Tween<double>(begin: 0.1, end: 1.0);
  static final _sizeTwen = Tween<double>(begin: 50.0, end: 200.0);


  ChainAnimator({Key key, Animation<double> animation})
      : super(key : key, listenable: animation);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Animation<double> animation = listenable;

    return Center(
      child: Opacity(opacity: _opacityTween.evaluate(animation),
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              height: _sizeTwen.evaluate(animation),
              width : _sizeTwen.evaluate(animation),
              child: FlatButton(onPressed: () {}, child: Text("Button"),
              color: Colors.green,),
      ),),);
  }

}