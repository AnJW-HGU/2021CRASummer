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
  
  var _subList; // 과목 리스트
  var _titleList; // 질문 제목 리스트
  var _contentList; // 질문 내용 리스트

  var _refreshKey = GlobalKey<RefreshIndicatorState>();

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

                      // // 검색 버튼
                      // Padding(
                      //     padding: EdgeInsets.only(top: 5, bottom: 20),
                      //     child: GestureDetector(
                      //       onTap: () {
                      //         Get.to(SearchPage());
                      //       },
                      //
                      //       child: Container(
                      //         width: 350.w,
                      //         height: 35,
                      //         alignment: Alignment.centerRight,
                      //
                      //         padding: EdgeInsets.only(right: 10.w),
                      //         child: Icon(
                      //           Icons.search_rounded,
                      //           color: Colors.white,
                      //         ),
                      //
                      //         decoration: BoxDecoration(
                      //             color: Colors.white.withOpacity(0.25),
                      //             border: Border.all(color: Colors.white.withOpacity(0.75)),
                      //             borderRadius: BorderRadius.circular(10)
                      //         ),
                      //       ),
                      //     )
                      // ),


                      // 게시글
                        Container(
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

                              Expanded(
                                child: InfiniteScrollView(),
                              )
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

class InfiniteScrollView extends GetView<InfiniteScrollController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
            () => Padding(
              padding: EdgeInsets.all(10.0),
              child: ListView.separated(
                controller: controller._scroll.value,
                itemBuilder: (_, index) {
                  print(controller.hasMore.value);
                  if (index < controller.data.length) {
                    var datum = controller.data[index];
                    return Material(
                      elevation: 10.0,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: Icon(Icons.android_outlined),
                          title: Text('$datum 번째 데이터'),
                          trailing: Icon(Icons.arrow_forward_outlined),
                        ),
                      ),
                    );
                  }
                  if (controller.hasMore.value || controller.isLoading.value) {
                    return Center(child: RefreshProgressIndicator());
                  }
                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        children: [
                          Text('데이터의 마지막 입니다'),
                          IconButton(
                            onPressed: () {
                              controller.reload();
                            },
                            icon: Icon(Icons.refresh_outlined),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, index) => Divider(),
                itemCount: controller.data.length + 1,
              ),
            ),
      ),
    );
  }
}

class InfiniteScrollController extends GetxController {
  var data = <int>[].obs;
  var isLoading = false.obs;
  var hasMore = false.obs;

  var _refreshKey = GlobalKey<RefreshIndicatorState>();
  var _scroll = ScrollController().obs;

  @override
  void onInit() {
    _getData();

    this._scroll.value.addListener(() {
      if (this._scroll.value.position.pixels == this._scroll.value.position.maxScrollExtent &&
          this.hasMore.value) {
        _getData();
      }
    });

    super.onInit();
  }

  _getData() async {
    isLoading.value = true;

    await Future.delayed(Duration(seconds: 2));

    int offset = data.length;
    var appendData = List<int>.generate(10, (index) => index+1+offset);
    data.addAll(appendData);

    isLoading.value = false;
    hasMore.value = data.length < 30;
  }

  reload() async {
    isLoading.value = true;
    data.clear();

    await Future.delayed(Duration(seconds: 2));

    _getData();
  }
}