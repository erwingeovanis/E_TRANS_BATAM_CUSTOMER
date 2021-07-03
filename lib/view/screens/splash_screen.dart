import 'package:e_trans/view/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:e_trans/utils/context_utils.dart';

class SplashScreen extends StatefulWidget {
  String? get tag => null;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  get child => null;

  @override
  void initState() {
    context.autProvider.loadAuthDetails();
    context.mainProvider.loadnews();
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      context.mainProvider.loadhalte();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          context.mainProvider.loadJurusan();
          return MainScreen();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
        ),
        Image.asset('image/background_splashscreen.JPG',
            fit: BoxFit.cover, width: 700),
        Padding(
          padding: EdgeInsets.only(top: 150, left: 30),
          child: Image.asset(
            'image/logo.png',
            width: 500,
            height: 500,
          ),
        ),
      ],
    ));
  }
}
