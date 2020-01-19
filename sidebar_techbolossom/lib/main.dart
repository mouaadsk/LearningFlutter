import 'package:flutter/material.dart';
import 'package:sidebar_techbolossom/sidebarlayout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.amber,
      ),
      home: SideBarLayout(),
    );
  }
}
