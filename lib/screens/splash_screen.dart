import 'dart:async';
import '../auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   delayTimer();
  // }

  // delayTimer() async {
  //   var duration = Duration(seconds: 4);
  //   return Timer(duration, route);
  // }

  // route() {
  //   Navigator.pushReplacement(
  //     context,
  //     PageRouteBuilder(
  //       transitionDuration: Duration(seconds: 1),
  //       transitionsBuilder: (BuildContext context, Animation<double> splash,
  //           Animation<double> auth, Widget child) {
  //         splash = CurvedAnimation(parent: splash, curve: Curves.elasticIn);

  //         return ScaleTransition(
  //           alignment: Alignment.bottomCenter,
  //           scale: splash,
  //           child: child,
  //         );
  //       },
  //       pageBuilder: (BuildContext context, Animation<double> splash,
  //           Animation<double> auth) {
  //         return AuthScreen();
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 170.0),
          child: Center(
            child: SvgPicture.asset('assets/logo.svg'),
          ),
        ),
      ),
    );
  }
}
