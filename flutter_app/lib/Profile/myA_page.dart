import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';

class MyAPage extends StatefulWidget {
  @override
  _MyAPageState createState() => _MyAPageState();
}

class _MyAPageState extends State<MyAPage> {
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
              "질문 수",
              style: TextStyle(
                  fontFamily: "Barun",
                  fontSize: 15.sp,
                  color: grayColor1,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
        );
      }
    );
  }
}
