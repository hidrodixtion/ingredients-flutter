import 'package:flutter/material.dart';
import 'package:ingredients/customview/my_progress_indicator.dart';
import 'package:ingredients/model/food_detail.dart';
import 'package:ingredients/service/favorite_service.dart';
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
  final favService = FavoriteService.shared();
  var isLoading = true;
  FoodDetail detail;
  bool isFavorite = false;

  void _showSnackbar(String item) {
    var snackbar = SnackBar(content: Text("Anda memilih : $item"),);
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _loadData() async {
    detail = await MealService.shared().getDetail(widget.item.id);
    setState(() {
      isLoading = false;

      // check whether this item already added as a favorite.
      isFavorite = favService.isFavorite(widget.item.category, widget.item.id);
    });
  }

  void _toggleFavorite() {
    if (isFavorite) {
      favService.removeFavorite(widget.item.category, widget.item.id);
    } else {
      favService.addNewFavorite(widget.item.category, widget.item);
    }

    setState(() {
      isFavorite = !isFavorite;
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
        actions: <Widget>[
          IconButton(icon: Icon(isFavorite ? Icons.star : Icons.star_border), onPressed: () => _toggleFavorite(),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading ? MyProgressIndicator(info: "Memuat Detail",) : _buildInfo()
      ),
    );
  }
}
