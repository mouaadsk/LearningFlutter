import 'dart:math';

import 'package:flutter/material.dart';
class PageReveal extends StatelessWidget {
  final double revealPercentage;
  final Widget child;
  PageReveal({this.child,this.revealPercentage});
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipper: CircleRevealCLipper(revealPercentage : revealPercentage),
      child: child,
    );

  }
}


class CircleRevealCLipper extends CustomClipper<Rect>{
  final double revealPercentage;
  CircleRevealCLipper({this.revealPercentage}); 

  @override
  Rect getClip(Size size) {
    // TODO: implement getClip
    final epicCenter = Offset(size.width / 2, size.height * 0.9);

    // Calculating the distance between the epic center to the top corners
    double theta = atan(epicCenter.dy / epicCenter.dx);
    final double distanceToConer = epicCenter.dy / sin(theta);

    final double radius = distanceToConer * revealPercentage;
    final double diametre = 2 * radius ;


    return Rect.fromLTWH(epicCenter.dx - radius, epicCenter.dy - radius, diametre, diametre);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }



}