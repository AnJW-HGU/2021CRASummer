import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<User> fetchUser() async {
  String userUrl =
      'https://4a20d71c-75da-40dd-8040-6e97160527b9.mock.pstmn.io/get?user_id=123456';
  var response = await http.get(Uri.parse(userUrl));

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load User");
  }
}

class User {
  var user_postId;
  var user_subject;
  var user_title;
  var user_content;

  User({
    this.user_postId,
    this.user_subject,
    this.user_title,
    this.user_content,
  });

  // getSize(){
  //   print(user_postId.length);
  //   return user_postId.length;
  // }
  //
  // String getSubject() {
  //   return user_subject;
  // }
  //
  // String getTitle() {
  //   return user_title;
  // }
  //
  // String getContent() {
  //   return user_content;
  // }

  // 기존 것
  factory User.fromJson(List<dynamic> json) {
    print(json.map((item) => User(
          user_postId: item['id'],
          user_subject: item['subject'],
          user_title: item['title'],
          user_content: item['content'],
        )));
    print(json.map((item) => item['id']));
    return User(
      // user_postId: json.map((item) => item['id']).toList(),
      user_subject: json.map((item) => item['subject']).toList(),
      user_title: json.map((item) => item['title']).toList(),
      user_content: json.map((item) => item['content']).toList(),
    );
  }
}

class MyQPage extends StatefulWidget {

  var post;
  MyQPage({@required this.post});
  @override
  _MyQPageState createState() => _MyQPageState();
}


class _MyQPageState extends State<MyQPage> {
  late Future<User> user;

  List<User> result = <User>[];

  final List<String> _subList = <String>[].obs;

  final List<String> _titleList = <String>[
    // "질문 제목1", "질문 제목2", "질문 제목3", "질문 제목4",
    // "질문 제목5", "질문 제목6", "질문 제목7", "질문 제목8",
    // "질문 제목9", "질문 제목10", "질문 제목11", "질문 제목12",
    // "질문 제목13", "질문 제목14", "질문 제목15", "질문 제목16",
    // "질문 제목17", "질문 제목18", "질문 제목19", "질문 제목20",
  ].obs;

  final List<String> _contentList = <String>[
    // "질문 내용이에오", "질문 내용이에오", "질문 내용이에오", "질문 내용이에오",
    // "질문 내용이에오", "질문 내용이에오", "질문 내용이에오", "질문 내용이에오",
    // "질문 내용이에오", "질문 내용이에오", "질문 내용이에오", "질문 내용이에오",
    // "질문 내용이에오", "질문 내용이에오", "질문 내용이에오", "질문 내용이에오",
    // "질문 내용이에오", "질문 내용이에오", "질문 내용이에오", "질문 내용이에오",
  ].obs;

  var maxInfo = 20;

  var scrollController = ScrollController().obs;

  var _subData = <String>[].obs;
  var _titleData = <String>[].obs;
  var _contentData = <String>[].obs;

  var isLoading = false.obs;
  var hasMore = false.obs;

  @override
  void initState() {
    super.initState();
    user = fetchUser();
    _getInfo();
    this.scrollController.value.addListener(() {
      if (this.scrollController.value.position.pixels ==
              this.scrollController.value.position.maxScrollExtent &&
          this.hasMore.value) {
        _getInfo();
      }
    });
  }


  _getInfo() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));

    int offset = _subData.length;
    if (offset < 10) {
      _subData.addAll(_subList.sublist(offset));
      _titleData.addAll(_titleList.sublist(offset));
      _contentData.addAll(_contentList.sublist(offset));
      isLoading.value = false;
      hasMore.value = false;
    } else {
      _subData.addAll(_subList.sublist(offset, offset + 10));
      _titleData.addAll(_titleList.sublist(offset, offset + 10));
      _contentData.addAll(_contentList.sublist(offset, offset + 10));

      isLoading.value = false;
      hasMore.value = _subData.length < maxInfo;
    }
  }

  reload() async {
    isLoading.value = true;
    _subData.clear();
    _titleData.clear();
    _contentData.clear();

    await Future.delayed(Duration(seconds: 2));
    _getInfo();
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
              body: FutureBuilder<User>(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Container(
                      child: Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10),
                          child: ListView.separated(
                            controller: scrollController.value,
                            itemBuilder: (BuildContext _context, index) {

                              if (index < snapshot.data!.user_subject.length) {
                                var subDatum = snapshot.data!.user_subject[index];
                                var titleDatum = snapshot.data!.user_title[index];
                                var contentDatum = snapshot.data!.user_content[index];
                                print(subDatum);
                                return Container(
                                  child: _makeInfoTile("$subDatum",
                                      "$titleDatum", "$contentDatum"),
                                );
                              }
                              if (hasMore.value || isLoading.value) {
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
                            itemCount: snapshot.data!.user_subject.length + 1,
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("?${snapshot.error}");
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ));
        });
  }

  Widget _makeInfoTile(sub, title, content) {
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
      ),
    );
  }
}
