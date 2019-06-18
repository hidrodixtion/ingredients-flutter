import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final String item;

  Detail({@required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Bahan"),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Text(item),
      ),
    );
  }
}
