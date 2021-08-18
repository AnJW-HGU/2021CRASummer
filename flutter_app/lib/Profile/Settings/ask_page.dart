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
  String _initialValue = '종류';
  final _addTitle = TextEditingController();
  final _addContent = TextEditingController();

  bool _isButtonAbled = false;
  bool _isList = false;
  bool _isTitle = false;
  bool _isContent = false;

  @override
  void dispose() {
    // 위젯이 dispose 또는 dismiss 될 때 컨트롤러를 clean up!
    _addTitle.dispose();
    _addContent.dispose();
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
                      color: _isButtonAbled ? themeColor1 : grayColor1,
                    ),
                  ),
                  onPressed : _isButtonAbled ? _isButtonDialog
                      : _isButtonDialog,
                )
              ],
            ),
            body: SafeArea(
                child: Column(
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
                          _selectedValue = value.toString();
                          if(_selectedValue.compareTo(_initialValue) == 0){
                            setState(() {
                              _isList = false;
                            });
                          }else {
                            setState(() {
                              _selectedValue = value.toString();
                              _isList = true;
                              if(_isList == true && _isTitle == true && _isContent == true) {
                                setState(() {
                                  _isButtonAbled = true;
                                });
                              }
                            });
                          }
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
                                      controller: _addTitle,
                                      onChanged: (value) {
                                        if(_addTitle.text.length >= 1) {
                                          setState(() {
                                            _isTitle = true;
                                          });
                                          if(_isList == true && _isTitle == true && _isContent == true) {
                                            setState(() {
                                              _isButtonAbled = true;
                                            });
                                          }
                                        } else {
                                          setState(() {
                                            _isTitle = false;
                                            _isButtonAbled = false;
                                          });
                                        }
                                      },
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
                                        controller: _addContent,
                                        onChanged: (value) {
                                          if (_addContent.text.length >= 1) {
                                            setState(() {
                                              _isContent = true;
                                            });
                                            if (_isList == true && _isTitle == true && _isContent == true) {
                                              setState(() {
                                                _isButtonAbled = true;
                                              });
                                            }
                                          }else {
                                            setState(() {
                                              _isContent = false;
                                              _isButtonAbled = false;
                                            });
                                          }
                                        },
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
                ),
            ),
          );
        });
  }

  void _isButtonDialog() async {
    if (_isList != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "종류 선택이 필요해요!",
            style: TextStyle(
              fontFamily: "Barun",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: themeColor2,
          duration: Duration(seconds: 1),
        ),
      );
      // Get.defaultDialog(
      //   barrierDismissible: true,
      //   title: "",
      //   titleStyle: TextStyle(
      //     fontFamily: "Barun",
      //     fontSize: 15.sp,
      //     fontWeight: FontWeight.w400,
      //   ),
      //   content: Text(
      //     "과목을 선택해주세요\n",
      //     style: TextStyle(
      //       fontFamily: "Barun",
      //       fontSize: 17.sp,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      // );
    }
    else if (_isTitle != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "제목이 필요해요!",
            style: TextStyle(
              fontFamily: "Barun",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: themeColor2,
          duration: Duration(seconds: 1),
        ),
      );
      // Get.defaultDialog(
      //   barrierDismissible: true,
      //   title: "",
      //   titleStyle: TextStyle(
      //     color: grayColor2,
      //     fontFamily: "Barun",
      //     fontSize: 16.sp,
      //     fontWeight: FontWeight.w400,
      //   ),
      //   content: Text(
      //     "제목을 입력해주세요\n",
      //     style: TextStyle(
      //       color: themeColor1,
      //       fontFamily: "Barun",
      //       fontSize: 17.sp,
      //       fontWeight: FontWeight.w500,
      //     ),
      //   ),
      // );
    }
    else if (_isContent != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "내용이 필요해요!",
            style: TextStyle(
              fontFamily: "Barun",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: themeColor2,
          duration: Duration(seconds: 1),
        ),
      );
      // Get.defaultDialog(
      //   barrierDismissible: true,
      //   title: "",
      //   titleStyle: TextStyle(
      //     color: grayColor1,
      //     fontFamily: "Barun",
      //     fontSize: 15.sp,
      //     fontWeight: FontWeight.w400,
      //   ),
      //   content: Text(
      //     "내용을 입력해주세요\n",
      //     style: TextStyle(
      //       color: themeColor1,
      //       fontFamily: "Barun",
      //       fontSize: 17.sp,
      //       fontWeight: FontWeight.w500,
      //     ),
      //   ),
      // );
    }else if (_isButtonAbled){
      Get.defaultDialog(
          title: "문의 확인",
          content: Text("문의를 보내시겠습니까 ?"),
          actions: <Widget>[
            FlatButton(
              child: Text("확인"),
              onPressed: () {
                Get.back();
                Get.back();
                // 문의 보내기(Post)
              },
            ),
            FlatButton(
              child: Text("취소"),
              onPressed: () {
                Get.back();
              },
            ),
          ]
      );
    }
  }
}


