import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttery_challenge_1/pages/carousel_page.dart';
import 'package:fluttery_challenge_1/pages/page_dragger.dart';
import 'package:fluttery_challenge_1/pages/page_indicator.dart';
import 'package:fluttery_challenge_1/pages/page_reveal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin{
  // Paaages 

  List<PageViewModel> pages = [
    PageViewModel(
    body: 'This is the body of the carousel',
    color: Colors.amber,
    title: 'Hotels',
    imagePath: 'assets/images/hotels.png',
    icon : 'assets/images/wallet.png'
    ),
    PageViewModel(
    body: 'Banks are used to hold your money in a safe place',
    color: Colors.redAccent,
    title: 'Banks',
    imagePath: 'assets/images/banks.png',
    icon : 'assets/images/wallet.png'
    ),PageViewModel(
    body: 'The stores are for shopping and buying stuffs',
    color: Colors.blue,
    title: 'Stores',
    imagePath: 'assets/images/stores.png',
    icon : 'assets/images/key.png'
    ),
  ];

  //////////
  StreamController<SlideUpdate> streamController;
  AnimetedPageDragger animatedPageDragger;
  int activeIndex = 0;
  int nextPageIndex = 1;
  SlideDirection slideDirection = SlideDirection.None;
  double slidePercent = 0.0;
  _MyAppState(){
    streamController = StreamController<SlideUpdate>();

    streamController.stream.listen((SlideUpdate event){
      setState(() {
        if(event.updateDrag == UpdateDrag.dragging){
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
          if(slideDirection == SlideDirection.LeftToRight){
            nextPageIndex = activeIndex -1;
          }
          else if(slideDirection == SlideDirection.RightToLeft){
            nextPageIndex = activeIndex  +1;

          }
          else {
            nextPageIndex = activeIndex;
          }
          nextPageIndex.clamp(0, pages.length - 1);
          }
        else if(event.updateDrag == UpdateDrag.doneDragging) {
          if(slidePercent > 0.5){
            animatedPageDragger = AnimetedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.Open,
              vsync: this,
              streamController: streamController,
              slidePercent: slidePercent,
            );

          }else {
              animatedPageDragger = AnimetedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.Close,
              vsync: this,
              streamController: streamController,
              slidePercent: slidePercent,
            );
            nextPageIndex = activeIndex;
          }
          animatedPageDragger.run();
          
        }else if(event.updateDrag == UpdateDrag.animating){
          slideDirection = event.direction;
          slidePercent = event.slidePercent; 
        }else if(event.updateDrag == UpdateDrag.doneAnimating){
          activeIndex = nextPageIndex;
          slideDirection = SlideDirection.None;
          slidePercent = 0.0;

          animatedPageDragger.dispos();
        }

        
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.red,
        body: Stack(
          children: <Widget>[
            CarouselPage(pageView: pages[activeIndex],percentVisible: 1.0,),
            PageReveal(
              child: CarouselPage(pageView: pages[nextPageIndex],
              percentVisible: slidePercent,)
              ,revealPercentage: slidePercent,
              ),
              PageIndicator(
                viewModel: PageIndicatorViewModel(
                  slideDirection: slideDirection,
                  pages: pages,
                  slidePercent: slidePercent,
                  activeIndex: activeIndex,
                ),
              ),
              PageDragger(slideUpdateStream: streamController,canDragLeftToRight: activeIndex > 0,canDragRightToLeft: activeIndex < pages.length - 1,),
          ],
        ),
      ),
    );
  }
}



