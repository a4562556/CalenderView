import "package:flutter/material.dart";
import 'dart:ui' as ui;
class DashGridPainter extends CustomPainter {
  //需要绘制的文本
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
  //是否标记
  bool isSign;
  //预先加载图片
  ui.Image image;

  DashGridPainter({this.text, this.paintColor,this.isSign,this.image});

  @override
  void paint(Canvas canvas, Size size) {
    assert(paintColor != null);
    colorPainter.color = paintColor;
    colorPainter.strokeWidth = 1.5;
    width = size.width; 
    dashWidth = 4;
    dashCount = (width / (dashWidth)); 
    drawDash(canvas, size);
    final textPainter = TextPainter(text:TextSpan(text: this.text,style: TextStyle(color: paintColor,fontSize: 20)),textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 30); 
    final xCenterPoint = (width-10)/2;
    final yCenterPoint = (width-20)/2;
    textPainter.paint(canvas, Offset(xCenterPoint, yCenterPoint));
    //绘制签到标记
    if(isSign){
       canvas.drawImage(this.image, Offset(0, 0), colorPainter);
    }
    
  }
//画线部分
  void drawDash(Canvas canvas, Size size) {
    //总计绘制四条上下左右
    for (int x = 0; x < 4; x++) {
      double tempPoint = 0;
      double lastPoint = 0;
      for (int i = 1; i <= dashCount; i++) {
        tempPoint += dashWidth;
        if (i % 2 == 1) {
          drawDashDirection(canvas, lastPoint, tempPoint, colorPainter, x);
        } 
        lastPoint = tempPoint;
      }
    }
  }
//绘制各边的dash
  void drawDashDirection(Canvas canvas, double lastPoint, double tempPoint,
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
