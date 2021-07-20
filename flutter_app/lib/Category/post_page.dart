import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:ui';
import 'dart:math';

import 'package:studytogether/main.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
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
                            backgroundColor: grayColor2,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            "닉네임",
                            style: TextStyle(
                              color: themeColor2,
                              fontFamily: "Barun",
                              fontSize: 16.sp,
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
                              fontSize: 16.sp,
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
                              fontSize: 16.sp,
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
