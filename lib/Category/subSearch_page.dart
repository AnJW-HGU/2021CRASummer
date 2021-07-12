import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:studytogether/main.dart';

class SubSearchPage extends StatefulWidget {
  const SubSearchPage({Key? key}) : super(key: key);

  @override
  _SubSearchPageState createState() => _SubSearchPageState();
}

class _SubSearchPageState extends State<SubSearchPage> {
  final _userId = ""; // 유저 아이디
  final _subSelect = ""; // 선택한 과목
  final _proSelect = ""; // 선택한 과목의 교수님

  final _subSearch = TextEditingController();

  @override
  void dispose() {
    // 위젯이 dispose 또는 dismiss 될 때 컨트롤러를 clean up!
    _subSearch.dispose();
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
                controller: _subSearch,

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
                      onPressed: _subSearch.clear,
                      icon: Icon(Icons.clear, color: themeColor1,),
                    ),

                    hintText: "과목이름을 검색해주세요.",
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
