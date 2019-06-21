import 'package:flutter/material.dart';

class MyProgressIndicator extends StatelessWidget {
  final String info;

  MyProgressIndicator({@required this.info}): assert(info != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Container(height: 8,),
        Text(info, key: Key("progress_info")),
      ],
    );
  }
}