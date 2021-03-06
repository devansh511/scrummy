import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:http/http.dart' as https;
import 'package:async/async.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

class Search extends ChangeNotifier {
  List searchedFoods = [];

  Future<int> searchFood(String food) async {
    print("searching food");
    try {
      print("try of search");
      final url = "https://$kUrl.ngrok.io/api/foodlist/$food/";
      final response = await https.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });

      print("search complete");
      final responseData = json.decode(response.body);
      searchedFoods.clear();
      responseData.forEach((sData) {
        searchedFoods.add([
          sData["id"].toString(),
          sData["name"],
          sData["image"],
          sData["price"].toString(),
          sData["ratings"].toString(),
          sData["delivery_time"].toString(),
          sData["restname"],
          sData["cuisine"],
          sData["rest_foods_id"].toString(),
          sData["offer"].toString(),
        ]);
      });
      notifyListeners();
      print(responseData);
      return 1;
    } catch (error) {
      print(error);
    }
  }

  void allClear() {
    print('clearing the list');
    searchedFoods.clear();
    notifyListeners();
  }
}
