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
  Future<List<Food>> dessertFuture;
  Future<List<Food>> seafoodFuture;

  int currentTab = 0;
  bool isLoading = true;
  final service = MealService.shared();

  @override
  void initState() {
    super.initState();
    dessertFuture = service.getCategory("dessert");
    seafoodFuture = service.getCategory("seafood");
  }

  Widget _buildMealGrid(List<Food> currentList) {
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
          child: FutureBuilder(
            future: (currentTab == 0) ? dessertFuture : seafoodFuture,
            builder: (context, AsyncSnapshot<List<Food>> snapshot) {
              if (snapshot.hasData) {
                return _buildMealGrid(snapshot.data);
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
      ),
    );
  }
}
