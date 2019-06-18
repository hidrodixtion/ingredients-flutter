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
  List<Food> list = List();

  void loadData() async {
    var data =
        await DefaultAssetBundle.of(context).loadString("assets/data.json");
    final result = json.decode(data);

    final foodList =
        result['data'].map<Food>((item) => Food.fromJson(item)).toList();
    setState(() {
      list = foodList;
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
                                item: list[position],
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
                    child: Image.network(
                      list[position].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            itemCount: list.length,
          ),
        ),
      ),
    );
  }
}
