import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:studytogether/Category/category_page.dart';
import 'package:studytogether/splash_page.dart';

final themeColor1 = HexColor("#0080FF");
final themeColor2 = HexColor("#03A6FF");
final themeColor3 = HexColor("#A3DAFF");
final themeColor4 = HexColor("#DAF0FF");

final blurColor = Colors.black.withOpacity(0.25);

final grayColor1 = HexColor("5C5C5C"); // 767676도 이거 쓰면 됨.
final grayColor2 = HexColor("ADADAD");

void main() {
  runApp(
      MyApp()
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashPage(),
    );
  }
}
