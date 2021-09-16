import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';

class SponPage extends StatefulWidget {
  @override
  _SponPageState createState() => _SponPageState();
}

class _SponPageState extends State<SponPage> {

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
                "개발자 페이지",
                style: TextStyle(
                  color: grayColor1,
                  fontFamily: "Barun",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
              elevation: 0,
            ),
            body: _SponPageBody(),
          );
        }
    );
  }

  Widget _SponPageBody() {
    return Padding(
      padding: EdgeInsets.only(top: 30.0, bottom: 30.0, left: 20.0.w, right: 20.0.w),
      // child: Container(
      //     padding: EdgeInsets.only(top: 30.0, bottom: 30.0, left: 20.0.w, right: 20.0.w),
      //     width: 240.w,
      //     color: themeColor4,
      //     child: Column(
      //       children: [
      //         // Text(
      //         //   "안녕하세요!",
      //         //   style: TextStyle(
      //         //     fontFamily: "Barun",
      //         //     fontSize: 20.sp,
      //         //     fontWeight: FontWeight.w600,
      //         //   ),
      //         // ),
      //       ],
      //     )
      // ),
    );
  }
}