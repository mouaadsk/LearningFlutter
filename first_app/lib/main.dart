import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Home()
)
);

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
    appBar: AppBar(
      title : Text('This is the appBar'),
      centerTitle : true,
      backgroundColor : Colors.red[400],
    ),
    body : Center(
      child : FlatButton(
        onPressed: (){
          print('Button is clicked');
        },
        color: Colors.lime,
        child: Text('This is tkhrbi9a'),
      ),
        ),
    floatingActionButton : FloatingActionButton(
      child : 
        Icon(Icons.ac_unit),
      onPressed : ()=>{},
      backgroundColor : Colors.green,
    ),
    );
  }
}



