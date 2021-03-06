import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scrummy/auth/auth_screen.dart';

class PanelScreen extends StatefulWidget {
  @override
  _PanelScreenState createState() => _PanelScreenState();
}

class _PanelScreenState extends State<PanelScreen> {
  Map<String, String> _panelData = {'Role': ''};

  void setPanel(int selPanel) {
    if (selPanel == 2) {
      _panelData['Role'] = '2';
      print('Restaurant');
      print(_panelData['Role']);
    } else {
      _panelData['Role'] = '1';
      print('Customer');
      print(_panelData['Role']);
    }
  }

  // Color iconColordk = Colors.grey[600];
  // Color cLickIconColor = Colors.orange;
  Color _custIconColor = Colors.grey[600];
  Color _restIconColor = Colors.grey[600];
  Color _custBorderColor = Colors.white;
  Color _restBorderColor = Colors.white;
  double _restElevation = 9.0;
  double _custElevation = 9.0;

  // void _changeIconColor1() {
  //   if (_restIconColor == Colors.grey[600]) {
  //     _restIconColor = Colors.orange;
  //   } else {
  //     _restIconColor = Colors.grey[600];
  //   }
  // }

  // void _changeIconColor2() {
  //   if (_custIconColor == Colors.grey[600]) {
  //     _custIconColor = Colors.orange;
  //   } else {
  //     _custIconColor = Colors.grey[600];
  //   }
  // }
  void _changeIconColor(String check) {
    if (check == '1') {
      if (_custIconColor == Colors.grey[600] &&
          _custBorderColor == Colors.white) {
        _custIconColor = Colors.orange;
        _custBorderColor = Colors.orange;
        // _restIconColor = Colors.grey[600];
        _custElevation = 0.0;
      } else {
        _custIconColor = Colors.grey[600];
        _custBorderColor = Colors.white;

        // _restIconColor = Colors.orange;
        _custElevation = 9.0;
      }
      // _border = BorderSide(color: Colors.orange, width: 3);
    } else {
      if (_restIconColor == Colors.grey[600] &&
          _restBorderColor == Colors.white) {
        _restIconColor = Colors.orange;
        _restBorderColor = Colors.orange;
        // _custIconColor = Colors.grey[600];
        _restElevation = 0.0;
      } else {
        _restIconColor = Colors.grey[600];
        _restBorderColor = Colors.white;
        // _custIconColor = Colors.orange;
        _restElevation = 9.0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: deviceHeight,
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 80.0, bottom: 70.0),
                  child: Text(
                    'SCRUMMY',
                    style: TextStyle(
                      fontFamily: 'Mclaren',
                      color: Colors.orange,
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      child: GestureDetector(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                              color: _restBorderColor,
                              width: 3,
                            ),
                          ),
                          elevation: _restElevation,
                          shadowColor: Colors.grey[300],
                          child: SvgPicture.asset(
                            'assets/rest.svg',
                            fit: BoxFit.none,
                            color: _restIconColor,
                            width: 100.0,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _changeIconColor('2');
                            setPanel(2);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      child: GestureDetector(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                              color: _custBorderColor,
                              width: 3,
                            ),
                          ),
                          elevation: _custElevation,
                          shadowColor: Colors.grey[300],
                          child: SvgPicture.asset(
                            'assets/cust.svg',
                            fit: BoxFit.none,
                            color: _custIconColor,
                            width: 100.0,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            print('Tapping');
                            setPanel(1);
                            _changeIconColor('1');
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 25, top: 10.0),
                      child: Text(
                        'Restaurant',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Raleway',
                          fontSize: 25,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Customer',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Raleway',
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 100),
                  width: 260,
                  height: 45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: FlatButton(
                      color: Colors.orange,
                      child: Text(
                        'Continue',
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
                            builder: (context) => AuthScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
