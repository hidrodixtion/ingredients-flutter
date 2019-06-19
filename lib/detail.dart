import 'package:flutter/material.dart';

import 'model/food.dart';

class Detail extends StatefulWidget {
  final Food item;
  final String tag;

  Detail({@required this.item, @required this.tag});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showSnackbar(String item) {
    var snackbar = SnackBar(content: Text("Anda memilih : $item"),);
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showSnackbar(widget.item.name));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Detail Bahan"),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Hero(
              tag: widget.tag,
              child: Image.network(
                widget.item.image,
                width: 256,
                height: 256,
              ),
            ),
            Container(
              height: 8,
            ),
            Text(
              widget.item.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Container(
              height: 16,
            ),
            Text(
              widget.item.ingredients,
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
