import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:scrummy/auth/auth_screen.dart';
import '../screens/location_screen.dart';
import '../models/Http_Exceptions.dart';
import '../screens/reset_password.dart';
import 'auth.dart';

enum VerifyMode { Verify, Reset }
int check = auth;

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  VerifyMode _verifyMode = VerifyMode.Verify;
  TapGestureRecognizer _gestureRecognizer;
  @override
  void initState() {
    // TODO: implement initState
    _gestureRecognizer = TapGestureRecognizer()..onTap = _switchScreen;
    super.initState();
  }

  @override
  void dispose() {
    _gestureRecognizer.dispose();
    super.dispose();
  }

  void _switchScreen() {
    if (_verifyMode == VerifyMode.Reset) {
      setState(() {
        _verifyMode = VerifyMode.Verify;
      });
    } else {
      setState(() {
        _verifyMode = VerifyMode.Reset;
      });
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AuthScreen(),
    ));
  }

  var _isLoading = false;
  Map<String, String> _verifyData = {"otp": ""};
  Future<void> _showMyDialog(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'An error occured',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Okay',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  // void _showErrorDialog(String message) {
  //   // bool _pressed = false;
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: Text(
  //         'An error occured',
  //         style: TextStyle(
  //           fontFamily: 'Raleway',
  //           fontWeight: FontWeight.bold,
  //           color: Colors.grey[600],
  //         ),
  //       ),
  //       content: Text(message),
  //       actions: [
  //         FlatButton(
  //           child: Text(
  //             'Okay',
  //             style: TextStyle(
  //               fontFamily: 'Raleway',
  //               fontWeight: FontWeight.bold,
  //               color: Colors.orange,
  //             ),
  //           ),
  //           onPressed: () {
  //             // Navigator.of(context).pop();
  //             // _pressed = !_pressed;
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Future<void> _verifyOtp() async {
    var checkLogin;
    var checkPwd;
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      if (check == -1) {
        final reset = await Provider.of<Auth>(context, listen: false)
            .passwordOtp(_verifyData["otp"]);
        if (reset != -1) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ResetPassword()));
        }
      } else {
        final checkOtp = await Provider.of<Auth>(context, listen: false)
            .verifyOtp(_verifyData['otp']);

        checkLogin = await Provider.of<Auth>(context, listen: false).login();

        if (checkOtp != -1 && checkPwd != -1) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AuthScreen()));
        }

        if (checkOtp != -1 && checkLogin != -1) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LocationScreen(),
            ),
          );
        }
      }
      setState(() {
        _isLoading = false;
      });
    } on HttpException catch (error) {
      setState(() {
        _isLoading = false;
      });
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('wrong otp')) {
        errorMessage = 'Wrong OTP entered';
      } else if (error.toString().contains('otp expired')) {
        errorMessage = 'OTP expired! Check for new OTP on your email';
      }
      _showMyDialog(errorMessage);
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print(error);
      const errorMessage =
          'Could not authenticate you. Please try again later!';
      _showMyDialog(errorMessage);
    }
  }

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20),
        child: Container(
          margin: EdgeInsets.only(top: 100.0),
          child: Column(
            children: <Widget>[
              Center(
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
              SizedBox(
                height: 140.0,
              ),
              Text(
                _verifyMode == VerifyMode.Reset
                    ? 'Reset your password'
                    : 'Confirm your email',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey[600],
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      width: 280.0,
                      height: 50.0,
                      child: TextFormField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            _verifyMode == VerifyMode.Reset
                                ? Icons.person_outline
                                : Icons.vpn_key,
                          ),
                          labelText: _verifyMode == VerifyMode.Reset
                              ? 'E-mail'
                              : 'OTP',
                          labelStyle: TextStyle(
                            fontFamily: 'Raleway',
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (_verifyMode == VerifyMode.Reset) {
                            _verifyData['otp_email'] = value;
                          } else {
                            _verifyData['otp'] = value;
                          }
                        },
                      ),
                    ),
                    Text(
                      _verifyMode == VerifyMode.Reset
                          ? 'We will sent you an email to reset your password'
                          : 'We have sent an OTP on your email',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    if (_isLoading)
                      CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.orange),
                      )
                    else
                      Container(
                        margin: EdgeInsets.only(
                          top: 30.0,
                        ),
                        width: 280,
                        height: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: FlatButton(
                            color: Colors.orange,
                            child: Text(
                              _verifyMode == VerifyMode.Reset
                                  ? 'Request OTP'
                                  : 'Confirm',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              _verifyOtp();
                              print(_verifyData['otp']);
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  text: 'Already on Scrummy? ',
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontFamily: 'Raleway',
                    fontSize: 15,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' Login',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 16.5,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: _gestureRecognizer,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
