import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';

class PrivacyRulePage extends StatefulWidget {
  @override
  _PrivacyRulePageState createState() => _PrivacyRulePageState();
}

class _PrivacyRulePageState extends State<PrivacyRulePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(411.4, 683.4),
        builder: () {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  "개인정보 처리방침",
                style: TextStyle(
                    fontSize: 15.sp
                ),),
            ),
          );
        }
    );
  }
}
