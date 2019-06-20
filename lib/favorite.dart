import 'package:flutter/material.dart';
import 'package:ingredients/customview/meal_grid.dart';
import 'package:ingredients/model/food.dart';
import 'package:ingredients/service/favorite_service.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  var titles = ["Dessert", "Seafood"];
  List<Food> favoriteList = [];
  var currentTab = 0;

  void _reloadFavorite(int position) {
    setState(() {
      currentTab = position;
      favoriteList = FavoriteService.shared().getFavorites(titles[position]);
    });
  }

  @override
  void initState() {
    super.initState();
    _reloadFavorite(currentTab);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Makanan Favorit"),
            bottom: TabBar(
              tabs: [
                Tab(text: titles[0],),
                Tab(text: titles[1],),
              ],
              onTap: (position) => _reloadFavorite(position),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MealGrid(list: favoriteList,),
          )
      ),
    );
  }
}