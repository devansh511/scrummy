import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'dart:convert';
import 'dart:async';
import 'package:provider/provider.dart';
import '../constants.dart';

// class FoodDetails with ChangeNotifier {
//   int id;
//   String name;
//   String image;
//   int price;
//   int rating;
//   int offer;
//   String category;
//   String cuisine;
//   int deliveryTime;
//   int restName;

//   FoodDetails({
//     this.id,
//     this.name,
//     this.image,
//     this.price,
//     this.rating,
//     this.offer,
//     this.category,
//     this.cuisine,
//     this.deliveryTime,
//     this.restName,
//   });
// }

class Food with ChangeNotifier {
  List loadedFoods = [];

  Future<void> fetchFood() async {
    final url = "https://$kUrl.ngrok.io/api/foodlist/";

    try {
      final response = await https.get(url);
      print(response.body);
      var extractedData =
          json.decode(response.body); // as Map<String, dynamic>;
      // print(extractedData);
      if (extractedData == null) {
        return;
      }
      loadedFoods.clear();
      extractedData.forEach((fData) {
        loadedFoods.add([
          fData["id"].toString(),
          fData["name"],
          fData["image"],
          fData["price"].toString(),
          fData["rating"],
          fData["offer"],
          fData["category"],
          fData["cuisine"],
          fData["delivery_time"],
          fData["restname"],
        ]);
      });
      notifyListeners();
      print(loadedFoods);
      print(loadedFoods.length);
      // loadedFoods = parsedJson.map((i)=>Food.fromJson(i)).toList();
      //print(FoodDetails.foodName);
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchCuisines(String cuisine) async {
    final url = "https://$kUrl.ngrok.io/api/foodlist/$cuisine/";

    try {
      final response = await https.get(url);
      print(response.body);
      var extractedData = json.decode(response.body);
      // print(extractedData);
      if (extractedData == null) {
        return;
      }
      loadedFoods.clear();
      extractedData.forEach((fData) {
        loadedFoods.add([
          fData["id"].toString(),
          fData["name"],
          fData["image"],
          fData["price"].toString(),
          fData["ratings"].toString(),
          fData["offer"],
          fData["category"],
          fData["cuisine"],
          fData["delivery_time"].toString(),
          fData["restname"],
        ]);
      });
      notifyListeners();
      print(loadedFoods);
      print(loadedFoods.length);
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  List loadedRestaurants = [];

  Future<void> fetchRestaurants() async {
    try {
      final url = "https://$kUrl.ngrok.io/api/restaurantlist/";
      final response = await https.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      final responseData = json.decode(response.body);
      loadedRestaurants.clear();
      responseData.forEach((rData) {
        loadedRestaurants.add([
          rData["id"].toString(),
          rData["restaurent_name"],
          rData["wallpaper"],
          rData["ratings"],
        ]);
      });
      notifyListeners();
      print(responseData);
    } catch (error) {
      print(error);
    }
  }

  Future<int> fetchRestFood(String restName) async {
    try {
      final url = "https://$kUrl.ngrok.io/api/foodlist/$restName/";
      final response = await https.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      final responseData = json.decode(response.body);
      print(responseData);
      loadedFoods.clear();
      responseData.forEach((fData) {
        loadedFoods.add([
          fData["id"].toString(),
          fData["name"],
          fData["image"],
          fData["price"].toString(),
          fData["ratings"].toString(),
          fData["offer"],
          fData["category"],
          fData["cuisine"],
          fData["delivery_time"].toString(),
          fData["restname"],
        ]);
      });
      notifyListeners();
      print(loadedFoods);
      return 2;
    } catch (error) {
      print(error);
    }
  }
}
