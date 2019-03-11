import 'package:flutter/material.dart';


class MyCalenderView extends StatefulWidget{
    
    final DateTime nowDate;
    MyCalenderView({this.nowDate});
  @override
  State<StatefulWidget> createState()
      =>new _MyCalenderView();
 
}
class _MyCalenderView extends State<MyCalenderView>{


 
 
  @override
  Widget build(BuildContext context) {  

    return ListView.builder(
       itemBuilder: (BuildContext context,int position){
         return null;
       },
    ); 
  }

  Widget _buildRow(DateTime date,int position){
    int year = date.year;
    if(isLeapYear(year)){


    }
    return null;
  }

  bool isLeapYear(int year){ 
    if(year%100!=0&&year%4==0||year%100==0&&year%400==0){
      return true;
    } 
    return false;
  }




}