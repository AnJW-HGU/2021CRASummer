import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:get/get.dart';

import 'package:studytogether/main.dart';

class RankPage extends StatefulWidget {
  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(411.4, 683.4),
        builder: () {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                color: themeColor1,
                icon: Icon(Icons.arrow_back_ios_new_rounded, size: 15.w),
              ),
              title: Text(
                "포인트 순위",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: "Barun",
                  color: grayColor1,
                ),
              ),
              centerTitle: true,
            ),
            body: _rankPageBody(),
          );
        }
    );
  }

  Widget _rankPageBody() {
    return Container();
  }
}