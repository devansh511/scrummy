import 'dart:async';
import '../auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    delayTimer();
  }

  delayTimer() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 2),
        transitionsBuilder: (BuildContext context, Animation<double> splash,
            Animation<double> auth, Widget child) {
          splash = CurvedAnimation(parent: splash, curve: Curves.elasticInOut);

          return ScaleTransition(
            alignment: Alignment.bottomCenter,
            scale: splash,
            child: child,
          );
        },
        pageBuilder: (BuildContext context, Animation<double> splash,
            Animation<double> auth) {
          return AuthScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SvgPicture.asset('assets/logo.svg'),
      ),
    );
  }
}
