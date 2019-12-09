import 'package:flutter/material.dart';

class CarouselPage extends StatefulWidget {
  final PageViewModel pageView;
  final double percentVisible;
  CarouselPage({this.pageView,this.percentVisible});
  @override
  _CarouselPageState createState() => _CarouselPageState();
  
}

class _CarouselPageState extends State<CarouselPage> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
          opacity: this.widget.percentVisible,
          child: Container(
                width: double.infinity,
                color: this.widget.pageView.color,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Transform(
                      transform: Matrix4.translationValues(0, 60 * (1.0 - this.widget.percentVisible), 0),
                        child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,25.0),
                        child: Image.asset(
                          this.widget.pageView.imagePath,
                          height: 200,
                          width: 200,
                        ),
                      ),
                    ),
                    Transform(
                        transform: Matrix4.translationValues(0, 35 * (1.0 - this.widget.percentVisible), 0),
                        child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,10.0),
                        child: Text(
                          this.widget.pageView.title,
                          style: TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    Transform(
                      transform: Matrix4.translationValues(0, 30 * (1.0 - this.widget.percentVisible), 0),
                      child: Text(
                        this.widget.pageView.body,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white70,
                        ),
                      ),
                    )
                  ],
                ),
              ),
    );
  }
}

class PageViewModel {
  final String title;
  final String body;
  final Color color;
  final String icon;
  final String imagePath;

  PageViewModel({this.body,this.color,this.icon,this.title,this.imagePath});


}