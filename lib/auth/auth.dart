import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

enum AuthMode { Login, Signup }

class AuthScreen extends StatelessWidget {
  AuthMode _authMode = AuthMode.Signup;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: deviceSize.height * 2,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 100, bottom: 30),
          child: _authMode == AuthMode.Login ? AuthLogin() : AuthSignup(),
        ),
      ),
    );
  }
}

class AuthLogin extends StatefulWidget {
  @override
  _AuthLoginState createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
  AuthMode _authMode = AuthMode.Login;

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

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey();
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
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        SizedBox(
          height: 80,
        ),
        Text(
          'Login into your account',
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
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person_outline,
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontFamily: 'Raleway',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                      )),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Invalid Email';
                    }
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
                      )),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
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
              SizedBox(
                height: 15,
              ),
              Container(
                width: 240,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: FlatButton(
                    color: Colors.orange,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  text: 'New to Scrummy? ',
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontFamily: 'Raleway',
                    fontSize: 15,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Sign Up',
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

class AuthSignup extends StatefulWidget {
  @override
  _AuthSignupState createState() => _AuthSignupState();
}

class _AuthSignupState extends State<AuthSignup> {
  @override
  Widget build(BuildContext context) {
    AuthMode _authMode = AuthMode.Signup;

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
          'Create your account',
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
          child: Column(
            children: <Widget>[
              Container(
                width: 240,
                height: 60,
                child: TextFormField(
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
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 240,
                height: 60,
                child: TextFormField(
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
                      )),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Invalid Email';
                    }
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
                      )),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 240,
                height: 60,
                child: TextFormField(
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
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 240,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: FlatButton(
                    color: Colors.orange,
                    child: Text(
                      'Signup',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontFamily: 'Raleway',
                    fontSize: 15,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Login',
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
