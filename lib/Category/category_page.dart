import 'package:flutter/material.dart';
import 'package:studytogether/Profile/myProfile_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui';

class CategoryHomePage extends StatefulWidget {
  const CategoryHomePage({Key? key}) : super(key: key);

  @override
  _CategoryHomePageState createState() => _CategoryHomePageState();
}

class _CategoryHomePageState extends State<CategoryHomePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(411.4, 683.4),
        builder: () {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  "Appbar"
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.circle_rounded),
                  onPressed: () {
                    Get.to(MyProfilePage());
                  }
                ),
              ],
            ),
          );
        }
    );
  }
}
