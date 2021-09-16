import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:studytogether/Category/post_page.dart';
import 'myProfile_page.dart';

Future<List<User_Comment_Post>> fetchUserPost() async {
  var userUrl =
      'https://4a20d71c-75da-40dd-8040-6e97160527b9.mock.pstmn.io/myA?user_id=123456';
  var response = await http.get(Uri.parse(userUrl));

  if (response.statusCode == 200) {
    return UserfromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load User_Post");
  }
}

class User_Comment_Post {
  var user_comment_postId;
  var user_comment_subject;
  var user_comment_title;

  User_Comment_Post(
      this.user_comment_postId,
      this.user_comment_subject,
      this.user_comment_title,
      );

// 기존 것
// factory User.fromJson(Map<String, dynamic> json) {
//   return User(
//     user_postId: json['id'],
//     user_subject: json['subject'],
//     user_title: json['title'],
//     user_content: json['content']
//   );
// }
}

List<User_Comment_Post> UserfromJson(json) {
  List<User_Comment_Post> result = [];
  json.forEach((item) {
    result.add(
        User_Comment_Post(item["postId"], item['subject'], item['title']));
  });

  return result;
}

class MyAPage extends StatefulWidget {
  const MyAPage({Key? key}) : super(key: key);

  @override
  _MyAPageState createState() => _MyAPageState();
}

class _MyAPageState extends State<MyAPage> {
  List<User_Comment_Post> _userCommentPostDataList = [];

  var _maxUserCommentPostInfo = 30;

  final scrollController = ScrollController().obs;

  var _isLoading = false.obs;
  var _hasMore = false.obs;

  var _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void dispose(){
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getUserCommentPostInfo();

    this.scrollController.value.addListener(() {
      if (this.scrollController.value.position.pixels ==
          this.scrollController.value.position.maxScrollExtent &&
          this._hasMore.value) {
        _getUserCommentPostInfo();
      }
    });
  }

  _getUserCommentPostInfo() async {
    _isLoading.value = true;
    List<User_Comment_Post> _newUserCommentPostDataList = await fetchUserPost();
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _userCommentPostDataList.addAll(_newUserCommentPostDataList);
    });
    _isLoading.value = false;
    _hasMore.value = _userCommentPostDataList.length < _maxUserCommentPostInfo;
  }

  reload() async {
    _isLoading.value = true;
    _userCommentPostDataList.clear();
    _getUserCommentPostInfo();
  }

  // 새로고침
  Future<Null> refresh() async {
    _userCommentPostDataList.clear();
    _isLoading.value = false;
    _hasMore.value = false;
    _getUserCommentPostInfo();
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(411.4, 683.4),
        builder: () {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Get.back();
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> MyProfilePage()),).then((value) => setState((){}));
                },
                color: themeColor1,
                icon: Icon(Icons.arrow_back_ios_new_rounded, size: 15.w,),
              ),
              title: Text(
                "답변 수",
                style: TextStyle(
                  fontFamily: "Barun",
                  fontSize: 15.sp,
                  color: grayColor1,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: RefreshIndicator(
              // 새로고침 추가
              key: _refreshKey,
              child: Container(
                child: Obx(
                  // 질문 리스트
                      () => Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: ListView.separated(
                      controller: scrollController.value,
                      itemBuilder: (BuildContext _context, index) {
                        if (index < _userCommentPostDataList.length) {
                          return Container(
                              child: _makeInfoTile(
                                "${_userCommentPostDataList[index].user_comment_subject}",
                                "${_userCommentPostDataList[index].user_comment_title}",
                                "${_userCommentPostDataList[index].user_comment_postId}",)
                          );
                        }
                        if (_hasMore.value || _isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Column(
                              children: [
                                Text('마지막 입니다'),
                                IconButton(
                                  onPressed: () {
                                    reload();
                                  },
                                  icon: Icon(Icons.arrow_upward_rounded),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, index) => Divider(),
                      itemCount: _userCommentPostDataList.length + 1,
                    ),
                  ),
                ),
              ),
              // 새로고침 시 실행할 함수
              onRefresh: () => refresh(),
            ),
          );
        }
    );
  }
  Widget _makeInfoTile(sub, title, post_id) {
    return Container(
      child: ListTile(
        subtitle: Text(
          title,
          style: TextStyle(
            fontFamily: "Barun",
            fontSize: 14.sp,
            color: Colors.black,
          ),
        ),
        title: new Text(
          sub,
          style: TextStyle(
            fontFamily: "Barun",
            fontSize: 14.sp,
            color: themeColor2,
          ),
        ),
        onTap: () {
          Get.to(PostPage(), arguments: post_id);
        },
      ),
    );
  }
}