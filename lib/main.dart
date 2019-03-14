import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'CalenderView.dart';
import 'WeekView.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'models/SignedDay.dart';
void main() => runApp(navigator(window.defaultRouteName));

Widget navigator(String stringData) {
    //  stringData = "{\"data\":[{\"year\":2019,\"month\":3,\"day\":1}]}"; 
     if(stringData=='/'){
       stringData = "{\"data\":[]}";
     }
      return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(signedDays:SignedDay.getList(json.decode(stringData))),
      );
}

class Home extends StatefulWidget {
  final List<SignedDay> signedDays;

  Home({this.signedDays});

  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  //全局key
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  //指示器当前月
  int nowMonth = 0;
  //指示器当前年
  int nowYear = 0;
  //指示器当前日期对象
  DateTime dateTime;

  @override
  void initState() {
    //初始化获取当前日期
    getCurrentTime();
    //预加载签到图片
    _loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      key: _key,
      appBar: new AppBar(
        title: Text("CalenderView"),
        centerTitle: true,
      ),
      body: new Container(
          margin: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          width: 500,
          height: 500,
          child: Center(
            child: Column(
              children: <Widget>[
                //顶栏
                Container(
                  width: 500,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    gradient: LinearGradient(
                      // Where the linear gradient begins and ends
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      // Add one stop for each color. Stops should increase from 0 to 1
                      stops: [0.1, 0.2, 0.3, 0.4],
                      colors: [
                        // Colors are easy thanks to Flutter's Colors class.
                        Color.fromRGBO(255, 173, 119, 1.0),
                        Color.fromRGBO(255, 163, 102, 1.0),
                        Color.fromRGBO(255, 153, 85, 1.0),
                        Color.fromRGBO(255, 143, 68, 1.0),
                      ],
                    ),
                  ),
                  //星期栏
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.arrow_left,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                switchTime(-1);
                              });
                            }),
                        Text(
                          nowYear.toString() + "年" + nowMonth.toString() + "月",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_right,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                               switchTime(1);
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  width: 500,
                  height: 40,
                  child: drawWeek(context),
                  decoration: BoxDecoration(color: Colors.white),
                ),
                Container(
                  width: 500,
                  height: 400,
                  child: MyCalenderView(nowDate: dateTime,image: this._image,signedDays: widget.signedDays),
                )

              ],
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }

  //签到图片
  ui.Image _image;

  //加载返回assets文件夹里的图片
  Future<ui.Image> loadImage(ByteData data) async {
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  //预加载图片若成功加载则刷新当前页
  _loadImage() async{
    final byteData =await rootBundle.load("assets/signed.png");
    final _image = await loadImage(byteData);
    setState(() {
     this._image = _image;
    });
  }

  //获取当前日期
  void getCurrentTime() {
    var date = DateTime.now();
    this.nowMonth = date.month;
    this.nowYear = date.year;
    dateTime = DateTime(nowYear,nowMonth);
  }
  //当操作指示器时切换对应的年月
  void switchTime(int dx) {
    nowMonth+=dx;
    if (nowMonth < 1) {
      nowYear--;
      nowMonth = 12;
    } else if (nowMonth > 12) {
      nowYear++;
      nowMonth=1;
    }
    dateTime = DateTime(nowYear,nowMonth);
  }
}
