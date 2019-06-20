import 'package:flutter/material.dart';
import 'package:ingredients/customview/meal_grid.dart';
import 'package:ingredients/customview/my_progress_indicator.dart';
import 'package:ingredients/detail.dart';
import 'package:ingredients/search.dart';
import 'package:ingredients/service/meal_service.dart';

import 'model/food.dart';

class Menu extends StatefulWidget {

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Future<List<Food>> dessertFuture;
  Future<List<Food>> seafoodFuture;

  List<Food> currentList = [];

  int currentTab = 0;
  bool isLoading = true;
  final service = MealService.shared();

  void _openSearch() {
    final title = (currentTab == 0) ? "Cari Dessert" : "Cari Seafood";
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        Search(title: title, list: currentList,)));
  }

  @override
  void initState() {
    super.initState();
    dessertFuture = service.getCategory("dessert");
    seafoodFuture = service.getCategory("seafood");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bahan Makanan"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () => _openSearch(),)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: (currentTab == 0) ? dessertFuture : seafoodFuture,
          builder: (context, AsyncSnapshot<List<Food>> snapshot) {
            if (snapshot.hasData) {
              currentList = snapshot.data;
              return MealGrid(list: snapshot.data);
            }

            return MyProgressIndicator(info: "Memuat Daftar Makanan",);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.cake), title: Text("Dessert")),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood), title: Text("Seafood")),
        ],
        currentIndex: currentTab,
        onTap: (position) {
          setState(() {
            currentTab = position;
          });
        },
      ),
    );
  }
}