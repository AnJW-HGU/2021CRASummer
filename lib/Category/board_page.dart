import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:ui';
import 'dart:math';

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
  
  var subList;
  var titleList;
  var contentList;
  var random;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  
  // 초기에 값을 랜덤으로 넣어줌
  @override
  void initState() {
    super.initState();
    random = Random();
    refreshList();
  }
  
  // async wait를 쓰기 위해서는 Future 타입을 이용함
  Future<Null> refreshList() async{
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 0)); // thread sleep 같은 역할을 함
    // 새로운 정보를 그려내는 곳
    setState(() {
      subList = List.generate(random.nextInt(100), (i) => "과목 $i");
      titleList = List.generate(random.nextInt(100), (i) => "질문 제목 $i");
      contentList = List.generate(random.nextInt(100), (i) => "질문에 관한 내용 $i");
    });
    return null;
  }
  
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
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(SearchPage());
                            },

                            child: Container(
                              width: 350.w,
                              height: 35,
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

                      // 게시글
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 30, left: 30.w, right: 30.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // 게시판 흰색 부분에 들어갈 것
                                // 타이틀 - 게시글
                                Text(
                                  "게시글",
                                  style: TextStyle(
                                    fontFamily: "Barun",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                )
                            ),
                          )
                      )
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
