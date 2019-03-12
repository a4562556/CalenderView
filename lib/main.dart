import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'CalenderView.dart';
import 'WeekView.dart';
import 'utils/dashGrid.dart';

void main() => runApp(Navigatetor(window.defaultRouteName));

Widget Navigatetor(String routeName) {
  switch (routeName) {
    default:
      return MaterialApp(
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  int nowMonth = 0;
  int nowYear = 0;

  @override
  void initState() {
    super.initState();
    getCurrentTime();
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
                                nowMonth--;
                                switchYear();
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
                              nowMonth++;
                               switchYear();
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
                  child: CustomPaint(
                    size: Size(40, 40),
                    painter:DashGridPainter(text: "",paintColor:Color.fromRGBO(255, 143, 68, 1.0)),
                  ),
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.blue))),
    );
  }

  void getCurrentTime() {
    var date = DateTime.now();
    this.nowMonth = date.month;
    this.nowYear = date.year;
  }

  void switchYear() {
    if (nowMonth < 1) {
      nowYear--;
      nowMonth = 12;
    } else if (nowMonth > 12) {
      nowYear++;
      nowMonth=1;
    }
  }
}
