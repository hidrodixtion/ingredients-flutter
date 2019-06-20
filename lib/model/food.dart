import 'package:flutter/foundation.dart';

class Food {
  final String name;
  final String image;
  final String ingredients;
  final String id;

  Food(
      {@required this.name,
      @required this.image,
      this.ingredients,
      @required this.id});

  Food.fromJson(Map json)
      : name = json["strMeal"],
        image = json["strMealThumb"],
        ingredients = json["ingredients"],
        id = json["idMeal"];
}
