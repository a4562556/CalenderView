import "package:flutter/material.dart";

class DashGridPainter extends CustomPainter{

  String text;
  double dashCount;
  DashGridPainter({this.text});

  @override
  void paint(Canvas canvas, Size size) {
        final dashWidth = 4;
        final blackPainter = Paint();
        final whitePainter = Paint();
        whitePainter.color =Colors.white;
        blackPainter.color = Color.fromRGBO(255, 153, 85, 1.0);
        dashCount = (size.width / (dashWidth));
        double tempPoint=0;
        double lastPoint = 0;
        //画top
        for(int i=1;i<=dashCount;i++){
          tempPoint += dashWidth;
          if(i%2==1){
            canvas.drawLine(Offset(lastPoint, 0), Offset(tempPoint, 0), blackPainter);
          }else{
            canvas.drawLine(Offset(lastPoint, 0), Offset(tempPoint, 0), whitePainter);
          }
          lastPoint = tempPoint;
        }
        print(" dashcount  = $dashCount");

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate!=this;
  }

}