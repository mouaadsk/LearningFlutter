import 'package:flutter/material.dart';

var inputFormStyle = InputDecoration(
  fillColor: Colors.amber[200],
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.amber[200], width: 1.0),
    borderRadius: BorderRadius.circular(30),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.amber, width: 3.0),
    borderRadius: BorderRadius.circular(30),
  ),
);
