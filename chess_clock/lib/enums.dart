import 'package:flutter/foundation.dart';

enum ChessSwitchEnum{
  rightToLeft,leftToRight,left,right
}

class ChessSwitch with ChangeNotifier{
  ChessSwitchEnum chessSwitchEnum=ChessSwitchEnum.left;
  void changeChessSwitch(ChessSwitchEnum enumo){
    this.chessSwitchEnum = enumo;
    notifyListeners();
  } 
}