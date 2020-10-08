import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scrummy/auth/auth_screen.dart';
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Http_Exceptions.dart';
import '../screens/reset_password.dart';
import '../screens/location_screen.dart';
import '../constants.dart';

String accessToken;
String refreshToken;

class Auth with ChangeNotifier {
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  String profName;
  String profEmail;
  // String kUrl = "a078d6616f5e";

  // String get token {
  //   if (_expiryDate != null &&
  //       _expiryDate.isAfter(DateTime.now()) &&
  //       accessToken != null) {
  //     return refreshToken;
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
  // final userData = json.encode(
  //   {
  //     'token': _token,
  //     'userId': _userId,
  //     'expiryDate': _expiryDate.toIso8601String()
  //   },
  // );
  // prefs.setString('userData', userData);
  //     print(responseData);
  //   } catch (error) {
  //     throw error;
  //   }
  // }
  Future<void> generateOtp(String email) async {
    final url = 'https://$kUrl.ngrok.io/api/otp/';
    try {
      final response = await http.post(url,
          body: json.encode(
            {"email": email},
          ),
          headers: {
            "content-type": "application/json",
            "accept": "application/json"
          });
      final responseData = json.decode(response.body);
      print(email);
      print(responseData);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<int> signup(String email, String password, String name) async {
    final url = "https://$kUrl.ngrok.io/api/signup/";
    int check = 0;
    try {
      final response = await http.post(url,
          body: json.encode({
            "email": email,
            "password": password,
            "Role": '1',
            "profile": {"name": name, "address": 'Arya Nagar'}
          }),
          headers: {
            "content-type": "application/json",
            "accept": "application/json"
          });
      print(email);
      print(check);
      final signupResponse = json.decode(response.body);
      print(signupResponse);
      if (response.body.isNotEmpty) {
        if (signupResponse["error"] != null) {
          check = -1;
          print(check);
          throw HttpException(signupResponse["error"]);
        }
      }
      print(check);
      // print(signupResponse.statusCode);
      notifyListeners();
    } catch (error) {
      throw error;
    }
    return check;
  }

  Future<int> checkVerify(String email, String password) async {
    int check = 0;
    final url = "https://$kUrl.ngrok.io/api/otp_verified/";
    try {
      final response = await http.post(url,
          body: json.encode({"email": email, "password": password}),
          headers: {
            "content-type": "application/json",
            "accept": "application/json"
          });
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData["error"] != null) {
        check = -1;
        throw HttpException(responseData["error"]);
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
    return check;
  }

  Future<int> verifyOtp(String otp) async {
    print(otp);
    print(e_mail);

    int check = 0;
    final url = "https://$kUrl.ngrok.io/api/verify_otp/";

    try {
      final response = await http.post(url,
          body: json.encode({"otp": otp, "otp_email": e_mail}),
          headers: {
            "content-type": "application/json",
            "accept": "application/json"
          });
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData["error"] != null) {
        check = -1;
        throw HttpException(responseData["error"]);
      }
      // print(responseData.statusCode);
      print(e_mail);
      print(otp);
      notifyListeners();
    } catch (error) {
      throw error;
    }
    return check;
  }

  Future<int> login() async {
    int check = 0;
    final url = "https://$kUrl.ngrok.io/api/login/";
    print(e_mail);
    print(p_word);
    try {
      final response = await http.post(url,
          body: json.encode({
            "email": e_mail,
            "password": p_word
            //'returnSecureToken': true
          }),
          headers: {
            "content-type": "application/json",
            "accept": "application/json"
          });
      // print(response.statusCode);
      final loginResponse = json.decode(response.body);
      print(loginResponse);
      if (response.body.isNotEmpty) {
        if (loginResponse["detail"] != null) {
          check = -1;
          throw HttpException(loginResponse["detail"]);
        }
      }

      accessToken = loginResponse["access"];
      refreshToken = loginResponse["refresh"];
      print(accessToken);
      print(refreshToken);
      _expiryDate = DateTime.now().add(Duration(minutes: 600));
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          "access": accessToken,
          "refresh": refreshToken,
          "expiryTime": _expiryDate.toIso8601String()
        },
      );

      prefs.setString('userData', userData);
      notifyListeners();
    } catch (error) {
      throw error;
    }
    return check;
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    print(extractedUserData);
    accessToken = extractedUserData['access'];
    refreshToken = extractedUserData['refresh'];
    notifyListeners();

    // final expiryTime = DateTime.parse(extractedUserData['expiryTime']);

    // if (expiryTime.isBefore(DateTime.now())) {

    //   return false;
    // }
    return true;
  }

