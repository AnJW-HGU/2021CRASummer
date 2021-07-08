import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:studytogether/Profile/myProfile_page.dart';
import 'package:studytogether/Login/login_page.dart';
import 'package:studytogether/main.dart';

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
              backgroundColor: themeColor1, //앱바색
              elevation: 0.0, // 앱바 그림자 없게하기
              title: Text(
                  "Study Together", // 타이틀
                style: TextStyle(
                  fontFamily: "Barun",
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              // 타이틀 오른쪽 아이콘들
              actions: <Widget>[
                Row(
                  children: [
                    // 로그인 버튼
                    IconButton(
                        icon: Icon(Icons.login_rounded),
                        iconSize: 27.w,
                        onPressed: () {
                          Get.to(LoginPage());
                        }
                    ),

                    // 알림 버튼
                    IconButton(
                      icon: Icon(Icons.notifications_rounded),
                      iconSize: 27.w,
                      onPressed: () {

                      },
                    ),

                    // 프로필 버튼
                    IconButton(
                        icon: Icon(Icons.account_circle_rounded),
                        iconSize: 27.w,
                        onPressed: () {
                          Get.to(MyProfilePage());
                        }
                    ),
                  ],
                )
              ],
            ),

            body: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30),

                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        
                      },
                      child: Container( // 숨김리스트 아닌 카테고리
                        width: 350.w,
                        height: 50.h,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 30.w),
                        child: Text(
                          "전체",
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
                    ),

                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
