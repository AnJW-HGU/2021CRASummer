import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:studytogether/Category/post_page.dart';

Future<List<User_Post>> fetchUserPost() async {
  var userUrl =
      'https://4a20d71c-75da-40dd-8040-6e97160527b9.mock.pstmn.io/get?user_id=123456';
  var response = await http.get(Uri.parse(userUrl));

  if (response.statusCode == 200) {
    return UserfromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load User_Post");
  }
}

class User_Post {
  var user_postId;
  var user_subject;
  var user_title;
  var user_content;

  User_Post(
      this.user_postId,
      this.user_subject,
      this.user_title,
      this.user_content,
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

List<User_Post> UserfromJson(json) {
  List<User_Post> result = [];
  json.forEach((item) {
    result.add(
        User_Post(item["id"], item['subject'], item['title'], item['content']));
  });

  return result;
}

class MyQPage extends StatefulWidget {
  const MyQPage({Key? key}) : super(key: key);

  @override
  _MyQPageState createState() => _MyQPageState();
}

class _MyQPageState extends State<MyQPage> {
  List<User_Post> _userPostDataList = [];

  var _maxUserPostInfo = 30;

  final scrollController = ScrollController().obs;

  var _isLoading = false.obs;
  var _hasMore = false.obs;

  var _refreshKey = GlobalKey<RefreshIndicatorState>(); // 새로고침 key

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getUserPostInfo();

    this.scrollController.value.addListener(() {
      if (this.scrollController.value.position.pixels ==
          this.scrollController.value.position.maxScrollExtent &&
          this._hasMore.value) {
        _getUserPostInfo();
      }
    });
  }

  _getUserPostInfo() async {
    _isLoading.value = true;
    List<User_Post> _newUserPostDataList = await fetchUserPost();
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _userPostDataList.addAll(_newUserPostDataList);
    });
    _isLoading.value = false;
    _hasMore.value = _userPostDataList.length < _maxUserPostInfo;
  }

  reload() async {
    _isLoading.value = true;
    _userPostDataList.clear();
    _getUserPostInfo();
  }

  // 새로고침
  Future<Null> refresh() async {
    _userPostDataList.clear();
    _isLoading.value = false;
    _hasMore.value = false;
    _getUserPostInfo();
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
                },
                color: themeColor1,
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 15.w,
                ),
              ),
              title: Text(
                "질문 수",
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
                        if (index < _userPostDataList.length) {
                          return Container(
                              child: _makeInfoTile(
                                "${_userPostDataList[index].user_subject}",
                                "${_userPostDataList[index].user_title}",
                                "${_userPostDataList[index].user_content}",
                                "${_userPostDataList[index].user_postId}",)
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
                                Text('질문 수의 마지막 입니다'),
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
                      itemCount: _userPostDataList.length + 1,
                    ),
                  ),
                ),
              ),
              // 새로고침 시 실행할 함수
              onRefresh: () => refresh(),
            ),
          );
        });
  }

  // 리스트 만드는 위젯젯
  Widget _makeInfoTile(sub, title, content, post_id_in) {
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
          Get.to(PostPage(), arguments: post_id_in);
        },
      ),
    );
  }
}