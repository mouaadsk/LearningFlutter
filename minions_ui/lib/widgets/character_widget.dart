import 'package:flutter/material.dart';
import 'package:minions_ui/models/caracters.dart';
import 'package:minions_ui/screens/caracter_detail_screen.dart';
import 'package:minions_ui/styles.dart';

class Caracter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 350),
              pageBuilder: (context, _, __) => CaracterDetailScreen(
                character: characters[0],
              ),
            ));
      },
      child: Stack(
        children: <Widget>[
          Hero(
            tag: 'background-${characters[0].name}',
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: CharacterCardBackgroundClipper(),
                child: Container(
                  height: screenHeight * 0.6,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      end: Alignment.bottomLeft,
                      begin: Alignment.topRight,
                      colors: characters[0].colors,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.0, -0.5),
            child: Image.asset(
              characters[0].imagePath,
              height: screenHeight * 0.55,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.10, bottom: screenHeight * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  characters[0].name,
                  style: AppTheme.heading,
                ),
                Text(
                  'Tap to read more',
                  style: AppTheme.subHeading,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CharacterCardBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clippedPath = Path();
    double curveDistance = 40;

    clippedPath.moveTo(0, size.height * 0.4);
    clippedPath.lineTo(0, size.height - curveDistance);
    clippedPath.quadraticBezierTo(
        1, size.height - 1, 0 + curveDistance, size.height);
    clippedPath.lineTo(size.width - curveDistance, size.height);
    clippedPath.quadraticBezierTo(size.width + 1, size.height - 1, size.width,
        size.height - curveDistance);
    clippedPath.lineTo(size.width, 0 + curveDistance);
    clippedPath.quadraticBezierTo(size.width - 1, 0,
        size.width - curveDistance - 5, 0 + curveDistance / 3);
    clippedPath.lineTo(curveDistance, size.height * 0.29);
    clippedPath.quadraticBezierTo(
        1, (size.height * 0.30) + 10, 0, size.height * 0.4);
    return clippedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
