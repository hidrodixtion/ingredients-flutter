import 'package:flutter/material.dart';
import 'package:ingredients/customview/meal_grid.dart';
import 'package:ingredients/model/food.dart';
import 'package:ingredients/model/food_detail.dart';

class Search extends StatefulWidget {
  final String title;
  final List<Food> list;

  Search({@required this.title, @required this.list})
      : assert(title != null),
        assert(list != null);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController controller = TextEditingController();
  List<Food> searchResult = [];

  void _searchList() {
    setState(() {
      searchResult = [];
      searchResult = widget.list
          .where((item) =>
              item.name.toLowerCase().contains(controller.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Ayam",
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    style: Theme.of(context).textTheme.title,
                    controller: controller,
                  ),
                ),
                Container(
                  width: 8,
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  color: Theme.of(context).accentColor,
                  onPressed: () => _searchList(),
                )
              ],
            ),
            Container(
              height: 8,
            ),
            Expanded(
              child: MealGrid(
                list: searchResult,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
