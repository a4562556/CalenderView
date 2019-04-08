import 'package:flutter/material.dart';

final _textStyle =
    TextStyle(fontSize: 15, color: Color.fromRGBO(255, 153, 85, 1.0));
final chineseWeek = ["日","一","二","三","四","五","六"];

Widget drawWeek(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: buildWeek());
}

 List<Widget> buildWeek(){ 
  return chineseWeek.map((item){
   return Text(item,style: _textStyle);
  }).toList();
  
}
