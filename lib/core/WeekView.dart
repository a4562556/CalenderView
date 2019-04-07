import 'package:flutter/material.dart';

final _textStyle =
    TextStyle(fontSize: 15, color: Color.fromRGBO(255, 153, 85, 1.0));
Widget drawWeek(BuildContext context) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("日", style: _textStyle),
          Text("一", style: _textStyle),
          Text("二", style: _textStyle),
          Text("三", style: _textStyle),
          Text("四", style: _textStyle),
          Text("五", style: _textStyle),
          Text("六", style: _textStyle)
        ],
      );
    },
  );
}
