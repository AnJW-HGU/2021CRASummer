import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:studytogether/main.dart';

import 'noti_page.dart';
import 'package:studytogether/Profile/myProfile_page.dart';

import 'search_page.dart';
import 'addPost_page.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  String boardTitle = Get.arguments; // 카테고리 페이지로부터 타이틀 받음

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
              centerTitle: true,
              title: Text(
                boardTitle, // 타이틀
                style: TextStyle(
                  fontFamily: "Barun",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),

              // 뒤로가기 아이콘 수정
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                tooltip: "Back Button",
                iconSize: 15.w,
                onPressed: () {
                  Get.back();
                },
              ),

              // 타이틀 오른쪽 아이콘들
              actions: [
                Row(
                  children: [
                    // 알림버튼
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
                child: Column(
                  children: [

                    // 검색 버튼
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(SearchPage());
                          },

                          child: Container(
                            width: 350.w,
                            height: 35.h,
                            alignment: Alignment.centerRight,

                            padding: EdgeInsets.only(right: 10.w),
                            child: Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              border: Border.all(color: Colors.white.withOpacity(0.75)),
                              borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        )
                    ),

                  ],
                ),
              ),
            ),

            // 글쓰기 버튼
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.to(AddPostPage(), transition: Transition.downToUp);
              },
              child: Icon(Icons.add_rounded),
              backgroundColor: themeColor1,
              tooltip: "Add Post Button",
            ),

            // 하단 네비게이터 (나중에 Tapbar로 고칠 예정/현재 bottomAppBar)
            bottomNavigationBar: BottomAppBar(
              color: themeColor1,
              shape: CircularNotchedRectangle(),
              notchMargin: 4.0,

              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  IconButton(
                    onPressed: () {

                    },
                    icon: Icon(
                      Icons.question_answer_rounded,
                      color: Colors.white,
                    ),
                    tooltip: "Q&A Board Button",
                  ),

                  IconButton(
                    onPressed: () {

                    },
                    icon: Icon(
                      Icons.people_rounded,
                      color: Colors.white,
                    ),
                    tooltip: "Study Board Button",
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
