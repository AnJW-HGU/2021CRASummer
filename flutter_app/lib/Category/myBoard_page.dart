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

import 'post_page.dart';

class MyBoardPage extends StatefulWidget {
  const MyBoardPage({Key? key}) : super(key: key);

  @override
  _MyBoardPageState createState() => _MyBoardPageState();
}

class _MyBoardPageState extends State<MyBoardPage> {
  String boardTitle = Get.arguments; // 카테고리 페이지로부터 타이틀 받음

  // 과목 리스트
  final List<String>_subList = <String>[
    "자바 프로그래밍", "성경의 이해", "데이터 구조", "실전프로젝트",
    "공학설계입문", "C 프로그래밍", "파이썬", "타이포그래피",
    "무언가", "끼룩", "도비", "토익",
    "과목", "과목", "과목", "과목",
    "과목", "과목", "과목", "과목",
  ].obs;

  // 질문 제목 리스트
  final List<String> _titleList = <String>[
    "질문 제목1", "질문 제목2", "질문 제목3", "질문 제목4",
    "질문 제목5", "질문 제목6", "질문 제목7", "질문 제목8",
    "질문 제목9", "질문 제목10", "질문 제목11", "질문 제목12",
    "질문 제목13", "질문 제목14", "질문 제목15", "질문 제목16",
    "질문 제목17", "질문 제목18", "질문 제목19", "질문 제목20",
  ].obs;

  // 질문 내용 리스트
  final List<String> _contentList = <String> [
    "질문 내용입니다.", "질문 내용입니다.", "질문 내용입니다.", "질문 내용입니다.",
    "질문 내용입니다.", "질문 내용입니다.", "질문 내용입니다.", "질문 내용입니다.",
    "질문 내용입니다.", "질문 내용입니다.", "질문 내용입니다.", "질문 내용입니다.",
    "질문 내용입니다.", "질문 내용입니다.", "질문 내용입니다.", "질문 내용입니다.",
    "질문 내용입니다.", "질문 내용입니다.", "질문 내용입니다.", "질문 내용입니다.",
  ].obs;

  var _maxPost = 20; // 게시글 총 개수

  // final _refreshKey = GlobalKey<RefreshIndicatorState>();
  var _scroll = ScrollController().obs;

  var _subData = <String>[].obs;
  var _titleData = <String>[].obs;
  var _contentData = <String>[].obs;

  var isLoading = false.obs;
  var hasMore = false.obs;

  @override
  void initState() {
    _getPost();

    this._scroll.value.addListener(() {
      if (this._scroll.value.position.pixels == this._scroll.value.position.maxScrollExtent &&
          this.hasMore.value) {
        _getPost();
      }
    });

    super.initState();
  }

  _getPost() async {
    isLoading.value = true;

    await Future.delayed(Duration(seconds: 2));

    int offset = _subData.length;
    _subData.addAll(_subList.sublist(offset, offset+10));
    _titleData.addAll(_titleList.sublist(offset, offset+10));
    _contentData.addAll(_contentList.sublist(offset, offset+10));

    isLoading.value = false;
    hasMore.value = _subData.length < _maxPost;
  }

