import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scrummy/screens/feed_screen.dart';
import 'package:scrummy/screens/home_screen.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
              top: deviceHeight - 700.0, left: deviceWidth - 355.0),
          child: Column(
            children: <Widget>[
              Text(
                'No food in your cart!',
                style: TextStyle(
                  fontFamily: 'McLaren',
                  color: Colors.grey[700],
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 70.0,
              ),
              SvgPicture.asset('assets/emptyCart.svg'),
              SizedBox(
                height: 80.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // FlatButton(
                  //   padding: EdgeInsets.symmetric(horizontal: 29.0),
                  //   color: Colors.white,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(25.0),
                  //     side: BorderSide(
                  //       width: 1.0,
                  //       color: Colors.orange,
                  //     ),
                  //   ),
                  //   child: Text(
                  //     'See my cart',
                  //     style: TextStyle(
                  //       color: Colors.orange,
                  //       fontFamily: 'Raleway',
                  //       fontSize: 15.0,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   onPressed: () {},
                  // ),
                  // SizedBox(
                  //   width: 20.0,
                  // ),
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 27.0),
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(
                        width: 1.0,
                        color: Colors.orange,
                      ),
                    ),
                    child: Text(
                      'Buy some food',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
