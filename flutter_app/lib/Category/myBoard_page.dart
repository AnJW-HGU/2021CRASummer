import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:ui';

import 'package:studytogether/main.dart';

import 'search_page.dart';
import 'noti_page.dart';
import 'package:studytogether/Profile/myProfile_page.dart';

import 'subSearch_page.dart';
import 'addPost_page.dart';

import 'post_page.dart';


// Preferred Subjects 데이터 가져오기
List<PreferredSubject> PreferredfromJson (json) {
  List<PreferredSubject> result = [];
  json.forEach((item) {
    result.add(PreferredSubject(item["id"], item["subject"]));
  });

  return result;
}

Future<List<PreferredSubject>> fetchPreferred() async {
  final userId = 1;
  var preferredUrl = "https://c64ab34d-ad62-4f6e-9578-9a43e222b9bf.mock.pstmn.io/preferred?userId="+userId.toString();
  var response = await http.get(Uri.parse(preferredUrl));

  if (response.statusCode == 200) {
    return PreferredfromJson(json.decode(response.body));
  } else {
    throw Exception("Faild to load preferred subject");
  }
}

// Preferred Subjects 데이터 형식
class PreferredSubject{
  var preferred_id;
  var preferred_subject;

  PreferredSubject(
      this.preferred_id,
      this.preferred_subject,
  );
}

// Posts 데이터 가져오기
List<Posts> PostsfromJson (json) {
  List<Posts> result = [];
  json.forEach((item) {
    result.add(Posts(item["subject"], item["id"], item["user_id"], item["title"], item["content"], item["comments_count"], item["written_date"], item["adopted_status"]));
  });

  return result;
}

Future<List<Posts>> fetchPosts() async {
  final boardTitle = Get.arguments; // 카테고리 페이지로부터 타이틀 받음
  var postsUrl = "https://c64ab34d-ad62-4f6e-9578-9a43e222b9bf.mock.pstmn.io/posts?major="+boardTitle;
  var response = await http.get(Uri.parse(postsUrl));

  if (response.statusCode == 200) {
    return PostsfromJson(json.decode(response.body));
  } else {
    throw Exception("Faild to load posts");
  }
}

// Posts 데이터 형식
class Posts{
  var posts_subject;
  var posts_id;
  var posts_userId;
  var posts_title;
  var posts_content;
  var posts_commentsC;
  var posts_writtenDate;
  var posts_adoptedStatus;

  Posts(
      this.posts_subject,
      this.posts_id,
      this.posts_userId,
      this.posts_title,
      this.posts_content,
      this.posts_commentsC,
      this.posts_writtenDate,
      this.posts_adoptedStatus,
      );
}


///////////////////////////////////////////////////////


class MyBoardPage extends StatefulWidget {
  const MyBoardPage({Key? key}) : super(key: key);

  @override
  _MyBoardPageState createState() => _MyBoardPageState();
}

class _MyBoardPageState extends State<MyBoardPage> {

  // refresh에 관해서
  final _refreshMyBoard = false;

  // 선호 과목리스트
  List<PreferredSubject> _preferredSubjectDataList = <PreferredSubject>[].obs;
  late Future<List<PreferredSubject>> _preferredSubjects;

  var _maxPreferred = 20; // 게시글 총 개수
  var _isPreferredLoading = false.obs;
  var _hasMorePreferred = false.obs;


  // 게시글 리스트
  List<Posts> _postsDataList = <Posts>[].obs;

  var _scroll = ScrollController().obs;

  var _maxPosts = 20; // 게시글 총 개수
  var _isPostsLoading = false.obs;
  var _hasMorePosts = false.obs;

  SearchSubs choicePreferredSub = SearchSubs(null, null, null);
  var _isPreferSubsLoading = true;

  @override
  void initState() {
    super.initState();
    _getPosts();
    _preferredSubjects = fetchPreferred();

    this._scroll.value.addListener(() {
      if (this._scroll.value.position.pixels == this._scroll.value.position.maxScrollExtent &&
          this._hasMorePosts.value) {
        _getPosts();
      }
    });
  }

  _getPreferredSubject() async {
    _isPreferredLoading.value = true;
    List<PreferredSubject> _newPreferredDataList = await fetchPreferred();
    setState(() {
      _preferredSubjectDataList.addAll(_newPreferredDataList);
    });
    _isPreferredLoading.value = false;
    _hasMorePreferred.value = _preferredSubjectDataList.length < _maxPreferred;
  }

  _getPosts() async {
    _isPostsLoading.value = true;
    List<Posts> _newPostsDataList = await fetchPosts();
    setState(() {
      _postsDataList.addAll(_newPostsDataList);
    });
    _isPostsLoading.value = false;
    _hasMorePosts.value = _postsDataList.length < _maxPosts;
  }

