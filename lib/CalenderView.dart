import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'utils/dashGrid.dart';
class MyCalenderView extends StatefulWidget {
  final DateTime nowDate;
  final ui.Image image;

  MyCalenderView({this.nowDate, this.image});

  @override
  State<StatefulWidget> createState() => new _MyCalenderView();
}

class _MyCalenderView extends State<MyCalenderView> {
  //每个月的天数
  List<int> days = [31,28,31,30,31,30,31,31,30,31,30,31];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 7,
        children: _build(widget.nowDate),
    );
  }


  List<Widget> _build(DateTime date) {
    List <Widget> items = new List();
    //星期日作为一周的第一天
    if(date.weekday!=DateTime.sunday){
      //如果该月1日不为星期日则打印占位格子
      for(int j = 0; j<date.weekday;j++){
        items.add(_build_blank());
      }
    }
    //如果为闰年则二月有29天
    if (isLeapYear(date.year)&&date.month==DateTime.february) {
      for(int i = 0;i<days[date.month-1]+1;i++){
            items.add(_build_grid_item(i+1));
      }
    }else{
      for(int i = 0;i<days[date.month-1];i++){
          items.add(_build_grid_item(i+1));
      }
    }
    return items;
  }
  //构建每个格子
  Widget _build_grid_item(int day){
    return Container(
      child: CustomPaint(
        size: Size(45, 45),
        painter:DashGridPainter(text: day.toString(),
            paintColor:Color.fromRGBO(255, 143, 68, 1.0),
            isSign: false,
            image: widget.image),
      ),
    );
  }

  Widget _build_blank(){
    return Container(
       width: 45,
       height: 45,

    );
  }



  bool isLeapYear(int year) {
    if (year % 100 != 0 && year % 4 == 0 || year % 100 == 0 && year % 400 == 0) {
      return true;
    }
    return false;
  }
}
