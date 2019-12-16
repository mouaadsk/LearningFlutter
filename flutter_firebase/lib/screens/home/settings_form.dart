import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/loading_page.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:flutter_firebase/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  String _currentName, _currentSugars;
  int _currentStrength;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.userId).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update Your Brew Infos',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  TextFormField(
                    initialValue: userData.name ?? '',
                    validator: (value) =>
                        value.isEmpty ? 'Please enter a name' : null,
                    decoration: inputFormStyle.copyWith(hintText: 'Brew Name'),
                    onChanged: (value) {
                      setState(() {
                        this._currentName = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  DropdownButtonFormField(
                    decoration: inputFormStyle,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _currentSugars = value;
                      });
                    },
                  ),
                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    min: 100,
                    max: 900,
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    divisions: 8,
                    onChanged: (value) {
                      setState(() {
                        _currentStrength = value.round();
                      });
                    },
                  ),
                  RaisedButton(
                    color: Colors.amberAccent,
                    child: Text('Update Your Brew'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.userId).updateUserDate(
                            _currentSugars ?? userData.sugars,
                            _currentName ?? userData.name,
                            _currentStrength ?? userData.strength);
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
          } else {
            return LoadingPage();
          }
        });
  }
}
