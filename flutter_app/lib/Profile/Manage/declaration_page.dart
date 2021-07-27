import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:get/get.dart';

import 'package:studytogether/main.dart';

class DeclarationPage extends StatefulWidget {
  @override
  _DeclaraionPageState createState() => _DeclaraionPageState();
}

class _DeclaraionPageState extends State<DeclarationPage> {
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
                color: Colors.white,
                icon: Icon(Icons.arrow_back_ios_new_rounded, size: 15.w,),
              ),
              centerTitle: true,
              title: Text(
                "신고",
                style: TextStyle(
                  fontFamily: "Barun",
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              backgroundColor: themeColor2,
              elevation: 0.0,
            ),
          );
        }
    );
  }
}
