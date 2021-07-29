import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:async';
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

  final _subSearchFilter = TextEditingController();

  List<String> _subList = <String>[
    "데이타 구조", "데이타 프로그래밍", "데이타 언어", "데2",
    "데이타", "데이타 강형", "데이타 지원", "데이터 모음",
    "데이타인데요", "성경", "재이수", "재수",
  ].obs;

  List<String> _proList = <String>[
    "강형", "소은", "고은", "현서",
    "햄찌", "햄햄", "지원", "도비",
    "교수", "교수?", "교수수", "옥수수",
  ].obs;

  var _subSearchNum = 0;

  // _SubSearchPageState() {
  //   _subSearch.addListener(() {
  //     if (_subSearch.text.isEmpty) {
  //       setState(() {
  //         _filterText = "";
  //       });
  //     }
  //     else {
  //       setState(() {
  //         _filterText = _subSearch.text;
  //       });
  //     }
  //   });
  // }


  Widget _initSubSearch() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Text(
            "과목 검색하는 방법:",
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 5.h,
              color: grayColor1,
              fontFamily: "Barun",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "예) 데이, 데이타, 데이타 구조",
            textAlign: TextAlign.center,
            style: TextStyle(
              // height: 10.h,
              color: grayColor1,
              fontFamily: "Barun",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // 위젯이 dispose 또는 dismiss 될 때 컨트롤러를 clean up!
    _subSearchFilter.dispose();
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
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.bottom,
                // textInputAction: TextInputAction.go,
                controller: _subSearchFilter,
                onChanged: (text) {
                  print("${_subSearchFilter.text}");
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
                    onPressed: () {
                      _subSearchFilter.clear();
                      // FocusScope.of(context).unfocus();
                      },
                    padding: EdgeInsets.all(0.0),
                    icon: Icon(Icons.clear, color: themeColor1,),
                  ),

                  hintText: "강의명 또는 교수명을 입력하세요.",
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
            child: Center(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: _initSubSearch(),
              ),
            )
          ),
        );
      },
    );
  }
}
