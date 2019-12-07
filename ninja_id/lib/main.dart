import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int level = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            level+=1;
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.yellow[400],
      appBar: AppBar(
        title: Text('This Ninja Card App'),
        centerTitle: true,
        backgroundColor: Colors.amber,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('images/senku.png'),
                radius: 50.0,
              ),
            ),
            Divider(
              height: 60.0,
              color: Colors.cyan,
            ),
            Text(
              'Name',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Mouaad Sadik',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Flutter Knowledge Level',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Level $level',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.email,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'mouaadsadik@gmail.com',
                  style: TextStyle(
                    color: Colors.brown,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
