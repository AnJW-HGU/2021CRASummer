import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';

import 'rank_page.dart';


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
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                color: themeColor1,
                icon: Icon(Icons.arrow_back_ios_new_rounded, size: 15.w),
              ),
              backgroundColor: Colors.white,
              title: Text(
                "포인트",
                style: TextStyle(
                    fontFamily: "Barun",
                    color: grayColor1,
                    fontSize: 15.sp
                ),
              ),
              centerTitle: true,
              elevation: 0.0,
              actions: <Widget>[
                IconButton( // 랭킹
                    icon: Icon(Icons.public_rounded, size: 21.w, color: themeColor1),
                    onPressed: () {
                      Get.to(RankPage());
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
          padding: EdgeInsets.only(top: 30.w, bottom: 30.w),
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
                  Padding(padding: EdgeInsets.only(left: 15.w)),
                  Text(
                    point.toString(),
                    style: TextStyle(
                        fontFamily: "Barun",
                        fontSize: 30.w,
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
                  padding: EdgeInsets.all(30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("포인트에 대한 규칙 또는 방법?", style: TextStyle(fontFamily: "Barun", color: Colors.white),),
                      Padding(
                        padding: EdgeInsets.all(5.w),
                      ),
                      Text("얻을 수 있는 방법", style: TextStyle(fontFamily: "Barun", color: Colors.white),)
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