import 'package:flutter/foundation.dart';

class FoodDetail {
  final String name;
  final String image;
  final String instructions;
  final String area;

  FoodDetail(
      {@required this.name,
      @required this.image,
      @required this.instructions,
      @required this.area});

  FoodDetail.fromJson(json)
      : name = json["strMeal"],
        image = json["strMealThumb"],
        instructions = json["strInstructions"],
        area = json["strArea"];
}