  _reload() async {
    _isPostsLoading.value = true;
    _postsDataList.clear();
    _getPosts();
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
              centerTitle: false,
              title: Text(
                Get.arguments, // 타이틀
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
                    // 검색 버튼
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Container(
                        width: 40.w,
                        child: IconButton(
                            icon: Icon(Icons.search_rounded),
                            tooltip: "Profile Button",
                            iconSize: 27.w,
                            onPressed: () {
                              Get.to(() => SearchPage(), arguments: Get.arguments); // 카테고리로부터 받은 게시판 타이틀
                            }
                        ),
                      ),
                    ),


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


            // 게시글
            body: SafeArea(
              child: Container (
                padding: EdgeInsets.only(top: 30, bottom: 10.h, left: 25.w, right: 25.w),
                //흰색 배경안에 들어갈 것들
                child: Column(
                  children: [
                    //과목 리스트
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "과목",
                          style: TextStyle(
                            fontFamily: "Barun",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Padding(padding: EdgeInsets.only(bottom: 10)),

                        //과목들 생성
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async{
                                  choicePreferredSub = await Get.to(() => SubSearchPage());
                                  if (choicePreferredSub.searchSubs_subject != null) {
                                    setState(() {
                                      _isPreferSubsLoading = true;
                                    });
                                  }
                                },
                                child: Container(
                                  width: 60.w,
                                  height: 25,
                                  child: Icon(
                                    Icons.add_rounded,
                                    color: themeColor2,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: themeColor2,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      )
                                  ),
                                ),
                              ),

                              Padding(padding: EdgeInsets.only(right: 5.w),),

                              // _makePreferredSubs(context),
                            ],
                          ),
                        )
                      ],
                    ),

                    Padding(padding: EdgeInsets.only(bottom: 5)),

                    //게시글 리스트
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 게시판 흰색 부분에 들어갈 것

                          // 타이틀 - 게시글
                          // Text(
                          //   "게시글",
                          //   style: TextStyle(
                          //     fontFamily: "Barun",
                          //     fontSize: 20.sp,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),

                          Padding(padding: EdgeInsets.only(bottom: 10)),

                          //게시글 생성
                          Expanded(
                            child: _makePost(),
                          )
                        ],
                      ),
                    ),
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
            // bottomNavigationBar: BottomAppBar(
            //   color: Colors.white,
            //   // shape: CircularNotchedRectangle(),
            //   // notchMargin: 4.0,
            //
            //   child: Row(
            //     mainAxisSize: MainAxisSize.max,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //
            //     children: [
            //       IconButton(
            //         onPressed: () {
            //
            //         },
            //         icon: Icon(
            //           Icons.question_answer_rounded,
            //           color: grayColor1,
            //         ),
            //         tooltip: "Q&A Board Button",
            //       ),
            //
            //       IconButton(
            //         onPressed: () {
            //
            //         },
            //         icon: Icon(
            //           Icons.people_rounded,
            //           color: grayColor1,
            //         ),
            //         tooltip: "Study Board Button",
            //       ),
            //     ],
            //   ),
            // ),
          );
        }
    );
  }

  Future<Widget> _makePreferredSubs(context) async {
    if (_isPreferSubsLoading == true) {
      _isPreferSubsLoading = false;
      return FutureBuilder<List<PreferredSubject>> (
        future: _preferredSubjects,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Row(
              children: [
                for (int i=0; i<snapshot.data!.length; i++) _makeSub(snapshot.data![i].preferred_subject),
              ],
            );
          }
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center();
        },
      );
    }
    else {
      return Center();
    }
  }

  Widget _makeSub(inSubTitle) {
    return GestureDetector(
      onTap: () {
        // 과목 삭제 눌렀을 때
        Get.defaultDialog(
          barrierDismissible: false,
          title: "",
          titleStyle: TextStyle(
            fontFamily: "Barun",
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
          ),

          content: Column(
            children: [
              Text(
                inSubTitle+"를(을)",
                style: TextStyle(
                  fontFamily: "Barun",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                )
              ),
              Text(
                "삭제하시겠습니까?",
                  style: TextStyle(
                    fontFamily: "Barun",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  )
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "아니오",
                style: TextStyle(
                  color: themeColor1,
                  fontFamily: "Barun",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                  "예",
                style: TextStyle(
                  color: themeColor1,
                  fontFamily: "Barun",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ]
        );
      },

      child: Padding(
        padding: EdgeInsets.only(right: 5.w),
        child: Container(
          padding: EdgeInsets.only(top:5, bottom: 5, left: 10.w, right: 5.w),
          child: Row(
            children: [
              Text(
                inSubTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Barun",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),

              // IconButton으로 만들면 크기가...
              Icon(
                Icons.clear_rounded,
                color: Colors.white,
                size: 15.w,
              ),
            ],
          ),

          decoration: BoxDecoration(
              color: themeColor1,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )
          ),
        ),
      ),
    );
  }

  // 게시판에 게시글 띄우기
  Widget _makePost() {
    return Container(
      child: Obx(()
      => Padding(
        padding: EdgeInsets.all(0.0),
        child: ListView.separated(
          controller: _scroll.value,
          itemBuilder: (_, index) {
            if (index < _postsDataList.length) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.to(PostPage(), arguments: [_postsDataList[index].posts_id, _postsDataList[index].posts_userId]);
                },
                child: Container(
                  padding: EdgeInsets.only(top: 10.0, left: 5, bottom: 10.0),
                  child: _makePostTile(_postsDataList[index].posts_subject, _postsDataList[index].posts_title,
                      _postsDataList[index].posts_content, _postsDataList[index].posts_commentsC,
                      _postsDataList[index].posts_writtenDate, _postsDataList[index].posts_adoptedStatus),
                ),
              );
            }

            if (_hasMorePosts.value || _isPostsLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
              child: IconButton(
                onPressed: () {
                  _reload();
                },
                icon: Icon(Icons.arrow_upward_rounded),
              ),
            );
          },
          separatorBuilder: (_, index) => Divider(),
          itemCount: _postsDataList.length + 1,
        ),
      ),),
    );
  }

  // 게시판의 게시글 틀
  Widget _makePostTile(inSub, inTitle, inContent, inCount, inDate, inAdopted) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            inSub,
            style: TextStyle(
              color: themeColor1,
              fontFamily: "Barun",
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          Text(
            inTitle,
            style: TextStyle(
              fontFamily: "Barun",
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          Text(
            inContent,
            overflow: TextOverflow.ellipsis,
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