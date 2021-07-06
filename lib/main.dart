import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:studytogether/Category/category_page.dart';

final themeColor1 = HexColor("#0080FF");

void main() {
  runApp(
    MyApp()
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CategoryPage(),
    );
  }
}

