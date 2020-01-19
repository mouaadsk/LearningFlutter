import 'package:flutter/material.dart';
import 'package:sidebar_techbolossom/Pages/homePage.dart';
import 'package:sidebar_techbolossom/sidbar.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          HomePage(),
          SideBar(),
        ],
      ),
      
    );
  }
}