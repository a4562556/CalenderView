import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'utils/DashGrid.dart';
import 'models/SignedDay.dart';

class MyCalenderView extends StatefulWidget {
  final DateTime nowDate;
  final ui.Image image;
  final List<SignedDay> signedDays;

  MyCalenderView({this.nowDate, this.image, this.signedDays});

  @override
  State<StatefulWidget> createState() => new _MyCalenderView();
}

class _MyCalenderView extends State<MyCalenderView> {
  //每个月的天数
  List<int> days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 7,
      children: _build(widget.nowDate),
    );
  }

  List<Widget> _build(DateTime date) {
    List<Widget> items = new List();
    int j = 0, i = 0, x = 0;
    //星期日作为一周的第一天
    if (date.weekday != DateTime.sunday) {
      //如果该月1日不为星期日则打印占位格子
      for (; j < date.weekday; j++) {
        items.add(build_grid_item(0, false));
      }
    }
    //如果为闰年则二月有29天
    if (isLeapYear(date.year) && date.month == DateTime.february) {
      for (; i < days[date.month - 1] + 1; i++) {
        final day = i + 1;
        items.add(
            build_grid_item(day, getIsSignedDay(date.year, date.month, day)));
      }
    } else {
      for (; i < days[date.month - 1]; i++) {
        final day = i + 1;
        items.add(
            build_grid_item(day, getIsSignedDay(date.year, date.month, day)));
      }
    }
    //绘制剩余的格子
    final remained = 7 - ((j + i) % 7);
    if (remained != 7) {
      for (; x < remained; x++) {
        items.add(build_grid_item(0, false));
      }
    }

    return items;
  }

  //构建每个格子
  Widget build_grid_item(int day, bool isSigned) {
    return Container(
      child: CustomPaint(
        size: Size(45, 45),
        painter: DashGridPainter(
            text: day == 0 ? "" : day.toString(),
            paintColor: Color.fromRGBO(255, 143, 68, 1.0),
            isSign: isSigned,
            image: widget.image),
      ),
    );
  }

  bool getIsSignedDay(int year, int month, int day) {
    bool flag = false;
    for (var i in widget.signedDays) {
      if (year == i.year && month == i.month && day == i.day) {
        flag = true;
      }
    }
    return flag;
  }

  bool isLeapYear(int year) {
    if (year % 100 != 0 && year % 4 == 0 ||
        year % 100 == 0 && year % 400 == 0) {
      return true;
    }
    return false;
  }
}
