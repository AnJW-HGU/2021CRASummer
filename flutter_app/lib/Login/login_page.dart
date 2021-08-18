import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:studytogether/Category/category_page.dart';
import 'package:studytogether/Login/signUp_page.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:studytogether/splash_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  getToken() async{
    var token  = await FirebaseMessaging.instance.getToken();
    return token;
  }



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

  fetch() async{
  var res = await http.get(Uri.parse('http://128.199.139.159:3000/login'));
  return jsonDecode(res.body);
  }

  Widget _loginPageBody() {
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
            padding: EdgeInsets.only(left: 50.w, right: 50.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // //'ST' 넣기
                // Text('',
                //   style: TextStyle(
                //     letterSpacing: -8,
                //     fontSize: 60.sp,
                //     fontWeight: FontWeight.w400,
                //     color: themeColor1,
                //     fontFamily: "Barun", //폰트 지정
                //     // shadows: [Shadow(
                //     //   color: blurColor,
                //     //   offset: Offset(0,4.0),
                //     //   blurRadius: 4,
                //     // )]
                //   ),
                // ),
                // SizedBox(height: 100.h,),
                // //아이콘이 포함된 버튼( 로그인 버튼 )
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.g_mobiledata_sharp,
                    size: 45,
                    color: HexColor("#FFFFFF"),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: themeColor1,
                    //onPrimary: themeColor2,
                    elevation: 5.0,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                  ),
                  //버튼이 눌리면 동작
                  onPressed: () {
                    String token = getToken();
                    print('${token}');
                    Get.offAll(() => SplashPage());
                    /*var isLogined = fetch();
                    if(isLogined == true){
                      Get.offAll(() => CategoryPage());
                    } else if(isLogined == false) {
                      print("false");
                    }

                     */
                  },
                  //버튼 안에 text
                  label: Text("학교 계정으로 시작하기  ", style: TextStyle(
                      fontFamily: "Barun",
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
                SizedBox(height: 12,),
                //로그인 버튼 밑의 글( 회원가입으로 넘어가는 버튼 )
                // //선 긋기
                // Padding(
                //   padding: EdgeInsets.only(top: 5, left: 120.w, right: 120.w, bottom: 5),
                //   child: Divider(color: themeColor3, thickness: 1.5,),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text('앱이 처음이라면  ',style: TextStyle(
                            fontSize: 14.5.sp,
                            fontWeight: FontWeight.w300,
                            color: themeColor1,
                            fontFamily: "Barun",
                            // shadows: [Shadow(
                            //   color: blurColor,
                            //   offset: Offset(0,1.0),
                            //   blurRadius: 2,
                            // )]
                        ),),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          //누르면 회원가입 페이지로
                          onTap: () {
                            Get.to(() => SignUpPage());
                          },
                          child: Text("회원가입", style: TextStyle(
                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w500,
                              color: themeColor1,
                              fontFamily: "Barun",
                              decoration: TextDecoration.underline,
                              shadows: [Shadow(
                                color: blurColor,
                                offset: Offset(0,1.0),
                                blurRadius: 1,
                              )]
                          ),),
                        ),
                      ],
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
