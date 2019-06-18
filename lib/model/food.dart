import 'package:flutter/foundation.dart';

class Food {
  final String name;
  final String image;
  final String ingredients;

  Food({@required this.name, @required this.image, @required this.ingredients});

  Food.fromJson(Map json)
      : name = json["product_name"],
        image = json["front"],
        ingredients = json["ingredients"];
}
