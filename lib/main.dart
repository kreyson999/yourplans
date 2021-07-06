import 'package:flutter/material.dart';
import 'package:yourplans/config/theme.dart';
import 'package:yourplans/screens/splash_screen.dart';


void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      home: SplashScreen(),
    );
  }
}
