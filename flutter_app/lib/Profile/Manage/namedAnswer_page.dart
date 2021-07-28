import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:get/get.dart';

import 'package:studytogether/main.dart';

class NamedAnswerPage extends StatefulWidget {
  @override
  _NamedAnswerPageState createState() => _NamedAnswerPageState();
}

class _NamedAnswerPageState extends State<NamedAnswerPage> {
  String studentId = Get.arguments[0];
  String title_content = Get.arguments[1];


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
                color: themeColor2,
                icon: Icon(Icons.arrow_back_ios_new_rounded, size: 15.w,),
              ),
              centerTitle: true,
              title: Text(
                "네임드",
                style: TextStyle(
                  fontFamily: "Barun",
                  color: grayColor1,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
              actions: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "완료",
                      style: TextStyle(
                        fontFamily: "Barun",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                ),
              ],
            ),
          );
        }
    );
  }
}
