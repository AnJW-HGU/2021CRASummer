import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:studytogether/main.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class Post {
  final int postID;
  final String title;
  final String content;
  final String date;
  final String thumb;
  final int views;
  final int good;
  final int bad;
  Post(
      {required this.postID,
        required this.title,
        required this.content,
        required this.date,
        required this.thumb,
        required this.views,
        required this.good,
        required this.bad});

  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post(
      postID: json['id'],
      title: json['title'],
      content: json['content'],
      date: json['date'],
      thumb: json['pic_thumb'],
      views: json['views'],
      good: json['good'],
      bad: json['bad'],
    );
  }
}

class _SearchPageState extends State<SearchPage> {
  final _userId = ""; // 유저 아이디
  final _subSelect = ""; // 선택한 과목
  final _proSelect = ""; // 선택한 과목의 교수님

  final _search = TextEditingController();
  FocusNode _focus = FocusNode();

  Future<List<Post>> _fetchSearch(String name) async {
    List<Post> _posts = [];
    final response = await http.get(Uri.parse('http://127.0.0.1/search/'+name));
    final List<Post> parsedResponse = jsonDecode(response.body)
        .map<Post>((json) => Post.fromJSON(json))
        .toList();

    _posts.clear();
    _posts.addAll(parsedResponse);
    return _posts;
  }

  @override
  void dispose() {
    // 위젯이 dispose 또는 dismiss 될 때 컨트롤러를 clean up!
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.4, 683.4),
      builder: () {


        return Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: Container(
              height: 32,
              child: TextField(
                focusNode: _focus,
                textAlignVertical: TextAlignVertical.bottom,
                controller: _search,
                textInputAction: TextInputAction.go,
                onSubmitted: (value) {
                  print("${_search.text}");
                  //넘기기
                },
                // 과목 검색하기
                decoration: InputDecoration(
                  // border 설정
                  enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: themeColor1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: themeColor1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),

                  // prefixIcon: Icon(Icons.search_rounded, color: themeColor1,),
                  suffixIcon: IconButton(
                    onPressed: _search.clear,
                    padding: EdgeInsets.all(0.0),
                    icon: Icon(Icons.clear, color: themeColor1,),
                  ),

                  hintText: "검색할 내용을 입력해주세요.",
                  hintStyle: TextStyle(
                    fontFamily: "Barun",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
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
          body: SafeArea(
            child: Text("hello"),
          ),
        );
      },
    );
  }
}
