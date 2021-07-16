import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';

class UseRulePage extends StatefulWidget {
  @override
  _UseRulePageState createState() => _UseRulePageState();
}

class _UseRulePageState extends State<UseRulePage> {
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
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                "이용약관",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: "Barun",
                  color: grayColor1,
                ),
              ),
            ),
          );
        }
    );
  }
}
