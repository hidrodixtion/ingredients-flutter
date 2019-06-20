import 'package:flutter/foundation.dart';

class Food {
  final String name;
  final String image;
  final String ingredients;
  final String id;
  final String category;

  Food(
      {@required this.name,
      @required this.image,
      this.ingredients,
      @required this.id,
      @required this.category});

  Food.fromJson(Map json, String category)
      : name = json["strMeal"],
        image = json["strMealThumb"],
        ingredients = json["ingredients"],
        id = json["idMeal"],
        category = category;

  Map toJson() {
    var map = Map();
    map["strMeal"] = name;
    map["strMealThumb"] = image;
    map["idMeal"] = id;
    return map;
  }
}
