import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:studytogether/main.dart';

import 'noti_page.dart';
import 'package:studytogether/Profile/myProfile_page.dart';
import 'package:studytogether/Login/login_page.dart';

import 'myBoard_page.dart';
import 'board_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var _userId; // 유저 아이디

  final _scroll = ScrollController();

  // 학부 리스트
  final List<String> _majorList = <String> [
    "GLS", "창의융합교육원", "국제어문", "언론정보문화", "커뮤니케이션",
    "경영경제", "법", "상담심리사회복지", "생명과학", "ICT창업", "AI융합교육원",
    "전산전자", "산업정보디자인", "기계제어", "공간환경시스템", "콘텐츠융합디자인",
    "산업교육",
  ];

  // 교양 리스트
  final List<String> _electiveList = <String> [
    "신앙/세계관", "인성/리더십", "외국어", "기초학문",
    "소통/융복합", "예체능", "그 외",
  ];


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(411.4, 683.4),
        builder: () {
          return Scaffold(
            backgroundColor: themeColor1, // 배경색

            appBar: AppBar(
              backgroundColor: themeColor1, // 앱바색
              elevation: 0.0, // 앱바 그림자 없게 하기
              titleSpacing: 20.w,
              title: Text(
                  "스터디 투게더", // 타이틀
                style: TextStyle(
                  fontFamily: "Barun",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              // 타이틀 오른쪽 아이콘들
              actions: <Widget>[
                Row(
                  children: [
                    // 로그인 버튼
                    Container(
                      width: 40,
                      child: IconButton(
                          icon: Icon(Icons.login_rounded),
                          tooltip: "Login Button",
                          iconSize: 27.w,
                          onPressed: () {
                            Get.to(LoginPage());
                          }
                      ),
                    ),

                    // 알림 버튼
                    Container(
                      width: 40,
                      child: IconButton(
                        icon: Icon(Icons.notifications_rounded),
                        tooltip: "Notification Button",
                        iconSize: 27.w,
                        onPressed: () {
                          Get.to(NotiPage());
                        },
                      ),
                    ),

                    // 프로필 버튼
                    Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: Container(
                        width: 40,
                        child: IconButton(
                            icon: Icon(Icons.account_circle_rounded),
                            tooltip: "Profile Button",
                            iconSize: 27.w,
                            onPressed: () {
                              Get.to(MyProfilePage());
                            }
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),

            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      // 나만의 게시판 버튼
                      GestureDetector(
                        onTap: () {
                          Get.to(MyBoardPage(), arguments: "나만의 게시판", transition: Transition.cupertino);
                        },
                        child: Container( // 숨김리스트 아닌 카테고리
                          width: 355.w,
                          height: 50,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 30.w),
                          child: Text(
                            "나만의 게시판",
                            style: TextStyle(
                              color: themeColor1,
                              fontFamily: "Barun",
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white, // 카테고리 블럭 배경색
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: blurColor,
                                  blurRadius: 4,
                                  offset: Offset(0.0, 2.0),
                                )
                              ]
                          ),
                        ),
                      ),

                      // 구분선
                      Divider(
                        color: Colors.white,
                        height: 30,
                        thickness: 1,
                        indent: 50.w,
                        endIndent: 50.w,
                      ),

                      // 파란색 게시판들
                      _buildCategory("전체"),
                      Padding(padding: EdgeInsets.only(top: 10.0),),
                      _buildExpansionCategory("학부", _majorList),
                      Padding(padding: EdgeInsets.only(top: 10.0),),
                      _buildCategory("전공기초"),
                      Padding(padding: EdgeInsets.only(top: 10.0),),
                      _buildExpansionCategory("교양", _electiveList),
                      Padding(padding: EdgeInsets.only(top: 10.0),),
                      _buildCategory("취업/진로"),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  // 숨김리스트 아닌 카테고리
  Widget _buildCategory(inTitle) {
    return GestureDetector(
      onTap: () {
        Get.to(BoardPage(), arguments: inTitle, transition: Transition.cupertino);
      },
      child: Container(
        width: 355.w,
        height: 50,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 30.w),
        child: Text(
          inTitle,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Barun",
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        decoration: BoxDecoration(
            color: themeColor1, // 카테고리 블럭 배경색
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: blurColor,
                blurRadius: 4,
                offset: Offset(0.0, 2.0),
              )
            ]
        ),
      ),
    );
  }

  // 숨김리스트 카테고리
  Widget _buildExpansionCategory(inTitle, listData) {
    return Container(
      width: 355.w,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 30.w),

      child: ListTileTheme(
        dense: true,  // ExpansionTile의 default padding을 없애는 것

        child: ExpansionTile(
          tilePadding: EdgeInsets.all(0),
          title: Text(
            inTitle,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Barun",
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
            ),
          ),

          // 오른쪽 아이콘!

          initiallyExpanded: false,
          // 숨김에 들어갈 것들
          children: [
            for (int i=0; i<listData.length; i++) _buildExpansionTile(listData[i]),
          ],
        ),
      ),

      decoration: BoxDecoration(
          color: themeColor1, // 카테고리 블럭 배경색
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: blurColor,
              blurRadius: 4,
              offset: Offset(0.0, 2.0),
            )
          ]
      ),
    );
  }

  Widget _buildExpansionTile(inTitle) {
    return Container(
      child: Text(
        inTitle,
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Barun",
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

// class AppBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(InfiniteScrollController());
//   }
// }