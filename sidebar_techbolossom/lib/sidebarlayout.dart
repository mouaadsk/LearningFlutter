import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebar_techbolossom/Pages/homePage.dart';
import 'package:sidebar_techbolossom/navigation_blocks/navigation_block.dart';
import 'package:sidebar_techbolossom/sidbar.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<NavigationBloc>(
      create: (context) => NavigationBloc(),
      child: Stack(
        children: <Widget>[
          BlocBuilder<NavigationBloc, NavigationStates>(
            builder: (context, navigationState){
              return navigationState as Widget;
            },
          ),
          SideBar(),
        ],
      ),
    ));
  }
}
