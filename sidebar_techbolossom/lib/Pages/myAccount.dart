import 'package:flutter/material.dart';
import 'package:sidebar_techbolossom/navigation_blocks/navigation_block.dart';

class MyAccount extends StatelessWidget with NavigationStates{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'This is the My Account page',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
