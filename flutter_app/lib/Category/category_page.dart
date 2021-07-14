import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:studytogether/main.dart';

import 'noti_page.dart';
import 'package:studytogether/Profile/myProfile_page.dart';
import 'package:studytogether/Login/login_page.dart';

import 'board_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
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
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      _buildCategory("전체"),
                      Padding(padding: EdgeInsets.only(top: 10.0),),
                      _buildCategory("전공기초"),
                      Padding(padding: EdgeInsets.only(top: 10.0),),
                      _buildCategory("그 외"),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  Widget _buildCategory(inTitle) {
    return GestureDetector(
      onTap: () {
        Get.to(BoardPage(), arguments: inTitle, transition: Transition.cupertino);
      },
      child: Container( // 숨김리스트 아닌 카테고리
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
}

// class AppBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(InfiniteScrollController());
//   }
// }