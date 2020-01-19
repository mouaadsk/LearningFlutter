import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'This is the home page',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
