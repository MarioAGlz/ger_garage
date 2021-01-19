import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ger_garage/services/firebase/firebase_auth_srvc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ger_garage/SideBar/menu_item.dart';
import 'package:ger_garage/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:ger_garage/styles/colors.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }
  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  Widget _buildListTile(String title, String subtitle) {
    return ListTile(
      title: Text(title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700)
      ),
      subtitle: Text(subtitle,
          style: TextStyle(
              color: Colors.white, fontSize: 18)
      ),
      leading: CircleAvatar(
        child: Icon(
          Icons.perm_identity,
          color: Colors.white,
          size: 40,
        ),
        radius: 35,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSidebarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSidebarOpenedAsync.data ? 0 : -screenWidth,
          right: isSidebarOpenedAsync.data ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: screenHeight,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: Color(gunmetal),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 90),
                        FutureBuilder(
                            future: FirebaseAuthService.firebaseUserDetail(),
                            builder: (BuildContext context,
                              AsyncSnapshot<FirebaseUser> fBSnapshot) {
                              if (fBSnapshot.hasData) {
                                return Column(
                                  children: <Widget>[
                                    _buildListTile(fBSnapshot.data.uid, fBSnapshot.data.email),
                                    MenuItem(
                                      icon: Icons.exit_to_app,
                                      title: "Logout",
                                      onTap: () {
                                        onIconPressed();
                                        FirebaseAuthService.firebaseLogout(context);
                                      },
                                    ),
                                  ],
                                );
                              }
                              return _buildListTile('User', 'e-mail');
                            }
                            ),
                        Divider(
                          height: 50,
                          thickness: 0.6,
                          color: Colors.white.withOpacity(0.6),
                          indent: 20,
                          endIndent: 25,
                        ),
                        MenuItem(
                          icon: Icons.home,
                          title: "Home",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.directions_car,
                          title: "My Cars",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyCarsClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.book,
                          title: "Book a Service",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyBookingClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.add_shopping_cart,
                          title: "Store",
                        ),
                        Divider(
                          height: 50,
                          thickness: 0.6,
                          color: Colors.white.withOpacity(0.8),
                          indent: 20,
                          endIndent: 25,
                        ),
                        MenuItem(
                          icon: Icons.account_circle,
                          title: "Login",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.LoginClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.person_add,
                          title: "Sig up",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.SigUpClickedEvent);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.80),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 100,
                      color: Color(gunmetal),
                      alignment: Alignment.center,
                      child: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: _animationController.view,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width-1, height/2-20, width, height/2);
    path.quadraticBezierTo(width+1, height/2+20, 10, height-16);
    path.quadraticBezierTo(0, height-8, 0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}