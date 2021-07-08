import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:studytogether/Login/signUp_page.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(411.4, 683.4),
        builder: () {
          return Scaffold(
            backgroundColor: HexColor("#FFFFFF"),
            body: _loginPageBody(),
          );
        }
    );

  }

  Widget _loginPageBody() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 150.h, left: 50.w, right: 50.w),
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
                color: HexColor("#FFFFFF"),
              ),
              style: ElevatedButton.styleFrom(
                primary: themeColor1,
                //onPrimary: themeColor2,
                elevation: 5.0,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                ),
              ),
              onPressed: () {},
              label: Text("    Log in with Google     ", style: TextStyle(
                  color: HexColor("#FFFFFF"),
                  fontWeight: FontWeight.w500,
                  fontSize: 17.sp
              ),),
            ),
            SizedBox(height: 12.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('If this is your first visit  ',style: TextStyle(
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
                        Get.to(SignUpPage());
                      },
                      child: Text("Sign up", style: TextStyle(
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
            ),
          ],
        ),
      ),
    );
  }

}
