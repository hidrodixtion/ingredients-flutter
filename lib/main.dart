import 'package:flutter/material.dart';
import 'package:ingredients/detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final list = [
    "Chicken",
    "Salmon",
    "Beef",
    "Pork",
    "Avocado",
    "Apple Cidar Vinegar",
    "Asparagus"
  ];

  // This widget is the root of your application.
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
          body: ListView.builder(
            itemBuilder: (context, pos) {
              return ListTile(
                title: Text(list[pos]),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(
                              item: list[pos],
                            ),
                      ),
                    ),
              );
            },
            itemCount: list.length,
          ),
        ));
  }
}
