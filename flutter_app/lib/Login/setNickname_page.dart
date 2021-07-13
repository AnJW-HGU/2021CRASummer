import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';


class SetNicknamePage extends StatefulWidget {
  @override
  _SetNicknamePageState createState() => _SetNicknamePageState();
}

class _SetNicknamePageState extends State<SetNicknamePage> {
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
                        TextField(
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          cursorHeight: 20,
                          decoration: InputDecoration(
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
                          ),
                        ),
                        //선 긋기
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 10.w, right: 10.w, bottom: 20),
                          child: Divider(color: themeColor3, thickness: 1.0,),
                        ),
                        //이용약관, 개인정보처리방침



                        //선 긋기
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 10.w, right: 10.w, bottom: 20),
                          child: Divider(color: themeColor3, thickness: 1.0,),
                        ),
                        //확인 버튼
                        MaterialButton(
                          minWidth: double.infinity,
                          height: 45,
                          //버튼이 눌리면 동작
                          onPressed: () {},
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
                                blurRadius: 4,
                              )]
                          ),),
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

}