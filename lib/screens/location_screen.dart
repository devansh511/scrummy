import 'package:flutter/material.dart';
import './home_screen.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
