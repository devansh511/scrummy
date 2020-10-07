import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:http/http.dart' as https;
import 'dart:convert';
import '../auth/auth.dart';
import '../constants.dart';

// class CartItem {
//   final String id;
//   final String token;
//   // final int quantity;
//   // final double price;

//   CartItem({
//     @required this.id,
//     @required this.token,
//     // @required this.quantity,
//     // @required this.price,
//   });
// }
String quant = "1";

class Cart with ChangeNotifier {
  List loadedFoods = [];

  Future<int> isAdded(String foodId) async {
    int check = 0;
    try {
      final url =
          "https://$kUrl.ngrok.io/api/orderstatus/${int.parse(foodId)}/";
      final response = await https.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData["details"] == "item in your cart") {
        check = -1;
      } else {
        check = 1;
      }
    } catch (error) {
      print(error);
    }
    return check;
  }

  Future<void> addToCart(String foodId) async {
    print(foodId);
    print("executing addToCart");
    try {
      print("try executing");
      final url =
          "https://$kUrl.ngrok.io/api/add-to-cart/${int.parse(foodId)}/";
      final response = await https.post(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      final responseData = json.decode(response.body);
      notifyListeners();
      print(responseData);
    } catch (error) {
      print('An error occured');
      print(error);
    }
  }

  Future<void> increaseQuantity(String foodId) async {
    try {
      final url =
          "https://$kUrl.ngrok.io/api/add-to-cart/${int.parse(foodId)}/";
      final response = await https.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      final responseData = json.decode(response.body);
      quant = responseData["quantity"].toString();
      notifyListeners();
      print(responseData);
    } catch (error) {
      print(error);
    }
  }

  Future<void> decreaseQuantity(String foodId) async {
    try {
      final url =
          "https://$kUrl.ngrok.io/api/add-to-cart/${int.parse(foodId)}/";
      final response = await https.patch(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      final responseData = json.decode(response.body);
      quant = responseData["quantity"].toString();
      notifyListeners();
      print(responseData);
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteItems(String foodId) async {
    try {
      final url =
          "https://$kUrl.ngrok.io/api/add-to-cart/${int.parse(foodId)}/";
      final response = await https.delete(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      final responseData = json.decode(response.body);
      notifyListeners();
      print(responseData);
    } catch (error) {
      print(error);
    }
  }

  Future<void> emptyCart() async {
    try {
      final url = "https://$kUrl.ngrok.io/api/add-to-cart/clearcart/";
      final response = await https.delete(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      final responseData = json.decode(response.body);
      notifyListeners();
      print(responseData);
    } catch (error) {
      print(error);
    }
  }

  Future<void> displayCart() async {
    print("executing display cart");
    try {
      print("try executing");
      final url = "https://$kUrl.ngrok.io/api/cart/show/";
      final response = await https.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      print('This is response $response');
      final responseData = json.decode(response.body);
      print('This is responsedata $responseData');
      if (responseData == null) {
        print('null data');
        return;
      }
      loadedFoods.clear();
      responseData.forEach((fData) {
        loadedFoods.add([
          fData["id"].toString(),
          fData["item_name"],
          fData["image"],
          fData["get_total_item_price"].toString(),
          fData["delivery_time"],
          fData["offer"],
        ]);
      });
      notifyListeners();
      print(loadedFoods);
    } catch (error) {
      print(error);
    }
  }
}

// class Checkout with ChangeNotifier {
//   Future<void> checkout() async {
//     try {} catch (error) {
//       print(error);
//     }
//   }
// }
