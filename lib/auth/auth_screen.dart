import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scrummy/auth/verify.dart';
import 'package:scrummy/screens/home_screen.dart';
import 'package:scrummy/screens/location_screen.dart';
import 'package:scrummy/screens/reset_password.dart';
import 'package:scrummy/screens/splash_screen.dart';
import 'auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import '../models/Http_Exceptions.dart';
import '../screens/splash_screen.dart';

String e_mail;
String p_word;
String name;

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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

enum AuthMode { Login, Signup, Reset }

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
    'name': '',
  };
  var _isLoading = false;
  final _controller1 = TextEditingController();
  final _controller2l = TextEditingController();
  final _controller2s = TextEditingController();
  final _controller3l = TextEditingController();
  final _controller3s = TextEditingController();
  final _controller4 = TextEditingController();
  TapGestureRecognizer _gestureRecognizer;
  String _userNameErrorText;
  bool _userNameError = false;

  // String _emailTextl;
  // bool _emailErrorl = false;
  // String _emailTexts;
  // bool _emailErrors = false;
  // String _passwordTextl;
  // bool _passwordErrorl = false;
  // String _passwordTexts;
  // bool _passwordErrors = false;
  // String _cnfPasswordText;
  // bool _cnfPasswordError = false;
  bool _showPassword1 = true;
  bool _showPassword2 = true;
  bool _showPassword3 = true;
  bool _val = false;

  String valName(value) {
    if (value == null) {
      return "Field cannot be empty";
    } else
      return null;
  }

  String valEmail(value) {
    // Pattern _pattern =
    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    // RegExp _regex = RegExp(_pattern);
    if (value == null || !value.contains("@"))
      return 'Please enter a valid email';
    else
      return null;
  }

  String valPassword(value) {
    if (value.length < 6)
      return 'Password must be least of 6 digits!';
    else
      return null;
  }

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

  void _resetPassword() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 2),
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
          return ResetPassword();
        },
      ),
    );
  }

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
  // style: TextStyle(
  //   fontFamily: 'Raleway',
  //   fontWeight: FontWeight.bold,
  //   color: Colors.grey[600],
  // ),
  //       ),
  //       content: Text(message),
  //       actions: [
  //         FlatButton(
  //           child: Text(
  //             'Okay',
  // style: TextStyle(
  //   fontFamily: 'Raleway',
  //   fontWeight: FontWeight.bold,
  //   color: Colors.orange,
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

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        print(_authData['email']);
        print(_authData['password']);
        final checkOtp = await Provider.of<Auth>(context, listen: false)
            .checkVerify(_authData['email'], _authData['password']);
        final checkLogin =
            await Provider.of<Auth>(context, listen: false).login();
        if (checkOtp != -1 && checkLogin != -1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LocationScreen(),
            ),
          );
        }
      } else {
        //Sign user up
        print(_authData['password']);
        print(_authData['email']);
        print(_authData['name']);
        final check = await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],
          _authData['name'],
        );

        if (check != -1) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VerifyScreen(),
            ),
          );
        }
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error
          .toString()
          .contains('User with the given email address already exists')) {
        errorMessage = 'Email already registered. Try logging in!';
      } else if (error.toString().contains('email not found in users')) {
        errorMessage = 'You are not registered on Scrummy';
      } else if (error.toString().contains('user is not otp verified')) {
        errorMessage = "Activate your Scrummy account";
        await Provider.of<Auth>(context, listen: false)
            .generateOtp(_authData['email']);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VerifyScreen(),
          ),
        );
      } else if (error
          .toString()
          .contains("No active account found with the given credentials")) {
        errorMessage = "Incorrect Password";
      } else if (error.toString().contains("invalid email")) {
        errorMessage = "Invalid Email";
      } else if (error.toString().contains("wrong password")) {
        errorMessage = "Incorrect Password";
      }
      // } else {
      //   errorMessage = 'Email not verified';
      //   Navigator.of(context)
      //       .push(MaterialPageRoute(builder: (context) => VerifyScreen()));
      // }
      _showMyDialog(errorMessage);
    } catch (error) {
      print(error);
      const errorMessage = 'Something went wrong!';
      _showMyDialog(errorMessage);
    }

    setState(() {
      _controller1.clear();
      _controller2l.clear();
      _controller2s.clear();
      _controller3l.clear();
      _controller3s.clear();
      _controller4.clear();
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
        print(_authMode);
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
        print(_authMode);
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
          autovalidate: _val,
          child: Column(
            children: <Widget>[
              Container(
                width: 240,
                height: (_authMode == AuthMode.Login) ? 0 : 60,
                child: (_authMode == AuthMode.Login)
                    ? null
                    : TextFormField(
                        controller: _controller1,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person_outline,
                          ),
                          labelText: 'Enter your name',
                          // errorText: _userNameErrorText,
                          labelStyle: TextStyle(
                            fontFamily: 'Raleway',
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                        ),
                        validator: valName,
                        // onChanged: (value) {
                        //   // setState(() {
                        //   _userNameError = false;
                        //   _userNameErrorText = null;
                        //   // });
                        // },
                        onChanged: (value) {
                          _authData['name'] = value;
                          name = value;
                        },
                      ),
              ),
              SizedBox(
                height: (_authMode == AuthMode.Login) ? 0 : 10,
              ),
              Container(
                width: 240,
                height: _authMode == AuthMode.Login ? 60 : 0,
                child: _authMode == AuthMode.Signup
                    ? null
                    : TextFormField(
                        // style: TextStyle(
                        //   fontFamily: 'Raleway',
                        //   color: Colors.grey[600],
                        //   fontSize: 20.0,
                        // ),
                        controller: _controller2l,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.alternate_email,
                          ),
                          labelText: 'E-mail',
                          // errorText: _emailTextl,
                          labelStyle: TextStyle(
                            fontFamily: 'Raleway',
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: valEmail,
                        // onChanged: (value) {
                        //   // setState(() {
                        //   _emailErrorl = false;
                        //   _emailTextl = null;
                        //   // });
                        // },
                        onChanged: (value) {
                          _authData['email'] = value;
                          e_mail = value;
                        },
                      ),
              ),
              Container(
                width: 240,
                height: _authMode == AuthMode.Login ? 0 : 60,
                child: _authMode == AuthMode.Login
                    ? null
                    : TextFormField(
                        // style: TextStyle(
                        //   fontFamily: 'Raleway',
                        //   color: Colors.grey[600],
                        //   fontSize: 20.0,
                        // ),
                        controller: _controller2s,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.alternate_email,
                          ),
                          labelText: 'E-mail',
                          // errorText: _emailTexts,
                          labelStyle: TextStyle(
                            fontFamily: 'Raleway',
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: valEmail,
                        // onChanged: (value) {
                        //   setState(() {
                        //     _emailErrors = false;
                        //     _emailTexts = null;
                        //   });
                        // },
                        onChanged: (value) {
                          _authData['email'] = value;
                          e_mail = value;
                        },
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 240,
                height: _authMode == AuthMode.Login ? 60 : 0,
                child: _authMode == AuthMode.Signup
                    ? null
                    : TextFormField(
                        controller: _controller3l,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                          ),
                          suffixIcon: GestureDetector(
                            child: Icon(Icons.remove_red_eye),
                            onTap: () {
                              setState(() {
                                _showPassword1 = !_showPassword1;
                              });
                            },
                          ),
                          labelText: 'Password',
                          // errorText: _passwordTextl,
                          labelStyle: TextStyle(
                            fontFamily: 'Raleway',
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                        ),
                        obscureText: _showPassword1,
                        validator: valPassword,
                        // onChanged: (value) {
                        //   // setState(() {
                        //   _passwordErrorl = false;
                        //   _passwordTextl = null;
                        //   // });
                        // },
                        onChanged: (value) {
                          _authData['password'] = value;
                          p_word = value;
                        },
                      ),
              ),
              Container(
                width: 240,
                height: _authMode == AuthMode.Signup ? 60 : 0,
                child: _authMode == AuthMode.Login
                    ? null
                    : TextFormField(
                        controller: _controller3s,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                          ),
                          suffixIcon: GestureDetector(
                            child: Icon(Icons.remove_red_eye),
                            onTap: () {
                              setState(() {
                                _showPassword2 = !_showPassword2;
                              });
                            },
                          ),
                          labelText: 'Password',
                          // errorText: _passwordTexts,
                          labelStyle: TextStyle(
                            fontFamily: 'Raleway',
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                        ),
                        obscureText: _showPassword2,
                        validator: valPassword,
                        // onChanged: (value) {
                        //   // setState(() {
                        //   _passwordErrors = false;
                        //   _passwordTexts = null;
                        //   // });
                        // },
                        onChanged: (value) {
                          _authData['password'] = value;
                          p_word = value;
                        },
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 240,
                height: (_authMode == AuthMode.Signup) ? 60 : 0,
                child: (_authMode == AuthMode.Login)
                    ? null
                    : TextFormField(
                        controller: _controller4,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                          ),
                          suffixIcon: GestureDetector(
                            child: Icon(Icons.remove_red_eye),
                            onTap: () {
                              setState(() {
                                _showPassword3 = !_showPassword3;
                              });
                            },
                          ),
                          labelText: 'Confirm Password',
                          // errorText: _cnfPasswordText,
                          labelStyle: TextStyle(
                            fontFamily: 'Raleway',
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                        ),
                        obscureText: _showPassword3,
                        validator: (value) => (value != _controller3s.text
                            ? 'Passwords do not match'
                            : null),
                        // onChanged: (value) {
                        //   // setState(() {
                        //   _cnfPasswordError = false;
                        //   _cnfPasswordText = null;
                        //   // });
                        // },
                      ),
              ),
              SizedBox(
                height: 15,
              ),
              (_authMode == AuthMode.Signup)
                  ? SizedBox(
                      height: 0,
                    )
                  : Container(
                      padding: EdgeInsets.only(bottom: 15),
                      child: InkWell(
                        child: Text(
                          ' Forgotten Password?',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.grey[900],
                            fontSize: 15,
                          ),
                        ),
                        onTap: () {
                          _resetPassword();
                        },
                      ),
                    ),
              if (_isLoading)
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
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
                        (_authMode == AuthMode.Login)
                            ? 'Login'
                            : (_authMode == AuthMode.Signup)
                                ? 'Signup'
                                : 'Create Password',
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
                          _submit();
                        }
                      },
                      // () {
                      //   print('Before submit');
                      //   _submit();
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => LocationScreen(),
                      //     ),
                      //   );
                      //   print('After submit');
                      // },
                    ),
                  ),
                ),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  text: _authMode == AuthMode.Login
                      ? 'New to Scrummy? '
                      : 'Already on Scrummy? ',
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontFamily: 'Raleway',
                    fontSize: 15,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: _authMode == AuthMode.Login ? ' Signup' : ' Login',
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