  _reload() async {
    isLoading.value = true;
    _subData.clear();
    _titleData.clear();
    _contentData.clear();

    await Future.delayed(Duration(seconds: 2));

    _getPost();
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


            // 검색 버튼
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
            body: SafeArea(
              child: Container (
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

                    Padding(padding: EdgeInsets.only(bottom: 10)),

                    Expanded(
                      child: _makePost(),
                    )
                  ],
                ),

                //
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )
                ),
              ),
            ),

            // 글쓰기 버튼
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
              color: Colors.white,
              // shape: CircularNotchedRectangle(),
              // notchMargin: 4.0,

              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  IconButton(
                    onPressed: () {

                    },
                    icon: Icon(
                      Icons.question_answer_rounded,
                      color: grayColor1,
                    ),
                    tooltip: "Q&A Board Button",
                  ),

                  IconButton(
                    onPressed: () {

                    },
                    icon: Icon(
                      Icons.people_rounded,
                      color: grayColor1,
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

  Widget _makePost() {
    return Container(
      child: Obx(()
      => Padding(
        padding: EdgeInsets.all(0.0),
        child: ListView.separated(
          controller: _scroll.value,
          itemBuilder: (_, index) {
            print(hasMore.value); // 데이터 더 있는지 콘솔창에 출력 (확인용)

            if (index < _subData.length) {
              var subDatum = _subData[index];
              var titleDatum = _titleData[index];
              var contentDatum = _contentData[index];
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.to(PostPage(), arguments: "$subDatum");
                },
                child: Container(
                  padding: EdgeInsets.only(top: 10.0, left: 5, bottom: 10.0),
                  child: _makePostTile("$subDatum", "$titleDatum", "$contentDatum"),
                ),
              );
            }

            if (hasMore.value || isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                        "게시글의 마지막 입니다"
                    ),
                    IconButton(
                      onPressed: () {
                        _reload();
                      },
                      icon: Icon(Icons.arrow_upward_rounded),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (_, index) => Divider(),
          itemCount: _subData.length + 1,
        ),
      ),),
    );
  }

  Widget _makePostTile(sub, title, content) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            sub,
            style: TextStyle(
              color: themeColor1,
              fontFamily: "Barun",
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          Text(
            title,
            style: TextStyle(
              fontFamily: "Barun",
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          Text(
            content,
            style: TextStyle(
              color: grayColor2,
              fontFamily: "Barun",
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

// class InfiniteScrollView extends GetView<InfiniteScrollController> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Obx(
//             () => Padding(
//               padding: EdgeInsets.all(10.0),
//               child: ListView.separated(
//                 controller: controller._scroll.value,
//                 itemBuilder: (_, index) {
//                   print(controller.hasMore.value);
//                   if (index < controller.data.length) {
//                     var datum = controller.data[index];
//                     return Material(
//                       elevation: 10.0,
//                       child: Container(
//                         padding: const EdgeInsets.all(10.0),
//                         child: ListTile(
//                           leading: Icon(Icons.android_outlined),
//                           title: Text('$datum 번째 데이터'),
//                           trailing: Icon(Icons.arrow_forward_outlined),
//                         ),
//                       ),
//                     );
//                   }
//                   if (controller.hasMore.value || controller.isLoading.value) {
//                     return Center(child: RefreshProgressIndicator());
//                   }
//                   return Container(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Center(
//                       child: Column(
//                         children: [
//                           Text('데이터의 마지막 입니다'),
//                           IconButton(
//                             onPressed: () {
//                               controller.reload();
//                             },
//                             icon: Icon(Icons.refresh_outlined),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//                 separatorBuilder: (_, index) => Divider(),
//                 itemCount: controller.data.length + 1,
//               ),
//             ),
//       ),
//     );
//   }
// }
//
// class InfiniteScrollController extends GetxController {
//   var data = <int>[].obs;
//   var isLoading = false.obs;
//   var hasMore = false.obs;
//
//   var _scroll = ScrollController().obs;
//
//   @override
//   void onInit() {
//     _getData();
//
//     this._scroll.value.addListener(() {
//       if (this._scroll.value.position.pixels == this._scroll.value.position.maxScrollExtent &&
//           this.hasMore.value) {
//         _getData();
//       }
//     });
//
//     super.onInit();
//   }
//
//   _getData() async {
//     isLoading.value = true;
//
//     await Future.delayed(Duration(seconds: 2));
//
//     int offset = data.length;
//     var appendData = List<int>.generate(10, (index) => index+1+offset);
//     data.addAll(appendData);
//
//     isLoading.value = false;
//     hasMore.value = data.length < 30;
//   }
//
//   reload() async {
//     isLoading.value = true;
//     data.clear();
//
//     await Future.delayed(Duration(seconds: 2));
//
//     _getData();
//   }
// }