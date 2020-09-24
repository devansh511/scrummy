import 'package:flutter/material.dart';
import 'package:scrummy/screens/home_screen.dart';
import 'package:scrummy/screens/location_screen.dart';
import 'package:scrummy/screens/splash_screen.dart';
import 'auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import '../models/Http_Exceptions.dart';
import '../screens/splash_screen.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: deviceHeight.height,
            child: AuthPage(),
          ),
        ),
      ),
    );
  }
}

enum AuthMode { Login, Signup }

class AuthPage extends StatefulWidget {
  const AuthPage({
    Key key,
  }) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();
  TapGestureRecognizer _gestureRecognizer;

  @override
  void initState() {
    _gestureRecognizer = TapGestureRecognizer()..onTap = _switchAuthMode;
    super.initState();
  }

  @override
  void dispose() {
    _gestureRecognizer.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'An error occured',
          style: TextStyle(
            fontFamily: 'Raleway',
          ),
        ),
        content: Text(message),
        actions: [
          FlatButton(
            child: Text(
              'Okay',
              style: TextStyle(
                fontFamily: 'Raleway',
              ),
            ),
            onPressed: () {
              // Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        // Log user in

        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],
        );
      }

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SplashScreen()));
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'Email already registered';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Please enter a valid email';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'Password too weak';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with this email';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Please enter correct password';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      print(error);
      const errorMessage =
          'Could not authenticate you. Please try again later!';
      _showErrorDialog(errorMessage);
    }
    _controller1.clear();
    _controller2.clear();
    _controller3.clear();
    _controller4.clear();
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
          height: 80,
        ),
        Text(
          _authMode == AuthMode.Login
              ? 'Login into your account'
              : 'Create your account',
          style: TextStyle(
            fontFamily: 'Raleway',
            color: Colors.grey[600],
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
            children: <Widget>[
              Container(
                width: 240,
                height: _authMode == AuthMode.Login ? 0 : 60,
                child: _authMode == AuthMode.Login
                    ? null
                    : TextFormField(
                        controller: _controller1,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person_outline,
                          ),
                          labelText: 'Enter your name',
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
                      ),
              ),
              SizedBox(
                height: _authMode == AuthMode.Login ? 0 : 10,
              ),
              Container(
                width: 240,
                height: 60,
                child: TextFormField(
                  // style: TextStyle(
                  //   fontFamily: 'Raleway',
                  //   color: Colors.grey[600],
                  //   fontSize: 20.0,
                  // ),
                  controller: _controller2,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.alternate_email,
                    ),
                    labelText: 'E-mail',
                    labelStyle: TextStyle(
                      fontFamily: 'Raleway',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
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
                  controller: _controller3,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontFamily: 'Raleway',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty || value.length < 6) {
                      return 'Password must be of least 6 digits';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 240,
                height: _authMode == AuthMode.Login ? 0 : 60,
                child: _authMode == AuthMode.Login
                    ? null
                    : TextFormField(
                        controller: _controller4,
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
                          if (value != _controller3.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
              ),
              _authMode == AuthMode.Signup
                  ? SizedBox(
                      height: 15,
                    )
                  : Container(
                      padding: EdgeInsets.only(bottom: 15),
                      child: InkWell(
                        child: Text(
                          'Forgotten Password?',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.grey[900],
                            fontSize: 15,
                          ),
                        ),
                        onTap: () {},
                      ),
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
                        _authMode == AuthMode.Login ? 'Login' : 'Signup',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        // print('Before submit');
                        _submit();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationScreen(),
                          ),
                        );
                        // print('After submit');
                      },
                    ),
                  ),
                ),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  text: _authMode == AuthMode.Login
                      ? 'New to Scrummy?'
                      : 'Already have an account? ',
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontFamily: 'Raleway',
                    fontSize: 15,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: _authMode == AuthMode.Login ? 'Signup' : 'Login',
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
    );
  }
}

// class AuthLogin extends StatefulWidget {
//   @override
//   _AuthLoginState createState() => _AuthLoginState();
// }

// class _AuthLoginState extends State<AuthLogin> {
//   GlobalKey<FormState> _formKey = GlobalKey();
//   AuthMode _authMode = AuthMode.Login;
//   Map<String, String> _authData = {
//     'email': '',
//     'password': '',
//   };
//   var _isLoading = false;

