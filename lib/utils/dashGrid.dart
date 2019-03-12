import "package:flutter/material.dart";

class DashGridPainter extends CustomPainter {
  String text;
  Color paintColor;
  //绘制的数量
  double dashCount;
  //单个dash长度
  double dashWidth;
  //box的宽
  double width;
  //dash的颜色
  final colorPainter = Paint();
  DashGridPainter({this.text, this.paintColor});

  @override
  void paint(Canvas canvas, Size size) {
    assert(paintColor != null);
    colorPainter.color = paintColor;
    colorPainter.strokeWidth = 1.5;
    width = size.width; 
    dashWidth = 4;
    dashCount = (width / (dashWidth));
    print(" dashcount  = $dashCount");
    drawLine(canvas, size);
  }
//画线部分
  void drawLine(Canvas canvas, Size size) {
    //总计绘制四条上下左右
    for (int x = 0; x < 4; x++) {
      double tempPoint = 0;
      double lastPoint = 0;
      for (int i = 1; i <= dashCount; i++) {
        tempPoint += dashWidth;
        if (i % 2 == 1) {
          drawlineDirection(canvas, lastPoint, tempPoint, colorPainter, x);
        } 
        lastPoint = tempPoint;
      }
    }
  }
//绘制各边的dash
  void drawlineDirection(Canvas canvas, double lastPoint, double tempPoint,
      Paint paint, int direction) {
    if (direction == 0) {
      canvas.drawLine(Offset(lastPoint, 0), Offset(tempPoint, 0), paint);
    } else if (direction == 1) {
      canvas.drawLine(
          Offset(lastPoint, width), Offset(tempPoint, width), paint);
    } else if (direction == 2) {
      canvas.drawLine(Offset(0, lastPoint), Offset(0, tempPoint), paint);
    } else {
      canvas.drawLine(
          Offset(width, lastPoint), Offset(width, tempPoint), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
