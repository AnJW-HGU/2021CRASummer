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
          );
        }
    );
  }
}
