import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';

class AskPage extends StatefulWidget {
  @override
  _AskPageState createState() => _AskPageState();
}

class _AskPageState extends State<AskPage> {
  final List<String> _valueList = ['종류','네임드 신청', '신고', '건의사항', '버그', '기타'];
  String _selectedValue = '종류';
  final addTitle = TextEditingController();
  final addContent = TextEditingController();

  @override
  void dispose() {
    // 위젯이 dispose 또는 dismiss 될 때 컨트롤러를 clean up!
    addTitle.dispose();
    addContent.dispose();
    super.dispose();
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
              title: Text(
                  "문의하기",
                style: TextStyle(
                  fontFamily: "Barun",
                  fontSize: 15.sp,
                  color: grayColor1,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              actions: [
                TextButton(
                  child: Text("완료",
                    style: TextStyle(
                      fontFamily: "Barun",
                      fontSize: 14.sp,
                    ),
                  ),
                  onPressed : () {
                    Get.back();
                    },
                )
              ],
            ),
            body: SafeArea(child: _askPageBody()),
          );
        });
  }


  Widget _askPageBody() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // 드롭박스
        Container(
          padding: EdgeInsets.only(top: 20, left: 20.w, right: 20.w),
          child: DropdownButton(
            style: TextStyle(
              fontFamily: "Barun",
              fontSize: 16.sp,
              color: Colors.black,
            ),
            isExpanded: true,
            value: _selectedValue,
            items: _valueList.map(
                (value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedValue = value.toString();
              });
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Column(
                      children: [
                        // 제목 적는 곳
                        TextField(
                          controller: addTitle,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "제목을 입력해주세요.",
                            hintStyle: TextStyle(
                              fontFamily: "Barun",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // 내용 적는 곳
                        Container(
                          child: TextField(
                            controller: addContent,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "내용을 입력해주세요.",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontFamily: "Barun",
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                // 문의하기 신청 작성시 규칙
                Container(
                  padding: EdgeInsets.only(top: 15, left: 20.w, right: 20.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "<문의하기-네임드 신청 작성 시 규칙>"
                        "\n\n"
                        "1. 네임드 신청\n"
                        "\t- 해당 학부 게시글에서 채택된 답변이 30개 이상인 경우\n"
                        "\t- 해당 학부 교수님이신 경우\n\n",
                    style: TextStyle(
                      color: grayColor2,
                      fontFamily: "Barun",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
