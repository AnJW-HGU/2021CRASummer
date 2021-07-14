import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';

import 'editNickname_page.dart';
import 'ask_page.dart';
import 'info_page.dart';
import 'privacyRule_page.dart';
import 'spon_page.dart';
import 'useRule_page.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _nickName = Get.arguments;
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(411.4, 683.4),
        builder: () {
          return Scaffold(
            backgroundColor: themeColor4,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                color: Colors.white,
                icon: Icon(Icons.arrow_back_ios_new_rounded, size: 15.w,),
              ),
              backgroundColor: themeColor1,
              title: Text(
                '설정',
                style: TextStyle(
                    fontFamily: "Barun",
                    color: Colors.white,
                    fontSize: 15.sp
                ),
              ),
              centerTitle: true,
            ),
            body: _settingPageBody()
          );
        }
    );
  }
  // 닉네임 리스트
  Widget _listTile_nickName(context, Next){
    return ListTile(
      contentPadding: EdgeInsets.only(left:30.w, right:30.w),
      title: Text(context, style: TextStyle(color: grayColor1, fontFamily: "Barun", fontSize:14.sp, letterSpacing: 1),),
      tileColor: Colors.white,
      onTap: () {
        Get.to(Next, arguments: _nickName);
      },
      trailing: Text(_nickName, style: TextStyle(fontFamily: "Barun", color: grayColor1,),),
    );
  }

  // 앱버전 리스트
  Widget _listTile_appVersion(context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left:30.w, right:30.w),
      title: Text(context, style: TextStyle(color: grayColor1, fontFamily: "Barun", fontSize:14.sp, letterSpacing: 1),),
      tileColor: Colors.white,
      onTap: () {
      },
      trailing: Text("1.0.0", style: TextStyle(fontFamily: "Barun", color: grayColor1,),),
    );
  }
  // 알람설정 리스트
  Widget _listTile_alarm(context){
    return ListTile(
      contentPadding: EdgeInsets.only(left:30.w, right:15.w),
      title: Text(context, style: TextStyle(color: grayColor1, fontFamily: "Barun", fontSize:14.sp, letterSpacing: 1),),
      tileColor: Colors.white,
      onTap: () {
      },
      trailing: Switch(
        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
          });
        },
      )
    );
  }

   // 다음페이지로 넘어가는 리스트
  Widget _listTile(context, Next){
    return ListTile(
      contentPadding: EdgeInsets.only(left:30.w, right:30.w),
      title: Text(context, style: TextStyle(color: grayColor1, fontFamily: "Barun", fontSize:14.sp, letterSpacing: 1),),
      tileColor: Colors.white,
      onTap: () {
        Get.to(Next);
      },
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 18.w
      ),
    );
  }

  // 넘어가는 페이지가 없는 리스트
  Widget _listTile_noPage(context){
    return ListTile(
      tileColor: Colors.white,
      contentPadding: EdgeInsets.only(left:30.w, right:30.w),
      title: Text(context, style: TextStyle(color: grayColor1, fontFamily: "Barun", fontSize:14.sp, letterSpacing: 1),),
      trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 18.w
      ),
    );
  }

  // 리스트타일들
  Widget _settingPageBody() {
    return ListView(
        children: <Widget>[
          _listTile_nickName("닉네임", EditNicknamePage()),
          _listTile_noPage("테마 색상"),
          _listTile_alarm("푸쉬알림 설정"),
          Padding(padding: EdgeInsets.all(2.0)),
          _listTile("공지사항", InfoPage()),
          _listTile("문의하기", AskPage()),
          _listTile_appVersion("앱 버전"),
          _listTile("후원하기", SponPage()),
          Padding(padding: EdgeInsets.all(2.0)),
          _listTile("이용약관", UseRulePage()),
          _listTile("개인정보 처리방침", PrivacyRulePage()),
          _listTile_noPage("로그아웃"),
        ],
    );
  }
}



