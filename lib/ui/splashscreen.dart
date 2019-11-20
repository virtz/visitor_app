import 'package:flutter/material.dart';
import 'package:visitor/ui/signin.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => SignIn()),
          (Route route) => route == null);
        },
          child: Scaffold(
          body: Center(
              child: InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.person,size:100,color: Colors.black),
                      Text("Tap to continue",
                          style: TextStyle(fontSize: 13.0)),
                    ],
                  )))),
    );
  }
}
