import 'dart:convert';

import 'package:ingredients/model/food.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static final FavoriteService _sh = new FavoriteService._internal();
  static FavoriteService get shared => _sh;

  FavoriteService._internal() {
    _initSharedPreference();
  }

  SharedPreferences _pref;

  void _initSharedPreference() async {
    _pref = await SharedPreferences.getInstance();
  }

  List<Food> getFavorites(String category) {
    var strData = _pref.getString("fav_$category");
    if (strData == null) {
      return [];
    }

    var data = json.decode(strData);
    return data.map<Food>((item) => Food.fromJson(item, category)).toList();
  }

  void removeFavorite(String category, String id) {
    var list = getFavorites(category);
    list.removeWhere((item) => item.id == id);
    _saveFavorites(category, list);
  }

  void addNewFavorite(String category, Food food) {
    var list = getFavorites(category);
    list.add(food);
    print(list);
    _saveFavorites(category, list);
  }

  bool isFavorite(String category, String id) {
    var list = getFavorites(category);
    var index = list.indexWhere((item) => item.id == id);
    return index >= 0;
  }

  void _saveFavorites(String category, List<Food> newList) async {
    await _pref.setString("fav_$category", json.encode(newList));
  }
}