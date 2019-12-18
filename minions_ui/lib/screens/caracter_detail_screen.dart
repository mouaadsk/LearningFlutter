import 'package:flutter/material.dart';
import 'package:minions_ui/models/caracters.dart';
import 'package:minions_ui/styles.dart';
import 'package:minions_ui/widgets/character_widget.dart';

class CaracterDetailScreen extends StatefulWidget {
  final Character character;

  const CaracterDetailScreen({this.character});

  @override
  _CaracterDetailScreenState createState() => _CaracterDetailScreenState();
}

class _CaracterDetailScreenState extends State<CaracterDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: 'background-${widget.character.name}',
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    end: Alignment.bottomLeft,
                    begin: Alignment.topRight,
                    colors: widget.character.colors,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.03),
                    child: IconButton(
                      alignment: Alignment.center,
                      iconSize: screenWidth * 0.10,
                      icon: Icon(
                        Icons.close,
                      ),
                      color: Colors.white.withOpacity(0.80),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      widget.character.imagePath,
                      height: screenHeight * 0.45,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: screenWidth * 0.06),
                    child: Text(
                      widget.character.name,
                      style: AppTheme.heading,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.06, 8.0, screenWidth * 0.04, 32),
                    child: Text(
                      widget.character.description,
                      style: AppTheme.subHeading,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
