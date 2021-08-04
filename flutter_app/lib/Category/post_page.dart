import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:ui';
import 'dart:math';

import 'package:studytogether/main.dart';

Future<Post> fetchPost() async {
  String postUrl =
      "https://c64ab34d-ad62-4f6e-9578-9a43e222b9bf.mock.pstmn.io/post?post_id=000001";
  var response = await http.get(Uri.parse(postUrl));

  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load post");
  }
}

// Post에 대한 Data
class Post {
  var post_sub;
  var post_userId;
  var post_userName;
  var post_title;
  var post_content;
  var post_comments_count;
  var post_reports_count;
  var post_writtenDate;
  var post_adopted_status; // 채택된 댓글이 있니?

  Post({
    this.post_sub,
    this.post_userId,
    this.post_userName,
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
      post_userName: json["user_name"],
      post_title: json["title"],
      post_content: json["content"],
      post_comments_count: json["comments_count"],
      post_reports_count: json["reports_count"],
      post_writtenDate: json["written_date"],
      post_adopted_status: json["adopted_status"],
    );
  }
}

// UI
class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }
  /*
  게시글에서 필요한 것
  아이콘... 질문자와 비교해서...
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
                icon: Icon(
                  Icons.warning_rounded,
                ),
                tooltip: "Declaration Button",
                iconSize: 25.w,
                onPressed: () {},
              )
            ],
          ),
          body: FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 0.h, left: 30.w, right: 30.w, bottom: 25.h),
                      child: Column(
                        children: [
                          // 프로필과 닉네임
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: themeColor4,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.w),
                                child: Text(
                                  snapshot.data!.post_userName,
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
                                padding: EdgeInsets.only(top: 20.h),
                                child: Text(
                                  snapshot.data!.post_title,
                                  style: TextStyle(
                                    fontFamily: "Barun",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.h),
                                child: Text(
                                  snapshot.data!.post_content,
                                  style: TextStyle(
                                    fontFamily: "Barun",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),


                          Padding(
                            padding: EdgeInsets.only(top: 15.h, left: 0, right: 0, bottom: 0),
                          ),
                          // 날짜와 댓글 총 수
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                                child: Text(
                                  snapshot.data!.post_writtenDate,
                                  style: TextStyle(
                                    color: grayColor1,
                                    fontFamily: "barun",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),

                              Padding(
                                padding:EdgeInsets.all(0),
                                child: Text(
                                  snapshot.data!.post_comments_count.toString(),
                                  style: TextStyle(
                                    color: themeColor2,
                                    fontFamily: "barun",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                        padding:
                            EdgeInsets.only(top: 20, left: 15.w, right: 15.w),
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 15.w, left: 30.w, right: 30.w, bottom: 20.w),
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
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 0.h, left: 30.w, right: 30.w, bottom: 25.h),
                    child: Column(
                      children: [
                        // 프로필과 닉네임
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: themeColor4,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Container(
                                width: 100.w,
                                height: 16.h,
                                color: themeColor4,
                              ),
                            ),
                          ],
                        ),

                        // 질문 제목과 질문 내용
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20.h),
                              child: Container(
                                height: 16.h,
                                color: grayColor2,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Container(
                                height: 30.h,
                                color: grayColor2,
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
                      padding:
                      EdgeInsets.only(top: 20, left: 15.w, right: 15.w),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 15.w, left: 30.w, right: 30.w, bottom: 20.w),
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
              );
            },
          ),
        );
      },
    );
  }
}
