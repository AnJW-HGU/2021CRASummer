import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:get/get.dart';

import 'package:studytogether/main.dart';
import 'package:studytogether/Profile//point_page.dart';
import 'package:studytogether/Profile/Settings/setting_page.dart';
import 'package:studytogether/Profile/myA_page.dart';
import 'package:studytogether/Profile/myQ_page.dart';


class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String _nickName = "자유로운도비영혼"; // 서버에서 받아온 닉네임
  int _point = 3000;
  int _questionNum = 2;
  int _answerNum = 5;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.4, 683.4),
      builder: () {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              color: Colors.white,
              icon: Icon(Icons.arrow_back_ios_new_rounded, size: 21.w,),
            ),
            title: Text(
              '프로필',
              style: TextStyle(
                  fontFamily: "Barun",
                  color: Colors.white,
                  fontSize: 25.sp
              ),
            ),
            backgroundColor: themeColor1,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.settings_rounded, size: 21.w,),
                  onPressed: () {
                    Get.to(SettingPage(), arguments: _nickName);
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
    return Column(
      children: [
        Container( // 상단 파란색 컨테이너
          padding: EdgeInsets.only(top: 10, bottom: 10),
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
              // 프로필 사진
              CircleAvatar(
                radius: 35,
                backgroundColor: themeColor3,
                child: CircleAvatar(
                  radius: 34,
                  backgroundColor: Colors.white,
                ),
              ),
              Padding(padding: EdgeInsets.all(4.w)),
              // 닉네임
              Text(_nickName, style: TextStyle(
                  fontFamily: "Barun",
                  fontSize: 15.sp,
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
                  _textButton("포인트", _point, PointPage()),
                  _textButton("질문", _questionNum, MyAPage()),
                  _textButton("답변", _answerNum, MyQPage()),
                  TextButton(onPressed: (){
                  },
                    child: Text("스터디", style: TextStyle(fontFamily: "Barun", fontSize: 13.sp, color: themeColor3),),
                    ),
                 ],
              ),
            ],
          ),
        )
      ]
    );
  }
  Widget _textButton(context, num, Next) {
    return TextButton(
      onPressed: () {
        Get.to(Next);
      },
      child: Container(
          child: Row(
            children: <Widget>[
              Text(context, style: TextStyle(fontFamily: "Barun", fontSize: 13.sp, color: themeColor3),),
              Padding(padding: EdgeInsets.all(5.0.w)),
              Text(num.toString(), style: TextStyle(
                fontFamily: "Barun",
                fontSize: 20.sp,
                color: Colors.white,
              ),),
            ],
          )
      ),
    );
  }
}

