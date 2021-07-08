import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:get/get.dart';

import 'package:studytogether/main.dart';
import 'package:studytogether/Profile//point_page.dart';
import 'package:studytogether/Profile/Settings/setting_page.dart';


class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.4, 683.4),
      builder: () {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white,
              size: 21.w,
            ),
            title: Text('프로필', style: TextStyle(fontFamily: "Barun", color: Colors.white, fontSize: 25.w),),
            backgroundColor: themeColor1,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.settings_rounded, size: 21.w,),
                  onPressed: () {
                    Get.to(SettingPage());
                  }
              ),
            ],
          ),
          body: _profilePageBody(),
        );

      }

    );
  }

  Widget _profilePageBody() {
    String _nickName = "자유로운 도비";
    String _point = "3000";
    String _questionNum = "2";
    String _answerNum = "5";

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
          height: 200.0,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: blurColor,
                blurRadius: 4,
                offset: Offset(0.0, 3.0),
              ),
            ],
            color: themeColor1,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          ),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 35,
                backgroundColor: themeColor3,
                child: CircleAvatar(
                  radius: 34,
                  backgroundColor: Colors.white,
                ),
              ),
              Padding(padding: EdgeInsets.all(4.w)),
              Text(_nickName, style: TextStyle(
                  fontFamily: "Barun",
                  fontSize: 15.w,
                  color: Colors.white,
                  shadows: [Shadow(
                    color: blurColor,
                    offset: Offset(0,4.0),
                    blurRadius: 4,
                  )]),),
              Padding(padding: EdgeInsets.all(5.0.w)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {
                    Get.to(PointPage());
                  },
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Text("포인트", style: TextStyle(fontFamily: "Barun", fontSize: 13.w, color: themeColor3),),
                            Padding(padding: EdgeInsets.all(5.0.w)),
                            Text(_point, style: TextStyle(
                              fontFamily: "Barun",
                              fontSize: 20.w,
                              color: Colors.white,
                            ),),
                          ],
                        ),
                      ),
                  ),
                    TextButton(onPressed: () {
                    },
                        child: Container(
                          child: Row(
                            children: <Widget>[
                             Text("질문", style: TextStyle(fontFamily: "Barun", fontSize: 13.w, color: themeColor3),),
                              Padding(padding: EdgeInsets.all(5.0.w)),
                             Text(_questionNum, style: TextStyle(
                            fontFamily: "Barun",
                            fontSize: 20.w,
                            color: Colors.white,
                            ),),
                          ],
                        ),
                      ),
                    ),
                  TextButton(onPressed: (){
                  },
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text("답변", style: TextStyle(fontFamily: "Barun", fontSize: 13.w, color: themeColor3),),
                          Padding(padding: EdgeInsets.all(5.0.w)),
                          Text(_answerNum, style: TextStyle(
                            fontFamily: "Barun",
                            fontSize: 20.w,
                            color: Colors.white,
                          ),),
                        ],
                      )
                    ),
                  ),
                  TextButton(onPressed: (){
                  },
                  child: Text("스터디", style: TextStyle(fontFamily: "Barun", fontSize: 13.w, color: themeColor3),),
                    ),
                 ],
              ),
            ],
          ),
        )
      ]
    );
  }
}

