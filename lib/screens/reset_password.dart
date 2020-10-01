import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:scrummy/models/Http_Exceptions.dart';
import '../auth/auth.dart';
import 'dart:async';
import 'package:scrummy/auth/auth_screen.dart';
import 'package:scrummy/auth/verify.dart';
import 'package:provider/provider.dart';

enum Modes { Email, OTP }
Modes _mode = Modes.Email;

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

String e_mailReset;
String p_wordReset;
int auth = 0;

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormState> _formKey1 = GlobalKey();
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  var _isLoading = false;
  bool _val = false, _val1 = false;
  bool _showPassword4 = true;
  bool _showPassword5 = true;

  // void _switchModes() {
  //   if (_mode == Modes.Email) {
  //     setState(() {
  //       _mode = Modes.OTP;
  //     });
  //   } else {
  //     setState(() {
  //       _mode = Modes.Email;
  //     });
  //   }
  // }

  TapGestureRecognizer _gestureRecognizer;

  @override
  void initState() {
    _gestureRecognizer = TapGestureRecognizer()..onTap = _switchScreen;
    super.initState();
  }

  @override
  void dispose() {
    _gestureRecognizer.dispose();
    super.dispose();
  }

  // void _showErrorDialog(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: Text('An error occured'),
  //       content: Text(message),
  //       actions: [
  //         FlatButton(
  //           child: Text('Okay'),
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
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

  void _switchScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AuthScreen()));
  }

  void _submitMail() async {
    // _formKey1.currentState.save();

    setState(() {
      _isLoading = true;
    });

    try {
      auth = -1;
      print(e_mailReset);
      final check =
          await Provider.of<Auth>(context, listen: false).resetOtp(e_mailReset);

      if (check != -1) {
        setState(() {
          _mode = Modes.OTP;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => VerifyScreen()));
      }
    } on HttpException catch (error) {
      var errorMessage = "Authentication Failed";
      if (error.toString().contains('User not found with given email')) {
        errorMessage = 'Please enter correct email';
      }
      setState(() {
        _isLoading = false;
      });
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
    setState(() {
      _isLoading = false;
    });
  }

  void _submit() async {
    // _formKey.currentState.save();
    _controller3.clear();
    // _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      print(p_wordReset);

      await Provider.of<Auth>(context, listen: false).resetPwd(p_wordReset);
      setState(() {
        _mode = Modes.Email;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AuthScreen()));
    } on HttpException catch (error) {
      var errorMessage = "Authentication Failed";
      if (error.toString().contains('User not found with given email')) {
        errorMessage = 'Please enter correct email';
      }

      _showMyDialog(errorMessage);
    } catch (error) {
      print(error);
      const errorMessage =
          'Could not authenticate you. Please try again later!';
      _showMyDialog(errorMessage);
    }
    print(p_wordReset);
  }
  //   try {
  //     if (_authMode == AuthMode.Login) {
  //       // Log user in
  //       await Provider.of<Auth>(context, listen: false).login(
  //         _authData['email'],
  //         _authData['p_word'],
  //       );
  //     } else {
  //       // Sign user up
  //       await Provider.of<Auth>(context, listen: false).signup(
  //         _authData['email'],
  //         _authData['p_word'],
  //       );
  //     }
  //   } on HttpException catch (error) {
  //     var errorMessage = 'Authentication failed';
  //     if (error.toString().contains('EMAIL_EXISTS')) {
  //       errorMessage = 'Email already registered';
  //     } else if (error.toString().contains('INVALIDemail')) {
  //       errorMessage = 'Please enter a valid email';
  //     } else if (error.toString().contains('WEAKp_word')) {
  //       errorMessage = 'Password too weak';
  //     } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
  //       errorMessage = 'Could not find a user with this email';
  //     } else if (error.toString().contains('INVALIDp_word')) {
  //       errorMessage = 'Please enter correct p_word';
  //     }
  //     _showErrorDialog(errorMessage);
  //   } catch (error) {
  //     const errorMessage =
  //         'Could not authenticate you. Please try again later!';
  //     _showErrorDialog(errorMessage);
  //   }

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // GlobalKey<FormState> _formKey = GlobalKey();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              'SCRUMMY',
              style: TextStyle(
                fontFamily: 'Mclaren',
                color: Colors.orange,
                fontSize: 50,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Text(
            _mode == Modes.Email ? 'Enter you email' : 'Create a new password',
            style: TextStyle(
              fontFamily: 'Raleway',
              color: Colors.grey[900],
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Form(
            key: _formKey1,
            autovalidate: _val1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Opacity(
                  opacity: _mode == Modes.Email ? 1.0 : 0.0,
                  child: Container(
                    width: 240,
                    height: _mode == Modes.Email ? 60 : 0,
                    child: TextFormField(
                      controller: _controller3,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email),
                          labelText: 'E-mail',
                          labelStyle: TextStyle(
                            fontFamily: 'Raleway',
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          )),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return 'Please enter valid email';
                        }

                        return null;
                      },
                      onChanged: (value) {
                        print(value);
                        e_mailReset = value;
                        print(e_mail);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: 240,
                  height: _mode == Modes.Email ? 40 : 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: FlatButton(
                      color: Colors.orange,
                      child: Text(
                        _mode == Modes.Email ? 'Send OTP' : 'Confirm',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (!_formKey1.currentState.validate()) {
                          // Invalid!
                          setState(() {
                            _val1 = true;
                          });
                          return;
                        } else {
                          _mode == Modes.OTP ? _submit() : _submitMail();
                        }
                        print(e_mailReset);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Form(
            key: _formKey,
            autovalidate: _val,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Opacity(
                //   opacity: _mode == Modes.Email ? 1.0 : 0.0,
                //   child: Container(
                //     width: 240,
                //     height: _mode == Modes.Email ? 60 : 0,
                //     child: TextFormField(
                //       controller: _controller1,
                //       decoration: InputDecoration(
                //           prefixIcon: Icon(Icons.alternateemail),
                //           labelText: 'E-mail',
                //           labelStyle: TextStyle(
                //             fontFamily: 'Raleway',
                //           ),
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(35.0),
                //           )),
                //       keyboardType: TextInputType.emailAddress,
                //       validator: (value) {
                //         if (value == null || !value.contains('@')) {
                //           return 'Please enter valid email';
                //         }
                //         return null;
                //       },
                //       onSaved: (value) {
                //         email = value;
                //       },
                //     ),
                //   ),
                // ),
                Opacity(
                  opacity: _mode == Modes.OTP ? 1.0 : 0.0,
                  child: Container(
                    width: 240,
                    height: _mode == Modes.Email ? 0 : 60,
                    child: TextFormField(
                      controller: _controller1,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: GestureDetector(
                            child: Icon(Icons.remove_red_eye),
                            onTap: () {
                              setState(() {
                                _showPassword4 = !_showPassword4;
                              });
                            },
                          ),
                          labelText: 'New Password',
                          labelStyle: TextStyle(
                            fontFamily: 'Raleway',
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          )),
                      obscureText: _showPassword4,
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) {
                          return 'Password must be of least 6 digits';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        print(value);
                        p_wordReset = value;
                        print(p_word);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: _mode == Modes.OTP ? 10 : 0,
                ),
                Opacity(
                  opacity: _mode == Modes.OTP ? 1.0 : 0.0,
                  child: Container(
                    width: 240,
                    height: _mode == Modes.Email ? 0 : 60,
                    child: TextFormField(
                      controller: _controller2,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_outline,
                        ),
                        suffixIcon: GestureDetector(
                          child: Icon(Icons.remove_red_eye),
                          onTap: () {
                            setState(() {
                              _showPassword5 = !_showPassword5;
                            });
                          },
                        ),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                          fontFamily: 'Raleway',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                      ),
                      obscureText: _showPassword5,
                      validator: (value) {
                        if (value != _controller1.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  )
                else
                  Container(
                    width: 240,
                    height: _mode == Modes.Email ? 0 : 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: FlatButton(
                        color: Colors.orange,
                        child: Text(
                          _mode == Modes.Email ? 'Send OTP' : 'Confirm',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (!_formKey.currentState.validate()) {
                            // Invalid!
                            setState(() {
                              _val = true;
                            });
                            HapticFeedback.vibrate();
                            return;
                          } else {
                            _mode == Modes.OTP ? _submit() : _submitMail();
                          }
                        },
                      ),
                    ),
                  ),
                SizedBox(
                  height: 20,
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
        ],
      ),
    );
  }
}
