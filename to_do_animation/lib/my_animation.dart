import 'package:flutter/material.dart';

class MyAnimation extends StatefulWidget {
  @override
  _MyAnimationState createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation>
    with TickerProviderStateMixin {
  Animation myAnimation;
  AnimationController myAnimationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myAnimationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..addListener(() {
        print('myAnimation.Value ${myAnimation.value}');
        setState(() {});
      });
    myAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(myAnimationController);
    myAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Transform(
        transform: Matrix4.,
        child: Container(
          width: 200 * myAnimation.value,
          height: 200 * myAnimation.value,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0 * myAnimation.value),
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
