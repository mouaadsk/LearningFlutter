import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  int secondesPicker, minutesPicker, houresPicker;
  SettingsWidget({this.houresPicker,this.minutesPicker,this.secondesPicker});
  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    showDialog(
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
                                  BorderRadius.circular(screenWidth * 0.05),
                            ),
                            focusColor: Colors.amber,
                            labelText: _labels['houresClicked']
                                ? _labels['houres']
                                : null,
                            alignLabelWithHint: true,
                            hintText: _labels['houres'],
                          ),
                          autovalidate: true,
                          validator: (value) {},
                          onChanged: (value) {
                            setState(() {
                              this.widget.minutesPicker = int.parse(value);
                              if (value.isNotEmpty && value != null) {
                                _labels['houresClicked'] = true;
                              } else {
                                _labels['houresClicked'] = false;
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
                                  BorderRadius.circular(screenWidth * 0.05),
                            ),
                            focusColor: Colors.amber,
                            labelText: _labels['minutesClicked']
                                ? _labels['minutes']
                                : null,
                            alignLabelWithHint: true,
                            hintText: _labels['minutes'],
                          ),
                          autovalidate: true,
                          validator: (value) {},
                          onChanged: (value) {
                            setState(() {
                              this.widget.minutesPicker = int.parse(value);
                              if (value.isNotEmpty && value != null) {
                                _labels['minutesClicked'] = true;
                              } else {
                                _labels['minutesClicked'] = false;
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
                                  BorderRadius.circular(screenWidth * 0.05),
                            ),
                            focusColor: Colors.amber,
                            labelText: _labels['secondesClicked']
                                ? _labels['secondes']
                                : null,
                            alignLabelWithHint: true,
                            hintText: _labels['secondes'],
                          ),
                          autovalidate: true,
                          validator: (value) {},
                          onChanged: (value) {
                            setState(() {
                              this.widget.minutesPicker = int.parse(value);
                              if (value.isNotEmpty && value != null) {
                                _labels['secondesClicked'] = true;
                              } else {
                                _labels['secondesClicked'] = false;
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
        });
  }
}
