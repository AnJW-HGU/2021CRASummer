import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:studytogether/Category/category_page.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';


class SetNicknamePage extends StatefulWidget {
  @override
  _SetNicknamePageState createState() => _SetNicknamePageState();
}

class _SetNicknamePageState extends State<SetNicknamePage> {
  bool _isChecked1 = false; //이용약관
  bool _isChecked2 = false; //개인정보 처리
  bool agree = false; //둘 다 동의했는지
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(411.4, 683.4),
        builder: () {
          return Scaffold(
            backgroundColor: HexColor("#FFFFFF"),
            resizeToAvoidBottomInset: false,
            body: _setNicknamePageBody(),
          );
        }
    );
  }

  Widget _setNicknamePageBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Login.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        //중간 정렬
        child: Center(
          child: Container(
            //위치 조정
            padding: EdgeInsets.only(top: 150.h, left: 80.w, right: 80.w),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //닉네임 받기
                    TextField(
                      textAlign: TextAlign.center,
                      //닉네임 문자 제한
                      maxLength: 8,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[ㄱ-ㅎ|가-힣|ㆍ|ᆢ]'))],
                      cursorHeight: 20,
                      decoration: InputDecoration(
                        /*counterStyle: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                        ),
                        counterText: "",*/
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: '닉네임은 최대 8글자까지 가능합니다',
                        hintStyle: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                          color: HexColor("#C2C2C2"),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: themeColor2)
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: themeColor2),
                        ),
                        counterStyle: TextStyle(
                          color: themeColor2,
                        ),
                      ),
                    ),

                    //선 긋기
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 10.w, right: 10.w, bottom: 10),
                      child: Divider(color: themeColor3, thickness: 1.0,),
                    ),

                    //이용약관
                    Container(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: const Text('이용약관', style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.lightBlue,
                          fontFamily: "Barun",
                        ),),
                        value: _isChecked1,
                        onChanged: (value) {
                          setState(() {
                            _isChecked1 = value!;
                          });
                        },
                        activeColor: themeColor2,
                        checkColor: Colors.white,
                        isThreeLine: false,
                        selected: _isChecked1,
                      ),
                    ),

                    //개인정보처리방침
                    Container(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: const Text('개인정보 처리방침', style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.lightBlue,
                          fontFamily: "Barun",
                        ),),
                        value: _isChecked2,
                        onChanged: (value) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                  return AlertDialog(
                                    title: Text("CheckBox"),
                                    actions: <Widget>[
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: checked,
                                                onChanged: (value) {
                                                  setState(() {
                                                    checked = value!;
                                                  });
                                                },
                                              ),
                                              Text('동의합니다'),
                                            ],
                                          ),
                                          MaterialButton(
                                            onPressed: () {
                                              _isChecked2 = checked;
                                              Get.back();
                                            },
                                            child: Text("확인"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                          setState(() {
                            _isChecked2 = checked;
                          });

                        },
                        activeColor: themeColor2,
                        checkColor: Colors.white,
                        isThreeLine: false,
                        selected: _isChecked2,
                      ),
                    ),

                    //선 긋기
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 10.w, right: 10.w, bottom: 30),
                      child: Divider(color: themeColor3, thickness: 1.0,),
                    ),

                    //확인 버튼
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 45,
                      onPressed: () {},//_isChecked1 ? (_isChecked2 ? whenTap : null) : null,
                      color: themeColor1,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Text("확인", style: TextStyle(
                        color: HexColor("#FFFFFF"),
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp,
                        shadows: [Shadow(
                          color: blurColor,
                          offset: Offset(0,2.0),
                          blurRadius: 2,
                        )],
                      ),),
                      //버튼 비활성화 색
                      //disabledElevation: 5,
                      disabledColor: grayColor2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //확인 버튼이 눌렸을 때
  void whenTap(){
    Get.offAll(CategoryPage());
  }
}