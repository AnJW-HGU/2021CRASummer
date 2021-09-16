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
import 'package:studytogether/Profile/myProfile_page.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<User> fetchUser() async {
  String userUrl = 'https://4a20d71c-75da-40dd-8040-6e97160527b9.mock.pstmn.io/serve_test?post_id=1';
  var response = await http.get(Uri.parse(userUrl));

  if(response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load User");
  }
}

class User{
  var user_nickname;

  User({
    this.user_nickname,
  });

  // 찐 서버 연결시
  // factory User.fromJson(String nickname){
  //   return User(
  //     user_nickname: nickname,
  //   );
  // }
  factory User.fromJson(Map<String, dynamic> json){
    return User(
      user_nickname: json['nickname'],
    );
  }
}

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late Future<User> user;
  bool isSwitched = false; // 푸시알림 on/off

  @override
  void initState() {
    super.initState();
    user = fetchUser();
  }

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
                    Get.off(() => MyProfilePage());
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
              body: FutureBuilder<User>(
                  future: user,
                  builder: (context, snapshot) {
                    if(snapshot.data != null){
                      return ListView(
                        children: <Widget>[
                          _listTile_nickName("닉네임", snapshot.data!.user_nickname),
                          _listTile_themeColor("테마 색상"),
                          _listTile_alarm("푸쉬알림 설정"),
                          Padding(padding: EdgeInsets.all(2.0)),
                          _listTile("공지사항", InfoPage()),
                          _listTile("문의하기", AskPage()),
                          _listTile_appVersion("앱 버전"),
                          _listTile("개발자 페이지", SponPage()),
                          Padding(padding: EdgeInsets.all(2.0)),
                          _listTile("이용약관", UseRulePage()),
                          _listTile("개인정보 처리방침", PrivacyRulePage()),
                          _listTile_noPage("로그아웃"),
                        ],
                      );
                    }else if(snapshot.hasError){
                      return Text("${snapshot.error}");
                    }
                    return Center(child: CircularProgressIndicator());
                  }
              )
          );
        }
    );
  }

  // 닉네임 리스트
  Widget _listTile_nickName(context, _nickName){
    return ListTile(
      contentPadding: EdgeInsets.only(left:30.w, right:30.w),
      title: Text(context, style: TextStyle(color: grayColor1, fontFamily: "Barun", fontSize:14.sp, letterSpacing: 1),),
      tileColor: Colors.white,
      onTap: () {
        Get.off(() => EditNicknamePage(), arguments: _nickName);
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

  // 테마색상 리스트
  Widget _listTile_themeColor(context){
    return ListTile(
      tileColor: Colors.white,
      contentPadding: EdgeInsets.only(left:30.w, right:30.w),
      title: Text(context, style: TextStyle(color: grayColor1, fontFamily: "Barun", fontSize:14.sp, letterSpacing: 1),),
      trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 18.w
      ),
      onTap: () {
        Get.showSnackbar(
          GetBar(
            message: "공사 중이에요! :>",
            duration: Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: themeColor2,
            barBlur: 0,
          ),
        );
      },
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

}


