import 'package:flutter/material.dart';
import 'package:ingredients/menu.dart';
import 'package:ingredients/service/favorite_service.dart';

void main() {
  // make sure to initialise the favorite service first.
  FavoriteService.shared();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bahan Makanan',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Menu(),
    );
  }
}