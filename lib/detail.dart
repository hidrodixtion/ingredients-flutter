import 'package:flutter/material.dart';
import 'package:ingredients/customview/my_progress_indicator.dart';
import 'package:ingredients/model/food_detail.dart';
import 'package:ingredients/service/meal_service.dart';

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
  var isLoading = true;
  FoodDetail detail;

  void _showSnackbar(String item) {
    var snackbar = SnackBar(content: Text("Anda memilih : $item"),);
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _loadData() async {
    detail = await MealService.getDetail(widget.item.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showSnackbar(widget.item.name));

    _loadData();
  }

  Widget _buildInfo() {
    return ListView(
      children: <Widget>[
        Hero(
          tag: widget.tag,
          child: Image.network(
            detail.image,
            width: 256,
            height: 256,
          ),
        ),
        Container(
          height: 8,
        ),
        Text(
          "${detail.area} ${detail.name}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Container(
          height: 16,
        ),
        Text(
          detail.instructions,
          textAlign: TextAlign.justify,
        )
      ],
    );
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
        child: isLoading ? MyProgressIndicator(info: "Memuat Detail",) : _buildInfo();
      ),
    );
  }
}
