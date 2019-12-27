import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:minions_ui/models/caracters.dart';
import 'package:minions_ui/styles.dart';

class CaracterDetailScreen extends StatefulWidget {
  final Character character;

  const CaracterDetailScreen({this.character});

  @override
  _CaracterDetailScreenState createState() => _CaracterDetailScreenState();
}

class _CaracterDetailScreenState extends State<CaracterDetailScreen>
    with AfterLayoutMixin<CaracterDetailScreen> {
  double _expandedBottomSheet = 0;
  Map<String, double> expandingValues = {
    'filled': 0,
    'completeCollapsed': 0,
    'semiCollapsed': 0,
  };
  bool isCollapsed = false;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    if (expandingValues['filled'] == 0) {
      setState(() {
        expandingValues['completeCollapsed'] =
          -((screenHeight * 0.115).round().toDouble() +
              (screenHeight * 0.03).round().toDouble() +
              (screenWidth * 0.20).round().toDouble() +
              (screenWidth * 0.20).round().toDouble());
      expandingValues['semiCollapsed'] = expandingValues['completeCollapsed'] +
          (screenHeight * 0.10).round().toDouble();
      expandingValues['filled'] = 1;
      _expandedBottomSheet = expandingValues['completeCollapsed'];
      });
    }
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
                        setState(() {
                          _expandedBottomSheet =
                              expandingValues['completeCollapsed'];
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Hero(
                      tag: 'image-${widget.character.name}',
                      child: Image.asset(
                        widget.character.imagePath,
                        height: screenHeight * 0.45,
                      ),
                    ),
                  ),
                  Hero(
                    tag: 'name-${widget.character.name}',
                    child: Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: screenWidth * 0.06),
                        child: Text(
                          widget.character.name,
                          style: AppTheme.heading,
                        ),
                      ),
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
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.decelerate,
              bottom: _expandedBottomSheet,
              left: 0.0,
              right: 0.0,
              child: InkWell(
                onTap: (){
                  setState(() {
                    _expandedBottomSheet = isCollapsed == true  ? 0 : expandingValues['semiCollapsed'];
                    isCollapsed =! isCollapsed;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenHeight * 0.05),
                      topRight: Radius.circular(screenHeight * 0.05),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        height: (screenHeight * 0.10).round().toDouble(),
                        padding:
                            EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                        child: Text(
                          'Clips',
                          style:
                              AppTheme.subHeading.copyWith(color: Colors.black),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: _clipWidgets(screenHeight, screenWidth),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _clipWidgets(
    double screenHeight,
    double screenWidth,
  ) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          (screenWidth * 0.05).round().toDouble(),
          0.0,
          (screenWidth * 0.03).round().toDouble(),
          (screenHeight * 0.03).round().toDouble()),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              _roundedContainer(Colors.black, screenWidth),
              SizedBox(
                height: (screenHeight * 0.015).round().toDouble(),
              ),
              _roundedContainer(Colors.amber, screenWidth),
            ],
          ),
          SizedBox(
            width: (screenWidth * 0.02).round().toDouble(),
          ),
          Column(
            children: <Widget>[
              _roundedContainer(Colors.orange, screenWidth),
              SizedBox(
                height: (screenHeight * 0.015).round().toDouble(),
              ),
              _roundedContainer(Colors.blue, screenWidth),
            ],
          ),
          SizedBox(
            width: (screenWidth * 0.02).round().toDouble(),
          ),
          Column(
            children: <Widget>[
              _roundedContainer(Colors.deepPurple, screenWidth),
              SizedBox(
                height: (screenHeight * 0.015).round().toDouble(),
              ),
              _roundedContainer(Colors.grey, screenWidth),
            ],
          ),
          SizedBox(
            width: (screenWidth * 0.02).round().toDouble(),
          ),
          Column(
            children: <Widget>[
              _roundedContainer(Colors.cyan, screenWidth),
              SizedBox(
                height: (screenHeight * 0.015).round().toDouble(),
              ),
              _roundedContainer(Colors.brown, screenWidth),
            ],
          ),
          SizedBox(
            width: (screenWidth * 0.02).round().toDouble(),
          ),
          Column(
            children: <Widget>[
              _roundedContainer(Colors.indigo, screenWidth),
              SizedBox(
                height: (screenHeight * 0.015).round().toDouble(),
              ),
              _roundedContainer(Colors.pink, screenWidth),
            ],
          ),
          SizedBox(
            width: (screenWidth * 0.02).round().toDouble(),
          ),
        ],
      ),
    );
  }

  Widget _roundedContainer(Color color, double screenWidth) {
    return Container(
      width: (screenWidth * 0.20).round().toDouble(),
      height: (screenWidth * 0.20).round().toDouble(),
      decoration: BoxDecoration(
        color: color,
        borderRadius:
            BorderRadius.circular((screenWidth * 0.05).round().toDouble()),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(
        const Duration(milliseconds: 200),
        () => setState(() {
          
              isCollapsed = !isCollapsed;
              _expandedBottomSheet = expandingValues['semiCollapsed'];
            }));
  }
}
