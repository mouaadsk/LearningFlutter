import 'package:flutter/material.dart';
import 'package:to_do_animation/my_animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flare Tutorial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyAnimation(),
    );
  }
}
