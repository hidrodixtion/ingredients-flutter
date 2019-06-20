import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ingredients/customview/my_progress_indicator.dart';
import 'package:ingredients/detail.dart';
import 'package:ingredients/model/food.dart';
import 'package:ingredients/service/meal_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Food> dessert = List();
  List<Food> seafood = List();
  List<Food> currentList = List();

  int currentTab = 0;
  bool isLoading = true;
  final service = MealService.shared();

  void loadData() async {
    dessert = await service.getCategory("dessert");
    seafood = await service.getCategory("seafood");
    setState(() {
      currentList = dessert;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Widget _buildMealGrid() {
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
                  item: currentList[position],
                  tag: "product_$position",
                ),
              ),
            ),
            customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Colors.black45,
                title: Text(currentList[position].name),
              ),
              child: Hero(
                tag: "product_$position",
                child: Image.network(
                  currentList[position].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: currentList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bahan Makanan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Bahan Makanan"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading ? MyProgressIndicator(info: "Memuat Daftar Makanan",) : _buildMealGrid()
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
              currentList = (position == 0) ? dessert : seafood;
            });
          },
        ),
      ),
    );
  }
}
