import 'dart:io';

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


//POST
Future<Post> fetchPost() async {
  final post_id = Get.arguments.toString();
  // Map<String, dynamic> queryParams = {
  //   'postId' : post_id,
  // };
  //
  // String queryString = Uri(queryParameters: queryParams).query;
  var postUrl = "https://c64ab34d-ad62-4f6e-9578-9a43e222b9bf.mock.pstmn.io/post"+"/"+post_id;
  var response = await http.get(Uri.parse(postUrl));

  // String postUrl =
  //     "https://c64ab34d-ad62-4f6e-9578-9a43e222b9bf.mock.pstmn.io/post?post_id=000001";
  // var response = await http.get(Uri.parse(postUrl));

  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load post");
  }
}

// Post에 대한 Data
class Post {
  var post_id;
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
    this.post_id,
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
      post_id: json["post_id"],
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


//Comment


// UI
class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late Future<Post> post;

  final commentController = TextEditingController();
  bool _isComment = true;
  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

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
            title: FutureBuilder<Post>(
              future: post,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Text(
                    snapshot.data!.post_sub,
                    style: TextStyle(
                      color: grayColor1,
                      fontFamily: "Barun",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                }
                else if (snapshot.hasError) {
                  return Text(
                    "질문",
                    style: TextStyle(
                      color: grayColor1,
                      fontFamily: "Barun",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                }
                return Text(
                  "질문",
                  style: TextStyle(
                    color: grayColor1,
                    fontFamily: "Barun",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                );
              },
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

                    // 질문 관련
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(

                                    //comment 아이콘
                                    padding: EdgeInsets.only(left:0, right:3.w, top:0, bottom:0),
                                    child: Icon(
                                      Icons.comment_outlined,
                                      size: 15.sp,
                                      color: grayColor1,
                                    ),
                                  ),

                                  //comment 수
                                  Padding(
                                    padding:EdgeInsets.all(0),
                                    child: Text(
                                      snapshot.data!.post_comments_count.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: grayColor1,
                                        fontFamily: "barun",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),

                                  // 채택여부 -> 이건 어차피 댓글로 보여지니까
                                  // Padding(
                                  //   padding: EdgeInsets.only(left: 5.w),
                                  //   child: snapshot.data!.post_adopted_status ?
                                  //   Icon(
                                  //     Icons.star_rounded,
                                  //     size: 19.sp,
                                  //     color: grayColor1,
                                  //   ) :
                                  //   Icon(
                                  //     Icons.star_outline_rounded,
                                  //     size: 19.sp,
                                  //     color: grayColor1,
                                  //   ),
                                  // ),
                                ],
                              ),

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

                    // 댓글 관련
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 20.h, left: 15.w, right: 15.w),
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 15.w, left: 20.w, right: 20.w, bottom: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              //댓글들...
                              Padding(
                                padding: EdgeInsets.all(0),
                                child: Column(
                                  children: [
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
                                              color: Colors.black,
                                              fontFamily: "Barun",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: 80.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                              width: 1,
                              color: grayColor1,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w, right: 15.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: TextField(
                                    controller: commentController,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    // onSubmitted: (value) {
                                    //   print("${commentController.text}");
                                    // },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "답변을 입력하세요.",
                                      hintStyle: TextStyle(
                                        fontFamily: "Barun",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),

                                      // border: OutlineInputBorder(
                                      //   borderSide: BorderSide(
                                      //     color: grayColor2,
                                      //     width: 1,
                                      //   ),
                                      //   borderRadius: BorderRadius.circular(15),
                                      // ),
                                    ),
                                  ),
                                ),
                              ),

                              IconButton(
                                onPressed: () {
                                  print("${commentController.text}");
                                  commentController.clear();
                                },
                                icon: Icon(
                                    Icons.check,
                                  color: themeColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
              else if (snapshot.hasError) {
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

  // Widget _MakeComment(cUserId, cNickname, cContent, cWrittenDate, cAdopted) {
  //   return Padding(
  //     padding: EdgeInsets.all(0),
  //     child: Col,
  //   );
  // }
}
