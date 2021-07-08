import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:get/get.dart';

import 'package:studytogether/main.dart';
import 'package:studytogether/Profile//point_page.dart';


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
            ),
            title: Text('프로필', style: TextStyle(color: Colors.white, fontSize: 25),),
            backgroundColor: themeColor1,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.settings_rounded, size: 21,),
                  onPressed: () {
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
              CircleAvatar(
                radius: 35,
                backgroundColor: themeColor3,
                child: CircleAvatar(
                  radius: 34,
                  backgroundColor: Colors.white,
                ),
              ),
              Padding(padding: EdgeInsets.all(4)),
              Text(_nickName, style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  shadows: [Shadow(
                    color: blurColor,
                    offset: Offset(0,4.0),
                    blurRadius: 4,
                  )]),),
              Padding(padding: EdgeInsets.all(5.0)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(right: 20, left: 20)),
                  Text("포인트", style: TextStyle(fontSize: 13, color: themeColor3),),
                  TextButton(onPressed: () {
                    Get.to(PointPage());
                  },
                      child: Text(_point, style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                      ),)),
                  Text("질문", style: TextStyle(fontSize: 13, color: themeColor3),),
                  TextButton(onPressed: () {
                  },
                      child: Text(_questionNum, style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                      ),)),
                  Text("답변", style: TextStyle(fontSize: 13, color: themeColor3),),
                  TextButton(onPressed: () {
                  },
                      child: Text(_answerNum, style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                      ),)),
                  TextButton(onPressed: () {},
                    child: Text("스터디", style: TextStyle(fontSize: 13, color: themeColor3),),
                  )
                ],
              )
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(4.0)),
        // Expanded(
        //   child: ListView(
        //     padding: EdgeInsets.all(15.0),
        //     children: <Widget>[
        //       _listTile(Icons.circle, '포인트', PointPage()),
        //       _listTile(Icons.circle, '공지사항', UpdateInfoPage()),
        //       _listTile(Icons.circle, '설정', SettingsPage()),
        //       _listTile(Icons.circle, '문의하기', QnAPage()),
        //       _listTile(Icons.circle, '후원하기', SupportPage()),
        //     ],
        //   ),
        // ),

      ],
    );
  }
}

