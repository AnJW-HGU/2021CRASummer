import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

import 'package:studytogether/main.dart';

class NamedAnswerPage extends StatefulWidget {
  @override
  _NamedAnswerPageState createState() => _NamedAnswerPageState();
}

class _NamedAnswerPageState extends State<NamedAnswerPage> {
  final List<String> _valueList = ['---네임드 수정---', '학생', '교수', '졸업생', '대학원생'];
  String _selectedValue = '---네임드 수정---';
  String initialValue = '---네임드 수정---';
  String _changedValue = '';

  String studentId = Get.arguments[0];
  String title_content = Get.arguments[1];
  // bool isChecked = Get.arguments[2];

  String email = "22000404@handong.edu";
  String question_num = "3";
  String answer_num = "25";
  String select_num = "11";
  String point = "5300";
  String declaration_num = "1";
  String named = "학생";

  bool _isButtonAbled = false;
  bool _isValued = false;

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
                  color: themeColor2,
                  icon: Icon(Icons.arrow_back_ios_new_rounded, size: 15.w,),
                ),
                centerTitle: true,
                title: Text(
                  "네임드",
                  style: TextStyle(
                    fontFamily: "Barun",
                    color: grayColor1,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                actions: [
                  TextButton(
                      onPressed: _isButtonAbled ?
                        _isButtonDialog
                      : _isFalsedButtonDialog,
                      child: Text(
                        "완료",
                        style: TextStyle(
                          fontFamily: "Barun",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: _isButtonAbled ? themeColor1 : grayColor1,
                        ),
                      )
                  ),
                ],
              ),
              body: Padding(
                padding: EdgeInsets.only(
                    top: 20.0, bottom: 20.0, left: 20.0.w, right: 20.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 250,
                      padding: EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                      decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: blurColor,
                        //     blurRadius: 4,
                        //     offset: Offset(0.0, 3.0),
                        //   ),
                        // ],
                        color: themeColor4,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            studentId,
                            style: TextStyle(
                              fontFamily: "Barun",
                              fontSize: 14.sp,
                              color: themeColor1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                            child: Text(
                              title_content,
                              style: TextStyle(
                                fontFamily: "Barun",
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text(
                              "내요오옹",
                              style: TextStyle(
                                fontFamily: "Barun",
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15.0, left: 5.0.w, right: 5.0.w),
                      child: IntrinsicHeight(
                          child: Row(
                            children: [
                              VerticalDivider(thickness: 4, color: themeColor4,),
                              Container(
                                padding: EdgeInsets.only(left: 3.0.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _UserInfo("이메일", email),
                                    _UserInfo("질문 수", question_num),
                                    _UserInfo("답변 수", answer_num),
                                    _UserInfo("채택 수", select_num),
                                    _UserInfo("포인트", point),
                                    _UserInfo("신고", declaration_num),
                                    _UserInfo("네임드", named),
                                  ],
                                ),
                              )
                            ],
                          )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0, left: 12.0.w, right: 5.0.w),
                      child: DropdownButton(
                        style: TextStyle(
                          fontFamily: "Barun",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        value: _selectedValue,
                        items: _valueList.map(
                                (value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (value) {
                          _selectedValue = value.toString();
                          if (_selectedValue.compareTo(initialValue)==0) {
                            setState(() {
                              _isButtonAbled = false;
                            });
                          } else if (_selectedValue.compareTo(named)==0) {
                            setState(() {
                              _isButtonAbled = false;
                            });
                          } else {
                            setState(() {
                              _changedValue = _selectedValue;
                              _isButtonAbled = true;
                              _isValued = true;
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),
              )
          );
        }
    );
  }

  Widget _UserInfo(type, text) {
    return Padding(
      padding: EdgeInsets.only(top: 3.0),
      child: Text.rich(
        TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: type,
                style: TextStyle(
                  fontFamily: "Barun",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: " : ",
                style: TextStyle(
                  fontFamily: "Barun",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: text,
                style: TextStyle(
                  fontFamily: "Barun",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: themeColor1,
                ),
              ),
            ]
        ),
      ),
    );
  }

  void  _isFalsedButtonDialog() async{

  }

  void _isButtonDialog() async {
    if (_isValued==true) {
      Get.defaultDialog(
        title: "네임드 확인",
        content: Text("네임드를 $named -> $_changedValue 수정합니다."),
        actions: <Widget>[
          FlatButton(
            child: Text("확인"),
            onPressed: () {
              Get.back();
              Get.back();
              // 변경된 네임드 값을 Post 해주면 될듯
            },
          ),
          FlatButton(
            child: Text("취소"),
            onPressed: () {
              Get.back();
            },
          )
        ]
      );
    }
  }
}
