import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sidebar_techbolossom/menuItem.dart';

import 'navigation_blocks/navigation_block.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  Duration _animationDuration = Duration(seconds: 1);
  AnimationController _animationController;
  StreamController<bool> isOpenStreamController;
  Stream<bool> isOpenStream;
  StreamSink<bool> isOpenSink;
  bool isOpen = true;
  void alterOpen() {
    final status = _animationController.status;
    final animationCompleted = status == AnimationStatus.completed;
    if (animationCompleted) {
      isOpenSink.add(false);
      _animationController.reverse();
    } else {
      isOpenSink.add(true);
      _animationController.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: _animationDuration, vsync: this);
    isOpenStreamController = PublishSubject<bool>();
    isOpenStream = isOpenStreamController.stream;
    isOpenSink = isOpenStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isOpenSink.close();
    isOpenStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<bool>(
        initialData: false,
        stream: isOpenStream,
        builder: (context, isSideBarOpenedAsync) {
          return AnimatedPositioned(
            duration: _animationDuration,
            top: 0,
            bottom: 0,
            left: isSideBarOpenedAsync.data ? 0 : -screenWidth + 35,
            right: isSideBarOpenedAsync.data ? 0 : screenWidth - 55,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Color(0xFF262AAA),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                        ),
                        ListTile(
                          title: Text(
                            'Mouaad Sadik',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'mouaadsadik@gmail.com',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                          ),
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.perm_identity,
                              color: Colors.grey,
                            ),
                            radius: 30,
                          ),
                          onTap: () {},
                        ),
                        Divider(
                          height: 60,
                          thickness: 5,
                          color: Colors.white,
                          indent: 16,
                          endIndent: 16,
                        ),
                        MenuItem(
                          title: 'Home',
                          icon: Icons.home,
                          onTap: (){
                            alterOpen();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);
                          },
                        ),
                        MenuItem(
                          title: 'My Account',
                          icon: Icons.person,
                          onTap: (){
                            alterOpen();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyAccountClickedEvent);
                          },
                        ),
                        MenuItem(
                          title: 'My Orders',
                          icon: Icons.shopping_basket,
                          onTap: (){
                            alterOpen();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyOrdersClickedEvent);
                          },
                        ),
                        MenuItem(
                          title: 'My WishList',
                          icon: Icons.card_giftcard,
                          onTap: (){},
                        ),
                        Divider(
                          height: 60,
                          thickness: 5,
                          color: Colors.white,
                          indent: 16,
                          endIndent: 16,
                        ),
                        MenuItem(
                          title: 'Settings',
                          icon: Icons.settings,
                          onTap: (){},
                        ),
                        MenuItem(
                          title: 'Log Out',
                          icon: Icons.exit_to_app,
                          onTap: (){},
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, -0.9),
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: 35,
                      height: 100,
                      color: Color(0xFF262AAA),
                      child: GestureDetector(
                        onTap: () {
                            alterOpen();
                        },
                        child: AnimatedIcon(
                          icon: AnimatedIcons.menu_close,
                          progress: _animationController.view,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class CustomMenuClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.transparent;
    final width = size.width;
    final height = size.height;
    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0,height * 0.03,  width * 0.10,height * 0.1 );
    path.quadraticBezierTo(width -1, height * 0.35,width , height / 2 );
    path.quadraticBezierTo(width  + 1 , height * 0.7, width*0.1 ,height * 0.9);
    path.quadraticBezierTo(0, height * 0.97, 0,height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}
