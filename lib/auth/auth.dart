import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scrummy/auth/auth_screen.dart';
import 'dart:convert';
import 'dart:async';
import './auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Http_Exceptions.dart';

class Auth with ChangeNotifier {
  String _accessToken;
  String _refreshToken;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  String _extractedEmail;

  // bool get isAuth {
  //   return token != null;
  // }

  // String get token {
  //   if (_expiryDate != null &&
  //       _expiryDate.isAfter(DateTime.now()) &&
  //       _token != null) {
  //     return _token;
  //   }
  //   return null;
  // }

  // String get userId {
  //   return _userId;
  // }

  // Future<void> _authenticate(String email, String password, String name) async {
  //   final url = 'https://d3cc68b4c9f1.ngrok.io/api/createaccount/';

  //   var body = {};
  //   body = {
  //     'email': 'kumardevansh8@gmail.com',
  //     'Role': '1',
  //     'password': '1234567',
  //     "profile": {"name": 'Devansh', "address": 'Arya Nagar'}
  //   };

  //   try {
  //     final response = await http.post(url, body: json.encode(body), headers: {
  //       "content-type": "application/json",
  //       "accept": "application/json"
  //     });
  //     print(response);
  //     final responseData = json.decode(response.body);
  //     if (responseData['error'] != null) {
  //       throw HttpException(
  //         responseData['error']['message'],
  //       );
  //     }
  //     _token = responseData['idToken'];
  // _userId = responseData['localId'];
  // _expiryDate = DateTime.now().add(
  //   Duration(
  //     seconds: int.parse(
  //       responseData['expiresIn'],
  //     ),
  //   ),
  // );
  //     // _autoLogout();
  //     notifyListeners();
  //     final prefs = await SharedPreferences.getInstance();
  //     final userData = json.encode(
  //       {
  //         'token': _token,
  //         'userId': _userId,
  //         'expiryDate': _expiryDate.toIso8601String()
  //       },
  //     );
  //     prefs.setString('userData', userData);
  //     print(responseData);
  //   } catch (error) {
  //     throw error;
  //   }
  // }
  // Future<void> generateOtp(String email) async {
  //   // String get Email {
  //   // return _extractedEmail;
  //   // }
  //   print(_extractedEmail);
  //   _extractedEmail = email;
  //   final url = 'https://265e3fa01612.ngrok.io/api/otp/';
  //   try {
  //     final response = await http.post(url,
  //         body: json.encode(
  //           {'email': email},
  //         ),
  //         headers: {
  //           "content-type": "application/json",
  //           "accept": "application/json"
  //         });
  //     final responseData = json.decode(response.body);
  //     print(email);
  //     print(responseData);
  //     notifyListeners();
  //   } catch (error) {
  //     throw (error);
  //   }
  // }

  Future<void> signup(String email, String password, String name) async {
    final url = 'https://21239aebfd0f.ngrok.io/api/signup/';
    try {
      final response = await http.post(url,
          body: json.encode(
            {
              'email': email,
              'password': password,
              'Role': '1',
              'profile': {'name': name, 'address': 'Arya Nagar'}
            },
          ),
          headers: {
            "content-type": "application/json",
            "accept": "application/json"
          });
      // final responseData = json.decode(response.body);
      // print(email);
      if (response.body.isNotEmpty) {
        final signupResponse = json.decode(response.body);
        print(signupResponse);
      }
    } catch (error) {
      throw error;
    }
  }
  // print(email);
  // print(password);
  // print(name);

  Future<void> verifyOtp(String otp) async {
    final url = 'https://21239aebfd0f.ngrok.io/api/verify_otp/';
    print(e_mail);
    try {
      final response = await http.post(url,
          body: json.encode({'otp': otp, 'otp_email': e_mail}),
          headers: {
            "content-type": "application/json",
            "accept": "application/json"
          });
      final responseData = json.decode(response.body);

      print(otp);

      print(responseData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> login() async {
    final url = 'https://21239aebfd0f.ngrok.io/api/login/';
    print(e_mail);
    print(p_word);
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': e_mail,
            'password': p_word
            //'returnSecureToken': true
          }),
          headers: {
            "content-type": "application/json",
            "accept": "application/json"
          });
      // final responseData = json.decode(response.body);
      if (response.body.isNotEmpty) {
        final loginResponse = json.decode(response.body);
        _accessToken = loginResponse['access'];
        _refreshToken = loginResponse['refresh'];
        print(loginResponse);
      }
      print(_accessToken);
      print(_refreshToken);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}

// Future<void> login(String email, String password) async {
//   return _authenticate(email, password);
// }

// Future<bool> tryAutoLogin() async {
//   final prefs = await SharedPreferences.getInstance();
//   if (!prefs.containsKey('userData')) {
//     return false;
//   }
//   final extractedUserData =
//       json.decode(prefs.getString('userData')) as Map<String, Object>;
//   final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

//   if (expiryDate.isBefore(DateTime.now())) {
//     return false;
//   }

//   _token = extractedUserData['token'];
//   _userId = extractedUserData['userId'];
//   _expiryDate = expiryDate;
//   notifyListeners();
//   _autoLogout();
//   return true;
// }

// void logout() async {
//   _token = null;
//   _userId = null;
//   _expiryDate = null;
//   if (_authTimer != null) {
//     _authTimer.cancel();
//     _authTimer = null;
//   }
//   notifyListeners();
//   final prefs = await SharedPreferences.getInstance();
//   // prefs.remove('userData');
//   prefs.clear();
// }

// void _autoLogout() {
//   if (_authTimer != null) {
//     _authTimer.cancel();
//   }
//   final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
//   _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
// }
// }
