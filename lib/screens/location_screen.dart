import 'package:flutter/material.dart';
import './home_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'dart:async';

String addr1 = "";
String addr2 = "";

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var _isLoading = false;

  void getDeliveryAddress() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final userLocation =
          await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      final latitude = userLocation.latitude;
      final longitude = userLocation.longitude;
      final coordinates = Coordinates(latitude, longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);

      setState(() {
        _isLoading = false;
        addr1 = addresses.first.featureName;
        addr2 = addresses.first.addressLine;
        print(addr1);
        print(addr2);
      });

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(seconds: 3),
          transitionsBuilder: (BuildContext context, Animation<double> splash,
              Animation<double> auth, Widget child) {
            splash = CurvedAnimation(parent: splash, curve: Curves.elasticIn);

            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: splash,
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> splash,
              Animation<double> auth) {
            return HomeScreen();
          },
        ),
      );
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      throw error;
    }
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 100.0, bottom: 50.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/Location.png',
                      filterQuality: FilterQuality.high,
                      // width: deviceSize.width,
                      // height: 200.0,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                padding: EdgeInsets.only(top: 50.0),
                child: Text(
                  'Please allow Scrummy to know your location',
                  style: TextStyle(
                    color: Color(0xff595959),
                    fontFamily: 'Raleway',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 30.0),
                child: Text(
                  'This will help us to bring you your favorite food!',
                  style: TextStyle(
                    color: Color(0xff595959),
                    fontSize: 16,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (_isLoading)
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                )
              else
                Container(
                  width: 260,
                  height: 45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: FlatButton(
                      color: Colors.orange[700],
                      child: Text(
                        'Allow Location Access',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        getDeliveryAddress();
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
