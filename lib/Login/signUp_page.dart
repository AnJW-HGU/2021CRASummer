import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:studytogether/Login/login_page.dart';
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
            backgroundColor: HexColor("#FFFFFF"),
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: HexColor("#FFFFFF"),
              leading: IconButton(
                onPressed: () {
                  Get.off(LoginPage());
                },
                icon: Icon(
                    Icons.arrow_back_ios_new_outlined, size: 20.w, color: themeColor1),
              ),
            ),
            body: _signUpPageBody(),
          );
        }
    );
  }

  Widget _signUpPageBody() {
    return Center(
        child: Container(
          padding: EdgeInsets.only(top: 80.h, left: 50.w, right: 50.w),
          child: Column(
            children: [
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
                onPressed: () {},
                label: Text("   Sign Up with Google     ", style: TextStyle(
                    color: themeColor1,
                    fontWeight: FontWeight.w500,
                    fontSize: 17.sp
                ),),
              ),
              SizedBox(height: 12.h,),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text('If you already have an account  ',style: TextStyle(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w300,
                        color: themeColor1,
                        fontFamily: "Barun", //폰트 지정
                      ),),
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.off(LoginPage());
                        },
                        child: Text("Log in", style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: themeColor1,
                          fontFamily: "Barun",
                          decoration: TextDecoration.underline,
                        ),),
                      ),
                    ],
                  ),
                ],
              ),*/
            ],
          ),
        ),
    );
  }

}