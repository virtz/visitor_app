import 'package:flutter/material.dart';
import 'package:visitor/ui/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visitor',
      theme: ThemeData(
        
        primarySwatch: Colors.lime,
        accentColor: Colors.black
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
