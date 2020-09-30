import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class FoodDetails {
  final String foodId;
  final String foodUrl;
  final String foodName;
  final String deliveryTime;
  final String foodRating;
  final String foodPrice;
  final String offer;
  final String category;
  final String cuisine;
  final String imageUrl;

  FoodDetails(
      {@required this.foodId,
      @required this.foodUrl,
      @required this.foodName,
      this.deliveryTime,
      this.foodRating,
      @required this.foodPrice,
      this.offer,
      this.category,
      this.cuisine,
      @required this.imageUrl});
}

class Food with ChangeNotifier {
  List<FoodDetails> _items = [];

  List<FoodDetails> get items {
    return [..._items];
  }

  Future<void> _fetchFood() async {
    final url = "https://cabff666799b.ngrok.io/api/foodlist/";

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      List<FoodDetails> loadedFoods = [];
      extractedData.forEach((fId, foodData) {
        loadedFoods.add(FoodDetails(
          foodId: fId,
          foodUrl: foodData["url"],
          foodName: foodData["name"],
          foodPrice: foodData["price"],
          imageUrl: foodData["image"],
        ));
      });
      _items = loadedFoods;
      notifyListeners();
      //print(FoodDetails.foodName);
    } catch (error) {
      throw error;
    }
  }
}
