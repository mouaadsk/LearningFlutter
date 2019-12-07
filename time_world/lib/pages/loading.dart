import 'package:flutter/material.dart';
import 'package:time_world/classes/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin{
  String currentTime = "Loading ...";

  WorldTime worldTime = WorldTime(flag: 'Morocco.png',url: 'Africa/Casablanca',location: 'Casablanca');
  void setWorldTime() async {
    await worldTime.getTime();
    setState(() {
      this.currentTime = worldTime.time;
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location' : worldTime.location, 
        'time' : worldTime.time,
        'flag' : worldTime.flag,
        'isDaytime' : worldTime.isDaytime,
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setWorldTime();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.redAccent,
          size: 50.0,
          controller: AnimationController(vsync: this,
            duration: Duration(milliseconds: 700),
            ),
        ),
      )
    );
  }
}
