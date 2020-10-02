import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class FoodDetails with ChangeNotifier {
  final String foodId,
      foodUrl,
      foodName,
      deliveryTime,
      foodRating,
      foodPrice,
      offer,
      category,
      cuisine,
      imageUrl;

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
  List loadedFoods = [];

  // List get item {
  //   return loadedFoods;
  // }

  Future<void> fetchFood() async {
    final url = "http://6e4186ddc042.ngrok.io/api/foodlist/";

    try {
      final response = await http.get(url);
      var extractedData =
          json.decode(response.body); // as Map<String, dynamic>;
      print(extractedData);
      if (extractedData == null) {
        return;
      }

      extractedData.forEach((fData) {
        loadedFoods.add([
          fData["id"].toString(),
          fData["name"],
          fData["url"],
          fData["price"].toString(),
          fData["image"]
        ]);
      });
      // items = loadedFoods;
      print(loadedFoods);
      print(loadedFoods.length);
      // loadedFoods = parsedJson.map((i)=>Food.fromJson(i)).toList();
      notifyListeners();
      //print(FoodDetails.foodName);
    } catch (error) {
      throw error;
    }
  }
}
