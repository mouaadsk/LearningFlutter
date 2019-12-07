import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map infos = {};
  @override
  Widget build(BuildContext context) {
    infos = infos.isNotEmpty ? infos : ModalRoute.of(context).settings.arguments;
    String bgImage = (infos["isDaytime"] == true ? "assets/images/day.png" : "assets/images/night.png");
    Color bgCOlor = (infos['isDaytime'] ? Colors.blue[400] : Colors.indigo[700]);

    return Scaffold(
      backgroundColor: bgCOlor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0 ),
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () async{
                    dynamic chosen = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      infos = chosen;
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                    ),
                  label: Text(
                    'Choose your location',
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                    ),
                ),
                SizedBox(height: 50.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      infos['location'],
                      style : TextStyle(
                        color : Colors.red,
                        fontSize: 20.0, 
                        ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0,),
                Text(infos['time'],
                  style: TextStyle(
                    fontSize: 60.0,
                    color: Colors.red,
                    ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}