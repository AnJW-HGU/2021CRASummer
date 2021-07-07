import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studytogether/main.dart';

class PointPage extends StatefulWidget {

  @override
  _PointPageState createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(411.4, 683.4),
        builder: () {
          return Scaffold(
            backgroundColor: themeColor1,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "포인트", style: TextStyle(color: grayColor1, fontSize: 17),),
              iconTheme: IconThemeData(
                color: themeColor1,
              ),
              centerTitle: true,
              elevation: 0.0,
              actions: <Widget>[
                IconButton( // 랭킹
                    icon: Icon(Icons.ac_unit_rounded, size: 21,),
                    onPressed: () {
                    }
                ),
              ],
            ),
            body: _pointPageBody(),
          );
        });
  }

  Widget _pointPageBody() {
    int point = 3000;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 30, bottom: 30),
          height: 150.0,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: blurColor,
                blurRadius: 4,
                offset: Offset(0.0, 3.0),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.circle, color: themeColor3,),
                  Padding(padding: EdgeInsets.only(left: 15)),
                  Text(
                    point.toString(),
                    style: TextStyle(
                        fontSize: 30,
                        color: grayColor1,
                        shadows: [Shadow(
                          color: blurColor,
                          offset: Offset(0, 4.0),
                          blurRadius: 4,
                        )
                        ]
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("포인트에 대한 규칙 또는 방법?", style: TextStyle(color: Colors.white),),
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Text("얻을 수 있는 방법", style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ),
                ],
              )
          ],
        )
      ],
    );
  }
}