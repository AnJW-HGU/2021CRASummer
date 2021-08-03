import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:ui';
import 'dart:math';

import 'package:studytogether/main.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

// Post에 대한 Data
class Post {
  var post_sub;
  var post_userId;
  var post_title;
  var post_content;
  var post_comments_count;
  var post_reports_count;
  var post_writtenDate;
  var post_adopted_status; // 채택된 댓글이 있니?

  Post({
    this.post_sub,
    this.post_userId,
    this.post_title,
    this.post_content,
    this.post_comments_count,
    this.post_reports_count,
    this.post_writtenDate,
    this.post_adopted_status,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      post_sub: json["subject"],
      post_userId: json["user_id"],
      post_title: json["title"],
      post_content: json["content"],
      post_comments_count: json["comments_count"],
      post_reports_count: json["reports_count"],
      post_writtenDate: json["written_date"],
      post_adopted_status: json["adopted_status"],
    );
  }
}

class _PostPageState extends State<PostPage> {
  late Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  Future<Post> fetchPost() async {
    String postUrl = "https://c64ab34d-ad62-4f6e-9578-9a43e222b9bf.mock.pstmn.io/post?post_id=000001";
    var response = await http.get(Uri.parse(postUrl));

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load post");
    }
  }
  /*
  게시글에서 필요한 것
  게시글 refresh
    1. 댓글 또는 대댓글 달면 refresh
    2. 신고?
  댓글 refresh
    1. 추천 누르면 refresh
   게시글 삭제하면 삭제하고 뒤로가기, 게시판 refresh
   */

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.4, 683.4),
      builder: () {
        return Scaffold(
          backgroundColor: themeColor2,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              Get.arguments,
              style: TextStyle(
                color: grayColor1,
                fontFamily: "Barun",
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
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

            actions: [
              IconButton(
                color: grayColor2,
                icon: Icon(Icons.warning_rounded,),
                tooltip: "Declaration Button",
                iconSize: 25.w,
                onPressed: () {

                },
              )
            ],
          ),

          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 15.w, left: 30.w, right: 30.w, bottom: 20.w),
                child: Column(
                  children: [

                    // 프로필과 닉네임
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {

                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: themeColor4,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            "닉네임",
                            style: TextStyle(
                              color: themeColor2,
                              fontFamily: "Barun",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 질문 제목과 질문 내용
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "질문 제목",
                            style: TextStyle(
                              fontFamily: "Barun",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "질문 내용은 이곳에 나타났습니다.\n"
                            "질문 내용\n"
                            "질문 내용\n",
                            style: TextStyle(
                              fontFamily: "Barun",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  boxShadow: [
                    BoxShadow(
                      color: blurColor,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
              ),

              // 댓글
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top:20, left: 15.w, right: 15.w),
                    child: Container(
                      padding: EdgeInsets.only(top: 15.w, left: 30.w, right: 30.w, bottom: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //댓글들...
                          Text("Hi"),
                        ],
                      ),

                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        boxShadow: [
                          BoxShadow(
                            color: blurColor,
                            blurRadius: 4,
                            offset: Offset(2, 0),
                          )
                        ],
                      ),
                    ),
                  ),
              ),

            ],
          ),
        );
      },
    );
  }
}
