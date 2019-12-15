import 'package:flutter/material.dart';
import 'package:flutter_firebase/shared/constants.dart';

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
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Update Your Brew Infos',
            style: TextStyle(fontSize: 18.0),
          ),
          TextFormField(
            validator: (value) => value.isEmpty ? 'Please enter a name' : null,
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
            value: _currentSugars ?? '0',
            items: sugars.map((sugar) {
              return DropdownMenuItem(
                value: sugar,
                child: Text('$sugar sugars'),
              );
            }).toList(),
            onChanged: (value){
              setState(() {
                _currentSugars = value;
              });
            },
          ),
          Slider(
            value: (_currentStrength ?? 100).toDouble(),
            min: 100,
            max: 900,
            activeColor: Colors.brown[_currentStrength ?? 100],
            inactiveColor: Colors.brown[_currentStrength ?? 100],
            divisions: 8,
            onChanged: (value){
              setState(() {
                _currentStrength = value.round();
              });
            },
          ),
          RaisedButton(
            color: Colors.amberAccent,
            child: Text('Update Your Brew'),
            onPressed: () async {
              print(_currentName);
              print(_currentStrength);
              print(_currentSugars);
            },
          )
        ],
      ),
    );
  }
}
