import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:get/get.dart';

import 'package:studytogether/main.dart';

import 'package:studytogether/Profile//point_page.dart';
import 'package:studytogether/Profile/Settings/setting_page.dart';
import 'package:studytogether/Profile/myA_page.dart';
import 'package:studytogether/Profile/myQ_page.dart';
import 'Manage/manageMain_page.dart';


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
  // 뱃지 이미지 리스트
  // List<Widget> images = new List<Widget>();
  // images.add(Image.asset('', height: ,));

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
              icon: Icon(Icons.arrow_back_ios_new_rounded, size: 15.w,),
            ),
            title: Text(
              '프로필',
              style: TextStyle(
                  fontFamily: "Barun",
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
              ),
            ),
            backgroundColor: themeColor1,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.settings_rounded, size: 27.w,),
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
        // 상단 파란색 컨테이너
        Container(
          padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: blurColor,
                blurRadius: 4,
                offset: Offset(0.0, 3.0),
              ),
            ],
            color: themeColor1,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
          ),
          child: Column(
            children: <Widget>[
              // 프로필 사진
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4,
                      color: blurColor,
                    ),
                  ]
                ),
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: themeColor3,
                  child: CircleAvatar(
                    radius: 33,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              // 닉네임
              Padding(padding: EdgeInsets.only(top: 10),
                child: Text(_nickName, style: TextStyle(
                  fontFamily: "Barun",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),),
              ),
              // 구분선
              Padding(padding: EdgeInsets.only(top: 20.0),
                child: Container(
                  width: 360.w,
                  height: 1,
                  color: themeColor3,
                ),
              ),
              // 구분선 아래 버튼 4개(포인트, 질문, 답변, 스터디)
              Container(
                padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _textButton("포인트", _point, PointPage()),
                    _textButton("질문", _questionNum, MyQPage()),
                    _textButton("답변", _answerNum, MyAPage()),
                    TextButton(onPressed: (){},
                      child: Text("스터디", style: TextStyle(fontFamily: "Barun", fontSize: 13.sp, color: themeColor3),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 30.0),),
        // 뱃지함
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                width: 350.w,
                decoration: BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: blurColor,
                    //     blurRadius: 4,
                    //     offset: Offset(0.0, 3.0),
                    //   ),
                    // ],
                    color: themeColor4,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.only(top: 30.0, bottom: 30.0, right: 40.0.w, left: 40.0.w),
                  // 뱃지함 내부의 뱃지
                  child: GridView.extent(
                    shrinkWrap: true,
                    maxCrossAxisExtent: 48.0.w,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 13.0.w,
                    childAspectRatio: 1.0,
                    children: List.generate(8, (index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.all(Radius.circular(5.0))
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Positioned(
                  left: 5.0,
                  top: -5.0,
                  child: Icon(
                    Icons.bookmark_rounded,
                    size: 33.0.w,
                    color: themeColor1,
              ),),
            ],
          )
        ),
        // 뱃지함 아래 padding 조절(뱃지함 크기 조절)
        Padding(padding: EdgeInsets.only(bottom: 220.0)),
        TextButton(
          onPressed: () {
            Get.to(ManageMainPage());
          },
          child: Text("일단 버튼"),
        ),
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
              Padding(padding: EdgeInsets.only(left: 10.0.w)),
              Text(num.toString(), style: TextStyle(
                fontFamily: "Barun",
                fontSize: 17.sp,
                color: Colors.white,
              ),),
            ],
          )
      ),
    );
  }
}

