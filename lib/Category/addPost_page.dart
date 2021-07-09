import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:studytogether/main.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.4, 683.4),
      builder: () {
        return Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              "질문 등록",
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

            // 완료 버튼
            actions: [
              FlatButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "완료",
                  style: TextStyle(
                    color: themeColor1,
                    fontFamily: "Barun",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                // 버튼 누를 때 색이 약간 바뀌는 효과
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.transparent,
                  )
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                // 과목 검색 버튼
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_rounded,
                      ),
                      Text(
                          "과목을 선택해주세요"
                      ),
                    ],
                  ),
                ),

                // 제목과 내용을 입력하는 필드
                Container(
                  child: Column(
                    children: [
                      // 제목 적는 곳
                      TextField(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: "제목",
                          hintStyle: TextStyle(
                            fontFamily: "Barun",
                          ),
                        ),
                      ),

                      // 내용 적는 곳
                      TextField(
                        decoration: InputDecoration(
                          hintText: "내용",
                          hintStyle: TextStyle(
                            fontFamily: "Barun",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
