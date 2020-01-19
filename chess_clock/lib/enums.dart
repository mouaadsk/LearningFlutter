import 'package:flutter/foundation.dart';

enum ChessSwitchEnum{
  rightToLeft,leftToRight,left,right
}

class ChessSwitch with ChangeNotifier{
  int increment = 0;
  ChessSwitchEnum chessSwitchEnum=ChessSwitchEnum.left;
  void changeChessSwitch(ChessSwitchEnum enumo){
    this.chessSwitchEnum = enumo;
    notifyListeners();
  }
  void changeIncrement(int newIncrement){
    this.increment = newIncrement;
    notifyListeners();
  } 
}