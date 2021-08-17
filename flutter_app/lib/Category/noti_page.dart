// import 'dart:convert';
// import 'dart:math';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:studytogether/Category/post_page.dart';
// import 'dart:ui';
// import 'package:studytogether/main.dart';
// import 'package:http/http.dart' as http;
//
// Future<Noti> fetchNoti() async {
//   var response = await http.get(Uri.parse('https://0c5f29c1-526c-4b53-af83-ce20fecb0819.mock.pstmn.io/noti?user_id=020202'));
//
//   if (response.statusCode == 200) {
//     // 만약 서버로의 요청이 성공하면, JSON을 파싱합니다.
//     print("a");
//     return Noti.fromJson(json.decode(response.body));
//   } else {
//     // 만약 요청이 실패하면, 에러를 던집니다.
//     throw Exception('Failed to load post');
//   }
// }
//
// class Noti {
//   var noti_id;
//   var noti_kind;
//   var noti_read_status;
//   var noti_written_date;
//   var noti_post_id;
//
//   Noti({this.noti_id, this.noti_kind, this.noti_read_status, this.noti_written_date, this.noti_post_id});
//
//   factory Noti.fromJson(Map<String, dynamic> json) {
//     return Noti(
//       noti_id: json["id"],
//       noti_kind: json["kind"],
//       noti_read_status: json["read_status"],
//       noti_written_date: json["written_date"],
//       noti_post_id: json["post_id"],
//     );
//   }
// }
//
// class NotiPage extends StatefulWidget {
//   const NotiPage({Key? key}) : super(key: key);
//
//   @override
//   _NotiPageState createState() => _NotiPageState();
// }
//
// class _NotiPageState extends State<NotiPage> {
//   late Future<Noti> noti;
//
//   @override
//   void initState() {
//     super.initState();
//     noti = fetchNoti();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: Size(411.4, 683.4),
//       builder: () {
//         return Scaffold(
//           backgroundColor: Colors.white,
//
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             centerTitle: true,
//             title: Text(
//               "알림",
//               style: TextStyle(
//                 color: grayColor1,
//                 fontSize: 15.sp,
//                 fontWeight: FontWeight.w300,
//               ),
//             ),
//
//             // 뒤로가기 버튼
//             leading: IconButton(
//               color: themeColor1,
//               icon: Icon(Icons.arrow_back_ios_new_rounded),
//               tooltip: "Back Button",
//               iconSize: 15.w,
//               onPressed: () {
//                 Get.back();
//               },
//             ),
//           ),
//
//           body: SafeArea(
//             child: Container (
//               padding: EdgeInsets.only(top: 20, left: 30.w, right: 30.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//
//                   Padding(padding: EdgeInsets.only(bottom: 10)),
//
//                   Container(
//                      child: FutureBuilder<Noti>(
//                         future: noti,
//                         builder: (context, snapshot) {
//                            if (snapshot.data != null) {
//                              return GestureDetector(
//                                  behavior: HitTestBehavior.opaque,
//                                  onTap: () {
//                                  // Get.to(PostPage(), arguments: "$subDatum");
//                                  },
//                                  child: Container(
//                                     padding: EdgeInsets.only(top: 10.0, left: 5, bottom: 10.0),
//                                     child: _makePostTile("${snapshot.data!.noti_kind}", "${snapshot.data!.noti_written_date}"),
//                                  ),
//                              );
//                             }
//                             else if (snapshot.hasError) {
//                                return Text("Error");
//                             }
//                             return Center(child: CircularProgressIndicator(),);
//                         },
//                      ),
//                   ),
//                 ],
//               ),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(25),
//                     topRight: Radius.circular(25),
//                   )
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _makePostTile(sub, noti) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.baseline,
//         textBaseline: TextBaseline.alphabetic,
//         children: [
//           Text(
//             sub,
//             style: TextStyle(
//               color: themeColor1,
//               fontFamily: "Barun",
//               fontSize: 15.sp,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           Padding(padding: EdgeInsets.only(bottom: 5)),
//           Text(
//             noti,
//             style: TextStyle(
//               color: grayColor1,
//               fontFamily: "Barun",
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w300,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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

import 'addPost_page.dart';

import 'post_page.dart';



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


/////////////////////////////////////////////////////////////////

class NotiPage extends StatefulWidget {
  const NotiPage({Key? key}) : super(key: key);

  @override
  _NotiPageState createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  List<Posts> _postsDataList = <Posts>[].obs;


  var _scroll = ScrollController().obs;

  var _maxPost = 20; // 게시글 총 개수
  var _isLoading = false.obs;
  var _hasMorePosts = false.obs;

  @override
  void initState() {
    super.initState();
    _getPosts();
    this._scroll.value.addListener(() {
      if (this._scroll.value.position.pixels == this._scroll.value.position.maxScrollExtent &&
          this._hasMorePosts.value) {
        _getPosts();
      }
    });
  }

  _getPosts() async {
    _isLoading.value = true;
    List<Posts> _newPostsDataList = await fetchPosts();
    setState(() {
      _postsDataList.addAll(_newPostsDataList);
    });
    _isLoading.value = false;
    _hasMorePosts.value = _postsDataList.length < _maxPost;
  }

  _reload() async {
    _isLoading.value = true;
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
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Container(
                        width: 40.w,
                        child: IconButton(
                          icon: Icon(Icons.notifications_rounded),
                          tooltip: "Notification Button",
                          iconSize: 27.w,
                          onPressed: () {

                          },
                        ),
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
                padding: EdgeInsets.only(top: 15.h, bottom: 10.h, left: 25.w, right: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween, // 각 위젯간의 공간을 둠
                    //   children: [
                    //     // 게시판 흰색 부분에 들어갈 것
                    //     // 타이틀 - 게시글
                    //     Text(
                    //       "게시글",
                    //       style: TextStyle(
                    //         fontFamily: "Barun",
                    //         fontSize: 20.sp,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //
                    //     //검색 버튼
                    //     Container(
                    //       padding: EdgeInsets.all(0.0),
                    //       child: IconButton(
                    //         padding: EdgeInsets.all(0.0),
                    //         icon: Icon(Icons.search_rounded, color: themeColor1,),
                    //         tooltip: "Search Button",
                    //         iconSize: 27.w,
                    //         onPressed: () {
                    //           Get.to(() => SearchPage(), transition: Transition.cupertino);
                    //         }
                    //       ),
                    //     )
                    //
                    //   ],
                    // ),

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
            // bottomNavigationBar: BottomAppBar(
            //   color: Colors.white,
            //   // shape: CircularNotchedRectangle(),
            //   // notchMargin: 4.0,
            //
            //   child: Row(
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

            if (_hasMorePosts.value || _isLoading.value) {
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