//   // void _switchAuthMode() {
//   //   if (_authMode == AuthMode.Login) {
//   //     setState(() {
//   //       _authMode = AuthMode.Signup;
//   //     });
//   //   } else {
//   //     setState(() {
//   //       _authMode = AuthMode.Login;
//   //     });
//   //   }
//   // }

//   TapGestureRecognizer _gestureRecognizer;

//   @override
//   void initState() {
//     //_gestureRecognizer = TapGestureRecognizer()..onTap = _switchAuthMode;
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _gestureRecognizer.dispose();
//     super.dispose();
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text('An error occured'),
//         content: Text(message),
//         actions: [
//           FlatButton(
//             child: Text('Okay'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _submit() async {
//     if (!_formKey.currentState.validate()) {
//       // Invalid!
//       return;
//     }
//     _formKey.currentState.save();
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       if (_authMode == AuthMode.Login) {
//         // Log user in
//         await Provider.of<Auth>(context, listen: false).login(
//           _authData['email'],
//           _authData['password'],
//         );
//       } else {
//         // Sign user up
//         await Provider.of<Auth>(context, listen: false).signup(
//           _authData['email'],
//           _authData['password'],
//         );
//       }
//     } on HttpException catch (error) {
//       var errorMessage = 'Authentication failed';
//       if (error.toString().contains('EMAIL_EXISTS')) {
//         errorMessage = 'Email already registered';
//       } else if (error.toString().contains('INVALID_EMAIL')) {
//         errorMessage = 'Please enter a valid email';
//       } else if (error.toString().contains('WEAK_PASSWORD')) {
//         errorMessage = 'Password too weak';
//       } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
//         errorMessage = 'Could not find a user with this email';
//       } else if (error.toString().contains('INVALID_PASSWORD')) {
//         errorMessage = 'Please enter correct password';
//       }
//       _showErrorDialog(errorMessage);
//     } catch (error) {
//       const errorMessage =
//           'Could not authenticate you. Please try again later!';
//       _showErrorDialog(errorMessage);
//     }

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     GlobalKey<FormState> _formKey = GlobalKey();
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Center(
//           child: Text(
//             'SCRUMMY',
//             style: TextStyle(
//               fontFamily: 'Mclaren',
//               color: Colors.orange,
//               fontSize: 50,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 2,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 80,
//         ),
//         Text(
//           'Login into your account',
//           style: TextStyle(
//             fontFamily: 'Raleway',
//             color: Colors.grey[900],
//             fontSize: 15,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(
//           height: 15,
//         ),
//         Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 width: 240,
//                 height: 60,
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       prefixIcon: Icon(
//                         Icons.person_outline,
//                       ),
//                       labelText: 'Email',
//                       labelStyle: TextStyle(
//                         fontFamily: 'Raleway',
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(35.0),
//                       )),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || !value.contains('@')) {
//                       return 'Invalid Email';
//                     }
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 width: 240,
//                 height: 60,
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       prefixIcon: Icon(
//                         Icons.lock_outline,
//                       ),
//                       labelText: 'Password',
//                       labelStyle: TextStyle(
//                         fontFamily: 'Raleway',
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(35.0),
//                       )),
//                   obscureText: true,
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
// InkWell(
//   child: Text(
//     'Forgotten Password?',
//     style: TextStyle(
//       fontFamily: 'Raleway',
//       color: Colors.grey[900],
//       fontSize: 15,
//     ),
//   ),
//   onTap: () {},
// ),
//               SizedBox(
//                 height: 15,
//               ),
//               if (_isLoading)
//                 CircularProgressIndicator(
//                   backgroundColor: Colors.orange,
//                 )
//               else
//                 Container(
//                   width: 240,
//                   height: 40,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(25.0),
//                     child: FlatButton(
//                       color: Colors.orange,
//                       child: Text(
//                         'Login',
//                         style: TextStyle(
//                           fontFamily: 'Raleway',
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       onPressed: _submit,
//                     ),
//                   ),
//                 ),
//               SizedBox(
//                 height: 15,
//               ),
//               RichText(
//                 text: TextSpan(
//                   text: 'New to Scrummy? ',
//                   style: TextStyle(
//                     color: Colors.grey[900],
//                     fontFamily: 'Raleway',
//                     fontSize: 15,
//                   ),
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: 'Sign Up',
//                       style: TextStyle(
//                         color: Colors.orange,
//                         fontSize: 16.5,
//                         fontFamily: 'Raleway',
//                         fontWeight: FontWeight.bold,
//                       ),
//                       recognizer: _gestureRecognizer,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
