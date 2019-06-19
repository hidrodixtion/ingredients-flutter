import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ingredients/detail.dart';
import 'package:ingredients/model/food.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Food> breakfast = List();
  List<Food> dessert = List();
  List<Food> currentList = List();

  int currentTab = 0;

  void loadData() async {
    var data =
        await DefaultAssetBundle.of(context).loadString("assets/data.json");
    final result = json.decode(data);

    breakfast = result['breakfast']
        .map<Food>((item) => Food.fromJson(item))
        .toList();
    dessert = result['dessert']
        .map<Food>((item) => Food.fromJson(item))
        .toList();
    setState(() {
      currentList = breakfast;
    });
  }

  @override
  void initState() {
    super.initState();

    loadData();
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
          child: GridView.builder(
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
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.free_breakfast), title: Text("Breakfast")),
            BottomNavigationBarItem(
                icon: Icon(Icons.cake), title: Text("Dessert")),
          ],
          currentIndex: currentTab,
          onTap: (position) {
            setState(() {
              currentTab = position;
              currentList = (position == 0) ? breakfast : dessert;
            });
          },
        ),
      ),
    );
  }
}
