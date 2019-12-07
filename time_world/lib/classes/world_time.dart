import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime {
  // the location of the time
  String location;
  String time; // the time in that location
  String flag ; // the flag of the location country 
  String url ; // the string the we add to the api to get the location time
  bool isDaytime ; // true or false depending of day of ight time 

  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async {
    try{
      Response time_json = await get('http://worldtimeapi.org/api/timezone/$url');
    Map time_map = jsonDecode(time_json.body);
    // print(time);

    // get properties from time
    String dateTime = time_map['datetime'], offset = time_map['utc_offset'].substring(1,3);

    // creating dateTime 

    DateTime now = DateTime.parse(dateTime).add(Duration(hours: int.parse(offset)));

    isDaytime = now.hour > 6 && now.hour < 19 ? true : false ;

    this.time = DateFormat.jm().format(now);

    }
    catch(e){
      print('Caught Error : $e');
    }
    
  }


}
