class Clock {
  int secondes, hours, minutes;
  Clock({this.secondes = 0});
  void addSeconde() {
    secondes++;
  }
  void downSeconde(){
    secondes--;
  }
String toString(){
  return Duration(seconds: secondes).toString().split('.').first.padLeft(8, "0");
}
}
