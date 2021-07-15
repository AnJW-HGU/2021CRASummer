import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:studytogether/Login/setNickname_page.dart';
import 'package:studytogether/Login/signUp_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../main.dart';
import 'package:http/http.dart' as http;


class GoogleLoginPage extends StatefulWidget {
  @override
  _GoogleLoginPageState createState() => _GoogleLoginPageState();
}

class _GoogleLoginPageState extends State<GoogleLoginPage> {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(411.4, 683.4),
        builder: () {
          return Scaffold(
            //돌아가는 버튼
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Get.offAll(SetNicknamePage());
                },
                icon: Icon(
                    Icons.arrow_back_ios_sharp, size: 20.w, color: themeColor1),
              ),
            ),
            extendBodyBehindAppBar: true,
            body: _GoogleLoginPageBody(),
          );
        }
    );
  }

  Future<String> fetch() async{
    var res = await http.get(Uri.parse('http://128.199.139.159.nip.io:3000/auth/google'));
    print(res.body);
    return res.body;
  }


  Widget _GoogleLoginPageBody() {
    var isloading = true;
    var html_data = "";

    fetch().then((value) => {
      html_data = value,
      isloading = false,
    });

    if (isloading) {
      return Container(
        child: Column(
          children: [
            Text("로딩중")
          ],
        ),
      );
    }
    else {
      return Container(
        child: SafeArea(
          child: Html(
            data: html_data
          ),
        ),
      );
    }

  }
}


