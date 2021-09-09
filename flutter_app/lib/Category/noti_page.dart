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
import 'package:flutter/rendering.dart';
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
List<Notis> NotisfromJson (json) {
  List<Notis> result = [];
  json.forEach((item) {
    result.add(Notis(item["id"], item["kind"], item["read_status"], item["written_date"], item["read_date"], item["post_id"], item["user_id"], item["title"]));
  });

  return result;
}

Future<List<Notis>> fetchNotis() async {
  var postsUrl = 'https://0c5f29c1-526c-4b53-af83-ce20fecb0819.mock.pstmn.io/noti?user_id=020202';
  var response = await http.get(Uri.parse(postsUrl));

  if (response.statusCode == 200) {
    print('데이터 받아오기 성공');
    return NotisfromJson(json.decode(response.body));
  } else {
    throw Exception("Faild to load posts");
  }
}

// Posts 데이터 형식
class Notis{
  var notis_id;
  var notis_kind;
  var notis_readStatus;
  var notis_writtenDate;
  var notis_readDate;
  var notis_postId;
  var notis_userId;
  var notis_postTitle;

  Notis(
      this.notis_id,
      this.notis_kind,
      this.notis_readStatus,
      this.notis_writtenDate,
      this.notis_readDate,
      this.notis_postId,
      this.notis_userId,
      this.notis_postTitle,
      );
}


/////////////////////////////////////////////////////////////////

class NotiPage extends StatefulWidget {
  const NotiPage({Key? key}) : super(key: key);

  @override
  _NotiPageState createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  List<Notis> _postsDataList = <Notis>[].obs;


  var _scroll = ScrollController().obs;

  var _maxPost = 20; // 게시글 총 개수
  var _isLoading = false.obs;
  var _hasMorePosts = false.obs;

  @override
  void initState() {
    super.initState();
    _getNotis();
    this._scroll.value.addListener(() {
      if (this._scroll.value.position.pixels == this._scroll.value.position.maxScrollExtent &&
          this._hasMorePosts.value) {
        _getNotis();
      }
    });
  }

  _getNotis() async {
    _isLoading.value = true;
    List<Notis> _newPostsDataList = await fetchNotis();
    setState(() {
      _postsDataList.addAll(_newPostsDataList);
    });
    _isLoading.value = false;
    _hasMorePosts.value = _postsDataList.length < _maxPost;
  }

  _reload() async {
    _isLoading.value = true;
    _postsDataList.clear();
    _getNotis();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(411.4, 683.4),
        builder: () {
          return Scaffold(
            backgroundColor: Colors.white, // 배경색
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  "알림",
                  style: TextStyle(
                    color: grayColor1,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),

                // 뒤로가기 버튼
                leading: IconButton(
                  color: themeColor1,
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                  tooltip: "Back Button",
                  iconSize: 15.w,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),

            // 게시글
            body: SafeArea(
              child: Container (
                padding: EdgeInsets.only(top: 15.h, bottom: 10.h, left: 25.w, right: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Expanded(
                      child: _makePost(),
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
            if (index < _postsDataList.length) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  //서버에도 보내야 함
                  setState(() {
                    _postsDataList[index].notis_readStatus = 1;
                  });
                  Get.to(PostPage(), arguments: [_postsDataList[index].notis_id, _postsDataList[index].notis_userId]);
                  },
                child: Container(
                  padding: EdgeInsets.only(top: 10.0, left: 5, bottom: 10.0),
                  child: _makePostTile(_postsDataList[index].notis_kind, _postsDataList[index].notis_readStatus,
                      _postsDataList[index].notis_writtenDate, _postsDataList[index].notis_readDate,
                      _postsDataList[index].notis_postId, _postsDataList[index].notis_postTitle),
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

  Widget _makePostTile(inKind, inReadStatus, inWrittenDate, inReadDate, inPostId, inPostTitle) {
    bool isRead = false;
    String type = "";
    if(inReadStatus == 1) {
      isRead = true;
    }
    if(inKind == 'recomment') {
      type = '게시글에 답변이 달렸습니다.';
    }

    return Container(
      child: Opacity(
        opacity: isRead? 0.5 : 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              inPostTitle,
              style: TextStyle(
                color: isRead ? grayColor1 : themeColor1,
                fontFamily: "Barun",
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 5)),
            Text(
              type,
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
      ),
    );
  }
}