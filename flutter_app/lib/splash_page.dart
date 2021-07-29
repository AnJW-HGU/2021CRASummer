import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:studytogether/Category/category_page.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/animation.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isLoggedIn = false;

  void initState() {
    _controller = AnimationController(
        duration: Duration(seconds: 2), vsync: this, value: 0.1);

    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    _controller.forward();
    super.initState();

    _isLoggedIn = true; //_getUserLoggedInStatus();
  }

  /*_getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      if (value != null) {
        setState(() {
          _isLoggedIn = value;
        });
      }
    });
  }
   */

  Future MainPage() async {
    await Future.delayed(Duration(seconds: 3), () => Navigator.pop(context));
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
            _isLoggedIn ? CategoryPage() : CategoryPage()));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(411.4, 683.4),
        builder: () {
          return Scaffold(
            backgroundColor: HexColor("#FFFFFF"),
            body: _splashPageBody(),
          );
        }
    );
  }

  Widget _splashPageBody() {
    return Scaffold(
      body: FutureBuilder(
        future: MainPage(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                      padding: EdgeInsets.only(left: 130.w, right: 130.w,),
                      width: MediaQuery.of(context).size.width,
                      child: ScaleTransition(
                        scale: _animation,
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.fitWidth,
                        ),
                      )),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('에러');
          } else
            return Center();
        },
      ),
    );
  }

}