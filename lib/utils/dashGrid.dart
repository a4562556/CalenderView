import "package:flutter/material.dart";

class DashGridPainter extends CustomPainter{

  String text;
  int dashCount;
  DashGridPainter({this.text});

  @override
  void paint(Canvas canvas, Size size) {
        final dashWidth = 6;
        final blackPainter = Paint();
        final whitePainter = Paint();
        whitePainter.color =Colors.white;
        blackPainter.color = Colors.black;
        dashCount = (size.width / (2 * dashWidth)) as int;
        int tempPoint=0;
        int lastPoint = 0;
        //画top
        for(int i=1;i<=dashCount;i++){
          tempPoint += dashWidth;
          if(i%2==1){
            canvas.drawLine(Offset(lastPoint.toDouble(), 0), Offset(tempPoint.toDouble(), 0), blackPainter);
          }else{
            canvas.drawLine(Offset(lastPoint.toDouble(), 0), Offset(tempPoint.toDouble(), 0), blackPainter);
          }
          lastPoint = tempPoint;
        }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate!=this;
  }

}