import 'package:flutter/material.dart';
import 'package:ingredients/detail.dart';
import 'package:ingredients/model/food.dart';

class MealGrid extends StatelessWidget {
  final List<Food> list;

  MealGrid({@required this.list}): assert(list != null);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
      itemBuilder: (context, position) {
        return Material(
          type: MaterialType.card,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Detail(
                  item: list[position],
                  tag: "product_$position",
                ),
              ),
            ),
            customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Colors.black45,
                title: Text(list[position].name),
              ),
              child: Hero(
                tag: "product_$position",
                child: Image.network(
                  list[position].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: list.length,
    );
  }
}