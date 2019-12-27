import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:chess_clock/clock.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:numberpicker/numberpicker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChessClock(),
    );
  }
}

class ChessClock extends StatefulWidget {
  @override
  _ChessClockState createState() => _ChessClockState();
}

class _ChessClockState extends State<ChessClock> {
  AudioPlayer advancedPlayer = AudioPlayer();
  AudioCache audioCache;
  int _secondesPicker, _minutesPicker, _houresPicker;
  List<Clock> timers = [Clock(), Clock(), Clock()];
  int activeTimer = 2;
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        timers[activeTimer].addSeconde();
      });
    });
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  InkWell(
                    enableFeedback: false,
                    onTap: () {
                      activeTimer = 1;
                      audioCache.play('sounds/tap_1.mp3');
                    },
                    child: Container(
                      color: Colors.brown,
                      width: screenWidth,
                      height: screenHeight / 2,
                      child: Center(
                          child: Transform.rotate(
                        angle: math.pi,
                        child: Text(
                          '${timers[0].toString()}',
                          style: TextStyle(
                            fontSize: screenWidth * 0.15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                    ),
                  ),
                  InkWell(
                    enableFeedback: false,
                    onTap: () {
                      activeTimer = 0;
                      audioCache.play('sounds/tap_1.mp3');
                    },
                    child: Container(
                      color: Colors.amber,
                      width: screenWidth,
                      height: screenHeight / 2,
                      child: Center(
                        child: Text(
                          '${timers[1].toString()}',
                          style: TextStyle(
                              fontSize: screenWidth * 0.15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: IconButton(
                    icon: Icon(Icons.settings),
                    iconSize: screenWidth * 0.20,
                    color: Colors.grey,
                    onPressed: () => showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          GlobalKey _formkey = GlobalKey<FormState>();
                          Map<String, dynamic> _labels = {
                            'hours': 'HH',
                            'hoursClick': false,
                            'minutes': 'MM',
                            'minutesClicked': false,
                            'secondesClicked': false,
                            'secondes': 'SS',
                          };
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                title: Text('Settings'),
                                content: SingleChildScrollView(
                                    child: Form(
                                  key: _formkey,
                                  child: Wrap(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 10.0),
                                        width: screenWidth * 0.15,
                                        child: TextFormField(
                                          onEditingComplete: () {
                                            setState(() {
                                              _labels['houresClicked'] = false;
                                            });
                                          },
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      screenWidth * 0.05),
                                            ),
                                            focusColor: Colors.amber,
                                            labelText: _labels['houresClicked']
                                                ? _labels['houres']
                                                : null,
                                            alignLabelWithHint: true,
                                            hintText: _labels['houres'],
                                          ),
                                          autovalidate: true,
                                          validator: (value){},
                                          onChanged: (value) {
                                            setState(() {
                                              _minutesPicker = int.parse(value);
                                              if (value.isNotEmpty &&
                                                  value != null) {
                                                _labels['houresClicked'] =
                                                    true;
                                              } else {
                                                _labels['houresClicked'] =
                                                    false;
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.02,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10.0),
                                        width: screenWidth * 0.15,
                                        child: TextFormField(
                                          onEditingComplete: () {
                                            setState(() {
                                              _labels['minutesClicked'] = false;
                                            });
                                          },
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      screenWidth * 0.05),
                                            ),
                                            focusColor: Colors.amber,
                                            labelText: _labels['minutesClicked']
                                                ? _labels['minutes']
                                                : null,
                                            alignLabelWithHint: true,
                                            hintText: _labels['minutes'],
                                          ),
                                          autovalidate: true,
                                          validator: (value) {
                                            
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              _minutesPicker = int.parse(value);
                                              if (value.isNotEmpty &&
                                                  value != null) {
                                                _labels['minutesClicked'] =
                                                    true;
                                              } else {
                                                _labels['minutesClicked'] =
                                                    false;
                                              }
                                              print(value);
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.02,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10.0),
                                        width: screenWidth * 0.15,
                                        child: TextFormField(
                                          onEditingComplete: () {
                                            setState(() {
                                              _labels['secondesClicked'] = false;
                                            });
                                          },
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      screenWidth * 0.05),
                                            ),
                                            focusColor: Colors.amber,
                                            labelText: _labels['secondesClicked']
                                                ? _labels['secondes']
                                                : null,
                                            alignLabelWithHint: true,
                                            hintText: _labels['secondes'],
                                          ),
                                          autovalidate: true,
                                          validator: (value) {
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              _minutesPicker = int.parse(value);
                                              if (value.isNotEmpty &&
                                                  value != null) {
                                                _labels['secondesClicked'] =
                                                    true;
                                              } else {
                                                _labels['secondesClicked'] =
                                                    false;
                                              }
                                              print(value);
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                                actions: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.swap_horizontal_circle),
                                    iconSize: screenWidth * 0.10,
                                    onPressed: () {},
                                  ),
                                ],
                              );
                            },
                          );
                        })),
              )
            ],
          ),
        ),
      ),
    );
  }
}