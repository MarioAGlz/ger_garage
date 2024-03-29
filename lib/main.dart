import 'package:flutter/material.dart';
import 'package:ger_garage/styles/colors.dart';
import 'SideBar/sidebar_layout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(azureBlue), //Color(0xFFE6FBFF),
        primaryColor: Colors.white
      ),
      home: SideBarLayout(),
    );
  }
}
