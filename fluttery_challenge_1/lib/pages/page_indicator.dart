import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttery_challenge_1/pages/carousel_page.dart';

class PageIndicator extends StatelessWidget {
  final PageIndicatorViewModel viewModel;
  PageIndicator({this.viewModel});

  @override
  Widget build(BuildContext context) {
    List<PageBubble> bubbles = [];
    for (var i = 0; i < viewModel.pages.length; ++i) {
      final page = viewModel.pages[i];
      var activePercent;
      if (i == viewModel.activeIndex) {
        activePercent = 1.0 - viewModel.slidePercent;
      } else if (i == viewModel.activeIndex - 1 &&
          viewModel.slideDirection == SlideDirection.LeftToRight) {
        activePercent = viewModel.slidePercent;
      } else if (i == viewModel.activeIndex + 1 &&
          viewModel.slideDirection == SlideDirection.RightToLeft) {
        activePercent = viewModel.slidePercent;
      } else {
        activePercent = 0.0;
      }
      bubbles.add(PageBubble(
        bubbleViewModel: PageBubbleViewModel(
          color: Colors.red,
          iconPath: page.icon,
          isHollow: (i > viewModel.activeIndex) ||
              (viewModel.slideDirection == SlideDirection.LeftToRight &&
                  i == viewModel.activeIndex),
          activePercent: activePercent,
        ),
      ));
    }
    //TODO : base translation and translation of the bubbles in the bottom of the page

    final bubbleWidth = 50.0;
    final baseTranslation = ((viewModel.pages.length * bubbleWidth) / 2) - (bubbleWidth/2)  ;
    double translation = baseTranslation - ((viewModel.activeIndex) * bubbleWidth);
    if(viewModel.slideDirection == SlideDirection.LeftToRight){
      translation += bubbleWidth * viewModel.slidePercent;
    }
    else if(viewModel.slideDirection == SlideDirection.RightToLeft){
      translation -= bubbleWidth * viewModel.slidePercent;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Transform(
          transform: Matrix4.translationValues(translation, 0.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bubbles,
          ),
        ),
      ],
    );
  }
}

enum SlideDirection { LeftToRight, RightToLeft, None }

class PageIndicatorViewModel {
  final List<PageViewModel> pages;
  final int activeIndex;
  // here is the variable of the slide direction
  final SlideDirection slideDirection;
  final double slidePercent;
  PageIndicatorViewModel(
      {this.pages, this.activeIndex, this.slidePercent, this.slideDirection});
}

class PageBubbleViewModel {
  final String iconPath;
  final Color color;
  final bool isHollow;
  final double activePercent;

  PageBubbleViewModel(
      {this.iconPath, this.color, this.isHollow, this.activePercent});
}

class PageBubble extends StatelessWidget {
  final PageBubbleViewModel bubbleViewModel;
  PageBubble({this.bubbleViewModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 70.0,
      child: Center(
        child: Container(
          width: lerpDouble(20.0, 50.0, this.bubbleViewModel.activePercent),
          height: lerpDouble(20.0, 50.0, this.bubbleViewModel.activePercent),
          decoration: BoxDecoration(
              color: bubbleViewModel.isHollow
                  ? Color(0x88FFFFFF).withAlpha(
                      (0x88 * this.bubbleViewModel.activePercent).round())
                  : Color(0x88FFFFFF),
              shape: BoxShape.circle,
              border: Border.all(
                width: 3.0,
                color: bubbleViewModel.isHollow
                    ? Color(0x88FFFFFF).withAlpha(
                        (0x88 * (1 - this.bubbleViewModel.activePercent))
                            .round())
                    : Colors.transparent,
              )),
          child: Opacity(
            opacity: bubbleViewModel.activePercent,
            child: Image.asset(
              this.bubbleViewModel.iconPath,
              color: this.bubbleViewModel.color,
            ),
          ),
        ),
      ),
    );
  }
}
