import 'package:flutter/material.dart';
import 'package:time_world/classes/world_time.dart';


class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Berlin', flag: 'germany.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  void updateTime(index) async {
    WorldTime newTime = WorldTime(flag: locations[index].flag,url: locations[index].url,location: locations[index].location);
    await newTime.getTime();
    Navigator.pop(context, {
      'flag' : newTime.flag,
      'location' : newTime.location,
      'url' : newTime.url,
      'time' : newTime.time,
      'isDaytime' : newTime.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.amberAccent,
          title: Text('Choose Your Location'),
          elevation: 0.0,
        ),
        body: ListView.builder(
          itemCount: 8,
          itemBuilder: (context,index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 10.0),
              child: Card(
                child: ListTile(
                  onTap: (){
                    updateTime(index);
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/${locations[index].flag}'),
                  ),
                ),
              ),
            );
          },
        ),
      );
  }
}