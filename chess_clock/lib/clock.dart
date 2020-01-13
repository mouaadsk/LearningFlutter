class Clock {
  int secondes, hours, minutes;
  Clock({this.secondes = 0});
  void addSeconde({int added = 1}) {
    secondes+=added;
  }
  void downSeconde({int decremented = 1}){
    secondes-=decremented;
  }
String toString(){
  return Duration(seconds: secondes).toString().split('.').first.padLeft(8, "0");
}
}
