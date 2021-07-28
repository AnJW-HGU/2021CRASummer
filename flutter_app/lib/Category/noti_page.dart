import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:studytogether/main.dart';

class NotiPage extends StatefulWidget {
  const NotiPage({Key? key}) : super(key: key);

  @override
  _NotiPageState createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.4, 683.4),
      builder: () {
        return Scaffold(
          backgroundColor: themeColor1,

          appBar: AppBar(
            title: Text(
                "알림"
            ),
          ),

          body: SafeArea(
            child: Center(
              child: Text(
                "Hi",
              ),
            ),
          ),
        );
      },
    );
  }
}