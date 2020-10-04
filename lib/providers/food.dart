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
  List loadedItalian = [];
  List loadedPunjabi = [];
  List loadedNonVeg = [];
  List loadedSweets = [];
  List loadedNorth = [];
  List loadedSouth = [];
  List loadedChinese = [];

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

  // Future<void> fetchChinese() async {
  //   final url = "http://$kUrl.ngrok.io/api/foodlist/chinese/";

  //   try {
  //     final response = await http.get(url);
  //     print(response.body);
  //     var extractedData =
  //         json.decode(response.body); // as Map<String, dynamic>;
  //     // print(extractedData);
  //     if (extractedData == null) {
  //       return;
  //     }
  //     loadedFoods.clear();
  //     extractedData.forEach((fData) {
  //       loadedFoods.add([
  //         fData["id"].toString(),
  //         fData["name"],
  //         fData["image"],
  //         fData["price"].toString(),
  //         fData["rating"],
  //         fData["offer"],
  //         fData["category"],
  //         fData["cuisine"],
  //         fData["delivery_time"],
  //         fData["restname"],
  //       ]);
  //     });
  //     print(loadedFoods);
  //     print(loadedFoods.length);
  //     // loadedFoods = parsedJson.map((i)=>Food.fromJson(i)).toList();
  //     notifyListeners();
  //     //print(FoodDetails.foodName);
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  // Future<void> fetchNorth() async {
  //   final url = "http://$kUrl.ngrok.io/api/foodlist/north%20indian/";

  //   try {
  //     final response = await http.get(url);
  //     print(response.body);
  //     var extractedData =
  //         json.decode(response.body); // as Map<String, dynamic>;
  //     // print(extractedData);
  //     if (extractedData == null) {
  //       return;
  //     }
  //     loadedFoods.clear();
  //     extractedData.forEach((fData) {
  //       loadedFoods.add([
  //         fData["id"].toString(),
  //         fData["name"],
  //         fData["image"],
  //         fData["price"].toString(),
  //         fData["rating"],
  //         fData["offer"],
  //         fData["category"],
  //         fData["cuisine"],
  //         fData["delivery_time"],
  //         fData["restname"],
  //       ]);
  //     });
  //     print(loadedFoods);
  //     print(loadedFoods.length);
  //     // loadedFoods = parsedJson.map((i)=>Food.fromJson(i)).toList();
  //     notifyListeners();
  //     //print(FoodDetails.foodName);
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  // Future<void> fetchItalian() async {
  //   final url = "http://$kUrl.ngrok.io/api/foodlist/italian/";

  //   try {
  //     final response = await http.get(url);
  //     print(response.body);
  //     var extractedData =
  //         json.decode(response.body); // as Map<String, dynamic>;
  //     // print(extractedData);
  //     if (extractedData == null) {
  //       return;
  //     }
  //     loadedFoods.clear();
  //     extractedData.forEach((fData) {
  //       loadedFoods.add([
  //         fData["id"].toString(),
  //         fData["name"],
  //         fData["image"],
  //         fData["price"].toString(),
  //         fData["rating"],
  //         fData["offer"],
  //         fData["category"],
  //         fData["cuisine"],
  //         fData["delivery_time"],
  //         fData["restname"],
  //       ]);
  //     });
  //     print(loadedFoods);
  //     print(loadedFoods.length);
  //     // loadedFoods = parsedJson.map((i)=>Food.fromJson(i)).toList();
  //     notifyListeners();
  //     //print(FoodDetails.foodName);
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  // Future<void> fetchSouth() async {
  //   final url = "http://$kUrl.ngrok.io/api/foodlist/south%20indian/";

  //   try {
  //     final response = await http.get(url);
  //     print(response.body);
  //     var extractedData =
  //         json.decode(response.body); // as Map<String, dynamic>;
  //     // print(extractedData);
  //     if (extractedData == null) {
  //       return;
  //     }
  //     loadedFoods.clear();
  //     extractedData.forEach((fData) {
  //       loadedFoods.add([
  //         fData["id"].toString(),
  //         fData["name"],
  //         fData["image"],
  //         fData["price"].toString(),
  //         fData["rating"],
  //         fData["offer"],
  //         fData["category"],
  //         fData["cuisine"],
  //         fData["delivery_time"],
  //         fData["restname"],
  //       ]);
  //     });
  //     print(loadedFoods);
  //     print(loadedFoods.length);
  //     // loadedFoods = parsedJson.map((i)=>Food.fromJson(i)).toList();
  //     notifyListeners();
  //     //print(FoodDetails.foodName);
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  // Future<void> fetchNonVeg() async {
  //   final url = "http://$kUrl.ngrok.io/api/foodlist/non-veg/";

  //   try {
  //     final response = await http.get(url);
  //     print(response.body);
  //     var extractedData =
  //         json.decode(response.body); // as Map<String, dynamic>;
  //     // print(extractedData);
  //     if (extractedData == null) {
  //       return;
  //     }
  //     loadedFoods.clear();
  //     extractedData.forEach((fData) {
  //       loadedFoods.add([
  //         fData["id"].toString(),
  //         fData["name"],
  //         fData["image"],
  //         fData["price"].toString(),
  //         fData["rating"],
  //         fData["offer"],
  //         fData["category"],
  //         fData["cuisine"],
  //         fData["delivery_time"],
  //         fData["restname"],
  //       ]);
  //     });
  //     print(loadedFoods);
  //     print(loadedFoods.length);
  //     // loadedFoods = parsedJson.map((i)=>Food.fromJson(i)).toList();
  //     notifyListeners();
  //     //print(FoodDetails.foodName);
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  // Future<void> fetchPunjabi() async {
  //   final url = "http://$kUrl.ngrok.io/api/foodlist/punjabi/";

  //   try {
  //     final response = await http.get(url);
  //     print(response.body);
  //     var extractedData =
  //         json.decode(response.body); // as Map<String, dynamic>;
  //     // print(extractedData);
  //     if (extractedData == null) {
  //       return;
  //     }
  //     loadedFoods.clear();
  //     extractedData.forEach((fData) {
  //       loadedFoods.add([
  //         fData["id"].toString(),
  //         fData["name"],
  //         fData["image"],
  //         fData["price"].toString(),
  //         fData["rating"],
  //         fData["offer"],
  //         fData["category"],
  //         fData["cuisine"],
  //         fData["delivery_time"],
  //         fData["restname"],
  //       ]);
  //     });
  //     print(loadedFoods);
  //     print(loadedFoods.length);
  //     // loadedFoods = parsedJson.map((i)=>Food.fromJson(i)).toList();
  //     notifyListeners();
  //     //print(FoodDetails.foodName);
  //   } catch (error) {
  //     throw error;
  //   }
  // }
}
