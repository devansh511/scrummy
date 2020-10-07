import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../constants.dart';

class FoodDetails with ChangeNotifier {
  int id;
  String name;
  String image;
  int price;
  int rating;
  int offer;
  String category;
  String cuisine;
  int deliveryTime;
  int restName;

  FoodDetails({
    this.id,
    this.name,
    this.image,
    this.price,
    this.rating,
    this.offer,
    this.category,
    this.cuisine,
    this.deliveryTime,
    this.restName,
  });
}

class Food with ChangeNotifier {
  List loadedFoods = [];

  Future<void> fetchFood() async {
    final url = "http://$kUrl.ngrok.io/api/foodlist/";

    try {
      final response = await http.get(url);
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
      print(loadedFoods);
      print(loadedFoods.length);
      // loadedFoods = parsedJson.map((i)=>Food.fromJson(i)).toList();
      notifyListeners();
      //print(FoodDetails.foodName);
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchCuisines(String cuisine) async {
    final url = "http://$kUrl.ngrok.io/api/foodlist/$cuisine/";

    try {
      final response = await http.get(url);
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
      print(loadedFoods);
      print(loadedFoods.length);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}

class Restaurant with ChangeNotifier {
  List loadedRestaurants = [];
  List loadedRestFood = [];

  Future<void> fetchRestaurants() async {
    try {
      final url = "http://$kUrl.ngrok.io/api/restaurantlist/";
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      final responseData = json.decode(response.body);
      responseData.forEach((rData) {
        loadedRestaurants.add([
          rData["id"].toString(),
          rData["restaurent_name"],
          rData["wallpaper"],
          rData["ratings"],
        ]);
      });
      print(responseData);
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchRestFood(String restName) async {
    try {
      final url = "http://$kUrl.ngrok.io/api/foodlist/$restName/";
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      final responseData = json.decode(response.body);
      print(responseData);
      loadedRestFood.clear();
      responseData.forEach((fData) {
        loadedRestFood.add([
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
    } catch (error) {
      print(error);
    }
  }
}
