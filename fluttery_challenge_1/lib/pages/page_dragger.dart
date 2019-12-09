import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttery_challenge_1/pages/page_indicator.dart';

class PageDragger extends StatefulWidget {
  final StreamController<SlideUpdate> slideUpdateStream;
  bool canDragRightToLeft, canDragLeftToRight;
  PageDragger(
      {this.slideUpdateStream,
      this.canDragLeftToRight,
      this.canDragRightToLeft});

  @override
  _PageDraggerState createState() => _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {
  // TODO : this variable contains who much must the user drag to aplly full transition between slides
  static double fulleTransition = 300.0;

  Offset dragStart;
  SlideDirection slideDirection;
  double slidePercent = 0.0;

  onDragStart(DragStartDetails details) {
    dragStart = details.globalPosition;
  }

  onDragUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      final newPosition = details.globalPosition;
      final dx = dragStart.dx - newPosition.dx;
      if (dx > 0.0 && this.widget.canDragRightToLeft) {
        slideDirection = SlideDirection.RightToLeft;
      } else if (dx < 0.0 && this.widget.canDragLeftToRight) {
        slideDirection = SlideDirection.LeftToRight;
      } else {
        slideDirection = SlideDirection.None;
      }
      if (slideDirection != SlideDirection.None) {
        slidePercent = (dx / fulleTransition).abs().clamp(0.0, 1.0);
      } else {
        slidePercent = 0.0;
      }
      this.widget.slideUpdateStream.add(SlideUpdate(
          updateDrag: UpdateDrag.dragging,
          slidePercent: slidePercent,
          direction: slideDirection));
      print('dragging $slideDirection at $slidePercent%');
    }
  }

  onDragEnd(DragEndDetails details) {
    this.widget.slideUpdateStream.add(SlideUpdate(
        updateDrag: UpdateDrag.doneDragging,
        slidePercent: 0.0,
        direction: SlideDirection.None));

    dragStart = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
    );
  }
}

class SlideUpdate {
  final updateDrag;
  final direction;
  final slidePercent;

  SlideUpdate({this.slidePercent, this.direction, this.updateDrag});
}

enum UpdateDrag { dragging, doneDragging, animating, doneAnimating }

class AnimetedPageDragger {
  static const PERCENT_PER_MILLISECOND = 0.005;

  final SlideDirection slideDirection;
  final TransitionGoal transitionGoal;
  double slidePercent;
  TickerProvider vsync;
  StreamController<SlideUpdate> streamController;

  AnimationController completionAnimatedController;
  AnimetedPageDragger(
      {this.slideDirection,
      this.transitionGoal,
      this.slidePercent,
      this.streamController,
      this.vsync}) {
    var endSlidePercent;
    final startSlidePercent = slidePercent;
    var duration;
    if (transitionGoal == TransitionGoal.Open) {
      endSlidePercent = 1.0;
      final slideRemaining = 1.0 - slidePercent;
      duration = Duration(
          milliseconds: (slideRemaining / PERCENT_PER_MILLISECOND).round());
    } else {
      endSlidePercent = 0.0;
      duration = Duration(
          milliseconds: (slidePercent / PERCENT_PER_MILLISECOND).round());
    }
    completionAnimatedController = AnimationController(
      duration: duration,
      vsync: vsync,
    )
      ..addListener(() {
        slidePercent = lerpDouble(startSlidePercent, endSlidePercent,
            completionAnimatedController.value);
        streamController.add(SlideUpdate(
          direction: slideDirection,
          slidePercent: slidePercent,
          updateDrag: UpdateDrag.animating,
        ));
      })
      ..addStatusListener((AnimationStatus status) {
        if(status == AnimationStatus.completed){
          streamController.add(
            SlideUpdate(
              slidePercent: slidePercent,
              direction: slideDirection,
              updateDrag: UpdateDrag.doneAnimating,
            )
          );
        }
      });
  }
  run (){
    completionAnimatedController.forward(from: 0.0);
  }
  dispos(){
    completionAnimatedController.dispose();
  }
}

enum TransitionGoal { Open, Close }
