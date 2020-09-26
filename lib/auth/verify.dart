import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/location_screen.dart';
import 'auth.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();

  var _isLoading = false;
  Map<String, String> _verifyData = {
    'otp': '',
  };

  Future<void> _verifyOtp() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .verifyOtp(_verifyData['otp']);

      await Provider.of<Auth>(context, listen: false).login();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LocationScreen(),
        ),
      );
    } catch (error) {
      throw error;
    }

    _isLoading = false;
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
                'Confirm your email',
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
                            Icons.vpn_key,
                          ),
                          labelText: 'Enter OTP',
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
                          _verifyData['otp'] = value;
                        },
                      ),
                    ),
                    Text(
                      'We have sent an OTP on your email',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_isLoading)
                      CircularProgressIndicator(
                        backgroundColor: Colors.orange,
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
                              'Confirm',
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
            ],
          ),
        ),
      ),
    );
  }
}