  Future<void> saveLoc() async {
    final prefs = await SharedPreferences.getInstance();
    final userLoc = json.encode(
      {
        "location": addr2,
      },
    );
    prefs.setString('userLoc', userLoc);
    notifyListeners();
  }

  Future<int> passwordOtp(String otp) async {
    print(otp);
    print(e_mailReset);

    int check = 0;
    final url = "https://$kUrl.ngrok.io/api/passresetotp/";

    try {
      final response = await http.post(url,
          body: json.encode({"otp": otp, "email": e_mailReset}),
          headers: {
            "content-type": "application/json",
            "accept": "application/json"
          });
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData["error"] != null) {
        check = -1;
        throw HttpException(responseData["error"]);
      }
      // print(responseData.statusCode);
      print(e_mail);
      print(otp);
      notifyListeners();
    } catch (error) {
      throw error;
    }
    return check;
  }

  Future<int> resetOtp(String email) async {
    print(email);
    final url = 'https://$kUrl.ngrok.io/api/otp/';
    int check = 0;
    try {
      final response = await http.post(url,
          body: json.encode({'email': email}),
          headers: {
            "content-type": "application/json",
            "accept": "application/json"
          });
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.body.isNotEmpty) {
        if (responseData["error"] != null) {
          check = -1;
          throw HttpException(responseData["error"]);
        }
      }
      notifyListeners();
      print(email);
    } catch (error) {
      throw error;
    }
    return check;
  }

  Future<int> resetPwd(String password) async {
    int check = 0;
    final url = 'https://$kUrl.ngrok.io/api/resetpassword/';

    try {
      final response = await http.post(url,
          body: json.encode({"password": password, "email": e_mailReset}),
          headers: {
            "content-type": "application/json",
            "accept": "application/json"
          });
      final responseData = json.decode(response.body);
      notifyListeners();
      print(responseData);
      // if (response.body.isNotEmpty) {
      //   if (responseData["error"] != null) {
      //     check = -1;
      //     throw HttpException(responseData["error"]);
      //   }
      // }
    } catch (error) {
      throw error;
    }
    return check;
  }

  Future<void> getProfile() async {
    try {
      final url = 'https://$kUrl.ngrok.io/api/accounts/';
      final response = await http.get(url, headers: {
        "content-type": "application/json",
        "accept": "application/json",
        'Authorization': 'Bearer $accessToken',
      });
      final responseData = json.decode(response.body);
      profEmail = responseData["email"];
      profName = responseData["profile"]["name"];
      notifyListeners();
      print(responseData);
    } catch (error) {
      print(error);
    }
  }

  // Future<bool> autoLogin() async {
  //   final prefs = await SharedPreferences.getInstance();
  //     if (!prefs.containsKey('userData')) {
  //       return false;
  //   }
  //   final extractedUserData =
  //   json.decode(prefs.getString('userData')) as Map<String, Object>;
  //   //final url = 'https://$kUrl.ngrok.io/api/token/refresh/';

  //   // final response = await http.post(url,
  //   //     body: json.encode({"refresh": refreshToken}),
  //   //     headers: {
  //   //       "content-type": "application/json",
  //   //       "accept": "application/json"
  //   //     });
  //   // final responseData = json.decode(response.body);
  //   accessToken = extractedUserData["access"];
  //   refreshToken = extractedUserData["refresh"];
  //   print(accessToken);
  //   print(refreshToken);
  // }

// Future<bool> tryAutoLogin() async {
//   final prefs = await SharedPreferences.getInstance();
// if (!prefs.containsKey('userData')) {
//   return false;
// }
// final extractedUserData =
//     json.decode(prefs.getString('userData')) as Map<String, Object>;
// final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

// if (expiryDate.isBefore(DateTime.now())) {
//   return false;
// }

//   accessToken = extractedUserData['access'];
//   refreshToken = extractedUserData['refresh'];
//   _expiryDate = expiryDate;
//   notifyListeners();
//   _autoLogout();
//   return true;
// }
  bool get isAuth {
    print('Token');
    print(accessToken);
    print('Token');
    return accessToken != null;
  }

  void logout() async {
    accessToken = null;
    refreshToken = null;
    addr2 = null;
    // if (_authTimer != null) {
    //   _authTimer.cancel();
    //   _authTimer = null;
    // }
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
    notifyListeners();
  }

  // void _autoLogout() {
  //   if (_authTimer != null) {
  //     _authTimer.cancel();
  //   }
  //   final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
  //   _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  //}
}
