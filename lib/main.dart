import 'package:flutter/material.dart';
import 'package:bicycle/MainPage/HomePage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bicycle App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF333945),
        accentColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Bitter',
      ),
      home: HomePage(title: 'Bicycle'),
    );
  }
}

