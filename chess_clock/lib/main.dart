import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:chess_clock/clock.dart';
import 'package:chess_clock/onOffChess.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:chess_clock/enums.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
  ChessSwitch chessSwitch;
  AudioPlayer advancedPlayer = AudioPlayer();
  AudioCache audioCache;
  int _secondesPicker, _minutesPicker, _houresPicker;
  List<Clock> timers = [Clock(), Clock(), Clock()];
  int activeTimer = 2, incrementSecondes;
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        timers[activeTimer].downSeconde();
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
                      setState(() {
                        activeTimer = 1;
                        audioCache.play('sounds/tap_1.mp3');
                        timers[0].addSeconde(added: incrementSecondes);
                      });
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
                      setState(() {
                        activeTimer = 0;
                        audioCache.play('sounds/tap_1.mp3');
                        timers[1].addSeconde(added: incrementSecondes);
                      });
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
              Align(
                alignment: Alignment.center,
                child: IconButton(
                    icon: Icon(FontAwesomeIcons.slidersH),
                    iconSize: screenWidth * 0.15,
                    color: Colors.grey,
                    onPressed: () => showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          GlobalKey _formkey = GlobalKey<FormState>();
                          Map<String, dynamic> _labels = {
                            'houres': 'HH',
                            'houresClicked': false,
                            'minutes': 'MM',
                            'minutesClicked': false,
                            'secondesClicked': false,
                            'secondes': 'SS',
                          };
                          List<TextEditingController> _inputControllers = [
                            TextEditingController(),
                            TextEditingController(),
                            TextEditingController()
                          ];
                          _inputControllers[0].addListener(() {
                            if (_inputControllers[0].text.isEmpty ||
                                _inputControllers[0].text == null) {
                              _labels['houresClicked'] = false;
                            } else {
                              _houresPicker =
                                  int.parse(_inputControllers[0].text);
                              _labels['houresClicked'] = true;
                            }
                          });
                          _inputControllers[1].addListener(() {
                            if (_inputControllers[1].text.isEmpty ||
                                _inputControllers[1].text == null) {
                              _labels['minutesClicked'] = false;
                            } else {
                              _minutesPicker =
                                  int.parse(_inputControllers[1].text);
                              _labels['minutesClicked'] = true;
                            }
                          });
                          _inputControllers[2].addListener(() {
                            if (_inputControllers[2].text.isEmpty ||
                                _inputControllers[2].text == null) {
                              _labels['secondesClicked'] = false;
                            } else {
                              _secondesPicker =
                                  int.parse(_inputControllers[2].text);
                              _labels['secondesClicked'] = true;
                            }
                          });
                          return ChangeNotifierProvider(
                            create: (context) => ChessSwitch(),
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  title: Text('Settings'),
                                  content: SingleChildScrollView(
                                    child: Form(
                                      key: _formkey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Wrap(
                                            children: <Widget>[
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 10.0),
                                                width: screenWidth * 0.15,
                                                child: TextFormField(
                                                  controller:
                                                      _inputControllers[0],
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              screenWidth *
                                                                  0.05),
                                                    ),
                                                    focusColor: Colors.amber,
                                                    labelText:
                                                        _labels['houresClicked']
                                                            ? _labels['houres']
                                                            : null,
                                                    alignLabelWithHint: true,
                                                    hintText: _labels['houres'],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth * 0.02,
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 10.0),
                                                width: screenWidth * 0.15,
                                                child: TextFormField(
                                                  controller:
                                                      _inputControllers[1],
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              screenWidth *
                                                                  0.05),
                                                    ),
                                                    focusColor: Colors.amber,
                                                    labelText: _labels[
                                                            'minutesClicked']
                                                        ? _labels['minutes']
                                                        : null,
                                                    alignLabelWithHint: true,
                                                    hintText:
                                                        _labels['minutes'],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth * 0.02,
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 10.0),
                                                width: screenWidth * 0.15,
                                                child: TextFormField(
                                                  controller:
                                                      _inputControllers[2],
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              screenWidth *
                                                                  0.05),
                                                    ),
                                                    focusColor: Colors.amber,
                                                    labelText: _labels[
                                                            'secondesClicked']
                                                        ? _labels['secondes']
                                                        : null,
                                                    alignLabelWithHint: true,
                                                    hintText:
                                                        _labels['secondes'],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          OnOffChess(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Consumer<ChessSwitch>(
                                        builder: (context, chessSwitch, child) {
                                      return IconButton(
                                        icon:
                                            Icon(FontAwesomeIcons.gamepad),
                                        iconSize: screenWidth * 0.10,
                                        onPressed: () {
                                          timers[0] = Clock(
                                              secondes: (_houresPicker == null
                                                          ? 0
                                                          : _houresPicker) *
                                                      3600 +
                                                  (_minutesPicker == null
                                                          ? 0
                                                          : _minutesPicker) *
                                                      60 +
                                                  (_secondesPicker == null
                                                      ? 0
                                                      : _secondesPicker));
                                          timers[1] = Clock(
                                              secondes: (_houresPicker == null
                                                          ? 0
                                                          : _houresPicker) *
                                                      3600 +
                                                  (_minutesPicker == null
                                                          ? 0
                                                          : _minutesPicker) *
                                                      60 +
                                                  (_secondesPicker == null
                                                      ? 0
                                                      : _secondesPicker));
                                          incrementSecondes = chessSwitch.chessSwitchEnum == ChessSwitchEnum.left?0:chessSwitch.increment;
                                          Navigator.pop(context);
                                        },
                                      );
                                    }),
                                  ],
                                );
                              },
                            ),
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
