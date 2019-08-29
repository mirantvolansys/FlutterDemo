import 'package:flutter/material.dart';

class CounterAnimator extends StatefulWidget {
  @override
  _CounterAnimatorState createState() => _CounterAnimatorState();
}

class _CounterAnimatorState extends State<CounterAnimator> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this,
    duration: Duration(seconds: 3));

    animation = Tween(begin: 0.0 , end: 3.0).animate(_controller);
    animation.addListener(() {
      this.setState(() {
        debugPrint("Animate Tween ${animation.value}");
      });
    });

//    animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.addListener(() {
      this.setState(() {
        _counter++;
        debugPrint("Print $_counter");
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: new Text(_controller.isAnimating ? (_counter).toStringAsFixed(2) : "Let's Begin",
        style: TextStyle(
          fontSize: 24.0 * animation.value + 16.0,
        ),),
      ),

      onTap: () {
        _controller.forward(from: 0.0);
      },

    );
  }
}
