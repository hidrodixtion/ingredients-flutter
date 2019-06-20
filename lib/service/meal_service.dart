import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ingredients/model/food.dart';
import 'package:ingredients/model/food_detail.dart';

class MealService {
  // init singleton
  static final MealService _sh = new MealService._internal();
  static MealService shared() => _sh;
  MealService._internal();

  var _client = http.Client();
  set client(value) {
    _client = value;
  }

  var _baseUrl = "https://www.themealdb.com/api/json/v1/1";

  Future<List<Food>> getCategory(String category) async {
    final response = await _client.get("$_baseUrl/filter.php?c=$category");
    final body = json.decode(response.body);
    final list = body['meals'].map<Food>((item) => Food.fromJson(item)).toList();
    return list;
  }

  Future<FoodDetail> getDetail(String id) async {
    final response = await _client.get("$_baseUrl/lookup.php?i=$id");
    final body = json.decode(response.body);
    final data = FoodDetail.fromJson(body["meals"][0]);
    return data;
  }

  Future<List<FoodDetail>> findMeal(String search) async {
    final response = await _client.get("$_baseUrl/filter.php?s=$search");
    final body = json.decode(response.body);
    final list = body['meals'].map<FoodDetail>((item) => Food.fromJson(item)).toList();
    return list;
  }
}