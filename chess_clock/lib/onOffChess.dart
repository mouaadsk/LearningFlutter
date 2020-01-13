import 'package:flutter/material.dart';
import 'package:chess_clock/enums.dart';
import 'package:provider/provider.dart';

class onOffChess extends StatefulWidget {
  
  @override
  _onOffChessState createState() => _onOffChessState();
}

class _onOffChessState extends State<onOffChess>
    with SingleTickerProviderStateMixin {
    ChessSwitch chessSwitch = ChessSwitch(),providerChessSwitch;
  void toggleSwitch() {
    if (chessSwitch.chessSwitchEnum == ChessSwitchEnum.left) {
      this._chessSwitchController.forward();
    } else if (chessSwitch.chessSwitchEnum == ChessSwitchEnum.right) {
      this._chessSwitchController.reverse();
    }
  }

  List<Image> imagesAssets = [
    Image.asset('assets/images/black king.png'),
    Image.asset('assets/images/white king.png')
  ];
  Image currentImage;
  AnimationController _chessSwitchController;
  Animation _animation;
  @override
  void initState() {
    super.initState();
    this._chessSwitchController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_chessSwitchController);
    _animation.addListener(() {
      setState(() {
        if (this._animation.value > 0.5 &&
            chessSwitch.chessSwitchEnum == ChessSwitchEnum.leftToRight) {
          this.currentImage = imagesAssets[1];
        } else if (this._animation.value < 0.5 &&
            chessSwitch.chessSwitchEnum == ChessSwitchEnum.rightToLeft) {
          this.currentImage = imagesAssets[0];
        }
      });
    });
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        chessSwitch.changeChessSwitch(ChessSwitchEnum.right);
      else if (status == AnimationStatus.dismissed)
        chessSwitch.changeChessSwitch(ChessSwitchEnum.left);
      else if (status == AnimationStatus.forward)
        chessSwitch.changeChessSwitch(ChessSwitchEnum.leftToRight);
      else
        chessSwitch.changeChessSwitch(ChessSwitchEnum.rightToLeft);
    });
    this.currentImage = imagesAssets[0];
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    providerChessSwitch = Provider.of<ChessSwitch>(context);
    return Container(
      width: screenWidth * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(screenWidth * 0.1 * this._animation.value, 0),
            child: Container(
              color: Colors.amber,
              child: IconButton(
                icon: this.currentImage,
                onPressed: () {
                  setState(() {
                    toggleSwitch();
                    providerChessSwitch = this.chessSwitch;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
