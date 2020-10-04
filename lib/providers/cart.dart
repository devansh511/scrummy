import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
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

class Cart with ChangeNotifier {
  Future<void> addToCart(String foodId) async {
    print("executing addToCart");
    try {
      print("try executing");
      final url = "http://$kUrl.ngrok.io/api/add-to-cart/${int.parse(foodId)}/";
      final response = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      final responseData = json.decode(response.body);
      print(responseData);
    } catch (error) {
      print('An error occured');
      print(error);
    }
  }
}

// class Cart1 with ChangeNotifier {
//   Map<String, CartItem> _items = {};

//   Map<String, CartItem> get items {
//     return {..._items};
//   }

//   int get itemCount {
//     return _items.length;
//   }

//   double get totalAmount {
//     var total = 0.0;
//     _items.forEach((key, cartItem) {
//       total += cartItem.price * cartItem.quantity;
//     });
//     return total;
//   }

//   void addItem(
//     String productId,
//     double price,
//     String token,
//   ) {
//     if (_items.containsKey(productId)) {
//       // change quantity...
//       _items.update(
//         productId,
//         (existingCartItem) => CartItem(
//           id: existingCartItem.id,
//           token: existingCartItem.token,
//           price: existingCartItem.price,
//           quantity: existingCartItem.quantity + 1,
//         ),
//       );
//     } else {
//       _items.putIfAbsent(
//         productId,
//         () => CartItem(
//           id: DateTime.now().toString(),
//           token: token,
//           price: price,
//           quantity: 1,
//         ),
//       );
//     }
//     notifyListeners();
//   }

//   void removeItem(String productId) {
//     _items.remove(productId);
//     notifyListeners();
//   }

//   void removeSingleItem(String productId) {
//     if (!_items.containsKey(productId)) {
//       return;
//     }
//     if (_items[productId].quantity > 1) {
//       _items.update(
//         productId,
//         (existingCartItem) => CartItem(
//           id: existingCartItem.id,
//           token: existingCartItem.token,
//           price: existingCartItem.price,
//           quantity: existingCartItem.quantity - 1,
//         ),
//       );
//     } else {
//       _items.remove(productId);
//     }
//     notifyListeners();
//   }

//   void clear() {
//     _items = {};
//     notifyListeners();
//   }
// }
