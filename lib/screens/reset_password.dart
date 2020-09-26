import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:scrummy/auth/auth_screen.dart';
import 'package:scrummy/auth/verify.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<FormState> _formKey = GlobalKey();
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  var _isLoading = false;
  String _password;

  // void _switchAuthMode() {
  //   if (_authMode == AuthMode.Login) {
  //     setState(() {
  //       _authMode = AuthMode.Signup;
  //     });
  //   } else {
  //     setState(() {
  //       _authMode = AuthMode.Login;
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

  void _switchScreen() {
    Navigator.of(context).pop();
  }

  void _submit() {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    print(_password);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => VerifyScreen()));
  }
  //   try {
  //     if (_authMode == AuthMode.Login) {
  //       // Log user in
  //       await Provider.of<Auth>(context, listen: false).login(
  //         _authData['email'],
  //         _authData['password'],
  //       );
  //     } else {
  //       // Sign user up
  //       await Provider.of<Auth>(context, listen: false).signup(
  //         _authData['email'],
  //         _authData['password'],
  //       );
  //     }
  //   } on HttpException catch (error) {
  //     var errorMessage = 'Authentication failed';
  //     if (error.toString().contains('EMAIL_EXISTS')) {
  //       errorMessage = 'Email already registered';
  //     } else if (error.toString().contains('INVALID_EMAIL')) {
  //       errorMessage = 'Please enter a valid email';
  //     } else if (error.toString().contains('WEAK_PASSWORD')) {
  //       errorMessage = 'Password too weak';
  //     } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
  //       errorMessage = 'Could not find a user with this email';
  //     } else if (error.toString().contains('INVALID_PASSWORD')) {
  //       errorMessage = 'Please enter correct password';
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
    GlobalKey<FormState> _formKey = GlobalKey();
    return Scaffold(
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
            'Create a new password',
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
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 240,
                  height: 60,
                  child: TextFormField(
                    controller: _controller1,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        labelText: 'New Password',
                        labelStyle: TextStyle(
                          fontFamily: 'Raleway',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        )),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty || value.length < 6) {
                        return 'Password must be of least 6 digits';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 240,
                  height: 60,
                  child: TextFormField(
                    controller: _controller2,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline,
                      ),
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                        fontFamily: 'Raleway',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value != _controller1.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                if (_isLoading)
                  CircularProgressIndicator(
                    backgroundColor: Colors.orange,
                  )
                else
                  Container(
                    width: 240,
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: FlatButton(
                        color: Colors.orange,
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          _submit();
                        },
                      ),
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
        ],
      ),
    );
  }
}
