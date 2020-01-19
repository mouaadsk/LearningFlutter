import 'package:flutter/material.dart';
import 'package:chess_clock/enums.dart';
import 'package:provider/provider.dart';

class OnOffChess extends StatefulWidget {
  @override
  _OnOffChessState createState() => _OnOffChessState();
}

class _OnOffChessState extends State<OnOffChess>
    with SingleTickerProviderStateMixin {
  ChessSwitch providerChessSwitch;
  void toggleSwitch() {
    if (providerChessSwitch.chessSwitchEnum == ChessSwitchEnum.left) {
      this._chessSwitchController.forward();
    } else if (providerChessSwitch.chessSwitchEnum == ChessSwitchEnum.right) {
      this._chessSwitchController.reverse();
    }
  }

  List<Image> imagesAssets = [
    Image.asset(
      'assets/images/black king.png',fit: BoxFit.cover,),
    Image.asset('assets/images/white king.png',fit: BoxFit.cover,)
  ];
  Image currentImage;
  AnimationController _chessSwitchController;
  Animation _animation;
  TextEditingController incrementController = TextEditingController();
  int increment = 0;
  @override
  void initState() {
    super.initState();
    this._chessSwitchController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_chessSwitchController);
    _animation.addListener(() {
      setState(() {
        if (this._animation.value > 0.5 &&
            providerChessSwitch.chessSwitchEnum ==
                ChessSwitchEnum.leftToRight) {
          this.currentImage = imagesAssets[1];
        } else if (this._animation.value < 0.5 &&
            providerChessSwitch.chessSwitchEnum ==
                ChessSwitchEnum.rightToLeft) {
          this.currentImage = imagesAssets[0];
        }
      });
    });
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        providerChessSwitch.changeChessSwitch(ChessSwitchEnum.right);
      } else if (status == AnimationStatus.dismissed) {
        providerChessSwitch.changeChessSwitch(ChessSwitchEnum.left);
      } else if (status == AnimationStatus.forward)
        providerChessSwitch.changeChessSwitch(ChessSwitchEnum.leftToRight);
      else
        providerChessSwitch.changeChessSwitch(ChessSwitchEnum.rightToLeft);
    });
    this.currentImage = imagesAssets[0];
    incrementController.addListener(() {
      if (incrementController.text.isEmpty ||
          incrementController.text == null) {
      } else {
        providerChessSwitch
            .changeIncrement(int.parse(incrementController.text));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    providerChessSwitch = Provider.of<ChessSwitch>(context);
    return providerChessSwitch.chessSwitchEnum == ChessSwitchEnum.left ?  Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: screenWidth * 0.15,
            alignment: Alignment.centerLeft,
            child: Transform.translate(
              offset: Offset(screenWidth * 0.05 * this._animation.value, 0),
              child: Container(
                width: screenWidth * 0.1,
                child: IconButton(
                  enableFeedback: false,
                  icon: this.currentImage,
                  onPressed: () {
                    setState(() {
                      toggleSwitch();
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ): Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: screenWidth * 0.15,
            alignment: Alignment.centerLeft,
            child: Transform.translate(
              offset: Offset(screenWidth * 0.05 * this._animation.value, 0),
              child: Container(
                width: screenWidth * 0.1,
                child: IconButton(
                  enableFeedback: false,
                  icon: this.currentImage,
                  onPressed: () {
                    setState(() {
                      toggleSwitch();
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: screenWidth * 0.40,
            child: TextFormField(
              controller: incrementController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                ),
                focusColor: Colors.amber,
                labelText: "Increment Secondes",
                alignLabelWithHint: true,
                hintText: 'Add Increment Secondes',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
