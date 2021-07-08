import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
                icon: Icon(Icons.arrow_back_ios_new_rounded, size: 21.w,),
              ),
              backgroundColor: themeColor1,
              title: Text('설정', style: TextStyle(fontFamily: "Barun", color: Colors.white, fontSize: 16.w, fontWeight: ),),
              centerTitle: true,
            ),
            body: _settingPageBody(),
          );
      }
    );
  }

  Widget _settingPageBody() {
    return Container();
  }
}
