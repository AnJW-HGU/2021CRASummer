import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<User> fetchUser() async {
  String userUrl = 'https://4a20d71c-75da-40dd-8040-6e97160527b9.mock.pstmn.io/serve_test?post_id=1';
  var response = await http.get(Uri.parse(userUrl));

  if(response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load User");
  }
}

// 공지사항 어디서 받아오는지 ?
class User{
  var user_nickname;

  User({
    this.user_nickname,
  });


  factory User.fromJson(Map<String, dynamic> json){
    return User(
      user_nickname: json['nickname'],
    );
  }
}

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {

  final List<String> _subList = <String>[
    "분류", "분류에오", "분 류", "분류우",
    // "분류", "분류에오", "분 류", "분류우",
    // "분류", "분류에오", "분 류", "분류우",
    // "분류", "분류에오", "분 류", "분류우",
    // "분류", "분류에오", "분 류", "분류우",
  ].obs;

  final List<String> _titleList = <String>[
    "제목1", "제목2", "제목3", "제목4",
    // "제목5", "제목6", "제목7", "제목8",
    // "제목9", "제목10", "제목11", "제목12",
    // "제목13", "제목14", "제목15", "제목16",
    // "제목17", "제목18", "제목19", "제목20",
  ].obs;

  final List<String> _contentList = <String>[
    "공지 내용이요", "공지 내용이요", "공지 내용이요", "공지 내용이요",
    // "공지 내용이요", "공지 내용이요", "공지 내용이요", "공지 내용이요",
    // "공지 내용이요", "공지 내용이요", "공지 내용이요", "공지 내용이요",
    // "공지 내용이요", "공지 내용이요", "공지 내용이요", "공지 내용이요",
    // "공지 내용이요", "공지 내용이요", "공지 내용이요", "공지 내용이요",
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
    _getInfo();

    this.scrollController.value.addListener(() {
      if(this.scrollController.value.position.pixels ==
          this.scrollController.value.position.maxScrollExtent && this.hasMore.value) {
        _getInfo();
      }
    });
    super.initState();
  }

  _getInfo() async {
    isLoading.value = true;

    await Future.delayed(Duration(seconds: 2));

    int offset = _subData.length;

    if(_subList.length<10){
      _subData.addAll(_subList.sublist(offset));
      _titleData.addAll(_titleList.sublist(offset));
      _contentData.addAll(_contentList.sublist(offset));

      isLoading.value = false;
      hasMore.value = false;
    }else {
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
                icon: Icon(Icons.arrow_back_ios_new_rounded, size: 15.w,),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                "공지사항",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: "Barun",
                  color: grayColor1,
                ),
              ),
            ),
            body: _InfoPageBody(),
          );
        }
    );
  }

  Widget _InfoPageBody() {
    return Container(
      child: Obx(
            () => Padding(
          padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
          child: ListView.separated(
            controller: scrollController.value,
            itemBuilder: (_, index) {
              print(hasMore.value);

              if (index < _subData.length) {
                var subDatum = _subData[index];
                var titleDatum = _titleData[index];
                var contentDatum = _contentData[index];

                return Container(
                  child: _makeInfoTile("$subDatum", "$titleDatum", "$contentDatum"),
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
                      Text('공지사항의 마지막 입니다'),
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
            itemCount: _subData.length + 1,
          ),
        ),
      ),
    );
  }

  Widget _makeInfoTile(sub, title, content) {
    return Container(
      child : ExpansionTile(
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
        initiallyExpanded: false,
        backgroundColor: Colors.white,
        children: <Widget>[
          Divider(height: 1),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0.w, right: 20.0.w ),
            child: Text(
              content,
              style: TextStyle(
                fontFamily: "Barun",
                fontSize: 14.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}