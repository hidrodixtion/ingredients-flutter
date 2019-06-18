import 'package:flutter/material.dart';

import 'model/food.dart';

class Detail extends StatelessWidget {
  final Food item;

  Detail({@required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Bahan"),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Image.network(item.image, width: 256, height: 256,),
            Container(height: 8,),
            Text(item.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
            Container(height: 16,),
            Text(item.ingredients, textAlign: TextAlign.justify,)
          ],
        ),
      ),
    );
  }
}
