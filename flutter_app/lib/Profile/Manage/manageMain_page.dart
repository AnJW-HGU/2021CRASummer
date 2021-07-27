import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:get/get.dart';

import 'package:studytogether/main.dart';
import 'etc_page.dart';
import 'bug_page.dart';
import 'declaration_page.dart';
import 'named_page.dart';
import 'manageAsk_page.dart';

import 'usersInfo_page.dart';

class ManageMainPage extends StatefulWidget {
  @override
  _ManageMainPageState createState() => _ManageMainPageState();
}

class _ManageMainPageState extends State<ManageMainPage> {
  // 오늘 날짜
  String date = "2021.07.26";
  // 상단 버튼의 각 갯수
  int named_num = 0; // 네임드
  int declaration_num = 10; // 신고
  int bug_num = 2; // 버그
  int ask_num = 3; // 건의사항
  int ect_num = 0; // 기타
  // 하단 버튼의 각 갯수
  int all_num = 20; // 전체 문의
  int new_num = 15; // 신규 문의
  int finish_num = 5; // 완료 문의

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
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 15.w,
                ),
              ),
              centerTitle: true,
              title: Text(
                date,
                style: TextStyle(
                  fontFamily: "Barun",
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              backgroundColor: themeColor1,
              elevation: 0.0,
            ),
            body: _manageMainPageBody(),
          );
        });
  }

  Widget _manageMainPageBody() {
    return Column(
      children: <Widget>[
        // 상단 파란색 컨테이너
        Container(
          padding: EdgeInsets.only(top: 5.0, bottom: 30.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: blurColor,
                blurRadius: 4,
                offset: Offset(0.0, 3.0),
              ),
            ],
            color: themeColor1,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
          ),
          child: Column(
            // 파란색 컨테이너 내부 위젯
            children: [
              Container(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _button("네임드", named_num, NamedPage()),
                    Padding(padding: EdgeInsets.all(15.0)),
                    _button("신고", declaration_num, DeclarationPage()),
                    Padding(padding: EdgeInsets.all(15.0)),
                    _button("버그", bug_num, BugPage()),
                    Padding(padding: EdgeInsets.all(15.0)),
                    _button("건의사항", ask_num, ManageAskPage()),
                    Padding(padding: EdgeInsets.all(15.0)),
                    _button("기타", ect_num, EtcPage()),
                  ],
                ),
              ),
              // 구분선
              Container(
                width: 360.w,
                height: 1,
                color: themeColor3,
              ),
              // 하단 컨테이너(전체 문의/신규 문의/완료 문의)
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _bottomButton("전체 문의", all_num),
                    _bottomButton("신규 문의", new_num),
                    _bottomButton("완료 문의", finish_num),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            _card("회원 정보", UserInfoPage()),
          ],
        )
      ],
    );
  }

  // 파란색 컨테이너 안 버튼 네임드, 신고, 버그, 건의사항, 기타
  Widget _button(text, num, next) {
    return GestureDetector(
      child: Container(
        child: Column(
          children: [
            Text(
              num.toString(),
              style: TextStyle(
                fontFamily: "Barun",
                fontSize: 30.sp,
                color: Colors.white,
              ),
            ),
            Padding(padding: EdgeInsets.all(4.0)),
            Text(
              text,
              style: TextStyle(
                fontFamily: "Barun",
                fontSize: 15.sp,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Get.to(next);
      },
    );
  }

  // 하단 컨테이너 구성 위젯
  Widget _bottomButton(text, num){
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontFamily: "Barun",
              fontSize: 15.sp,
              color: themeColor3,
            ),
          ),
          Padding(padding: EdgeInsets.all(3.0.w)),
          Text(
            num.toString(),
            style: TextStyle(
              fontFamily: "Barun",
              fontSize: 15.sp,
              color: themeColor3,
            ),
          ),
        ],
      ),
    );
  }
  // 하단 Card
  Widget _card(text, next){
    return Padding(
        padding: EdgeInsets.only(top: 20.0, bottom: 30.0, right: 30.0.w, left: 30.0.w),
        child: Card(
          elevation: 3.0,
          color: Colors.white,
          child: ListTile(
            title: Text(
              text,
              style: TextStyle(
                fontFamily: "Barun",
                fontSize: 15.sp,
                color: grayColor1,
              ),
            ),
            trailing: Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () {
              Get.to(next);
            },
          ),
        )
    );
  }
}
