import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final String title;
  final String category;

  Search({@required this.title, @required this.category})
      : assert(title != null),
        assert(category != null);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              style: Theme.of(context).textTheme.title,
            ),
            Container(height: 8,),

          ],
        ),
      ),
    );
  }
}
