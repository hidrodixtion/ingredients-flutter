import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ingredients/model/food.dart';
import 'package:ingredients/model/food_detail.dart';

class MealService {
  static var _baseUrl = "https://www.themealdb.com/api/json/v1/1";

  static Future<List<Food>> getCategory(String category) async {
    final response = await http.get("$_baseUrl/filter.php?c=$category");
    final body = json.decode(response.body);

    final list = body['meals'].map<Food>((item) => Food.fromJson(item)).toList();
    return list;
  }

  static Future<FoodDetail> getDetail(String id) async {
    final response = await http.get("$_baseUrl/lookup.php?i=$id");
    final body = json.decode(response.body);

    final data = FoodDetail.fromJson(body["meals"][0]);
    return data;
  }
}