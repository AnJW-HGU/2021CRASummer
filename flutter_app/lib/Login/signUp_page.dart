import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:studytogether/Login/googleLogin_page.dart';
import 'package:studytogether/Login/login_page.dart';
import 'package:studytogether/Login/setNickname_page.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(411.4, 683.4),
        builder: () {
          return Scaffold(
            //돌아가는 버튼
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  Get.off(LoginPage());
                },
                icon: Icon(
                    Icons.arrow_back_ios_sharp, size: 20.w, color: themeColor1),
              ),
            ),
            extendBodyBehindAppBar: true,
            body: _signUpPageBody(),
          );
        }
    );
  }

  Widget _signUpPageBody() {
    //배경 넣기
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
            padding: EdgeInsets.only(top: 95.h, left: 50.w, right: 50.w),
            child: Column(
              children: [
                //'ST' 넣기
                Text('ST',style: TextStyle(
                    fontSize: 64.sp,
                    fontWeight: FontWeight.w400,
                    color: themeColor1,
                    fontFamily: "Barun", //폰트 지정
                    shadows: [Shadow(
                      color: blurColor,
                      offset: Offset(0,4.0),
                      blurRadius: 4,
                    )]
                ),),
                SizedBox(height: 100.h,),
                //아이콘이 포함된 버튼( 회원가입 버튼 )
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.g_mobiledata_sharp,
                    size: 50,
                    color: themeColor1,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: HexColor("#FFFFFF"),
                    //onPrimary: themeColor2,
                    elevation: 5.0,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                    side: BorderSide(
                      width: 1.5, color: themeColor1,
                    ),
                  ),
                  //버튼이 눌리면 동작
                  onPressed: () {
                    Get.to(GoogleLoginPage());
                    //Get.to(SetNicknamePage());
                  },
                  //버튼 안에 text
                  label: Text("   Sign Up with Google     ", style: TextStyle(
                      color: themeColor1,
                      fontWeight: FontWeight.w500,
                      fontSize: 17.sp,
                      shadows: [Shadow(
                        color: blurColor,
                        offset: Offset(0,1.0),
                        blurRadius: 2,
                      )]
                  ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}