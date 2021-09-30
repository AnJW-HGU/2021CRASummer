import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:studytogether/Category/category_page.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/animation.dart';
import 'package:http/http.dart' as http;

import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'Login/login_page.dart';

Future<Splash_T> GetToken() async {
  var response = await http.get(Uri.parse('http://128.199.139.159:3000/auth/check'));

  if (response.statusCode == 200) {
    // 만약 서버로의 요청이 성공하면, JSON을 파싱합니다.
    return await Future.delayed(Duration(seconds: 1), () => Splash_T.fromJson(json.decode(response.body)));
  } else {
    // 만약 요청이 실패하면, 에러를 던집니다.
    throw Exception('Failed to load post');
  }
}

class Splash_T {
  var splash_token;

  Splash_T({this.splash_token});

  factory Splash_T.fromJson(Map<String, dynamic> json) {
    return Splash_T(
      splash_token: json["token"],
    );
  }
}

Future<Splash_Id> GetUserId(String token) async {
  final url = '128.199.139.159:3000';
  final path = '/auth/load';
  var params = {
    'token' : token,
  };

  var response = await http.get(Uri.http(url, path, params));

  if (response.statusCode == 200) {
    // 만약 서버로의 요청이 성공하면, JSON을 파싱합니다.
    return await Splash_Id.fromJson(json.decode(response.body));
  } else {
    // 만약 요청이 실패하면, 에러를 던집니다.
    throw Exception('Failed to load post');
  }
}

class Splash_Id {
  var splash_userid;

  Splash_Id({this.splash_userid});

  factory Splash_Id.fromJson(Map<String, dynamic> json) {
    return Splash_Id(
        splash_userid: json["user_id"]
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Future<Splash_T> splash_t;
  late Future<Splash_Id> splash_id;

  late AnimationController _controller;
  late Animation<double> _animation;

  //bool _isLoggedIn = true;
  String _token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEwNzU2NDE0NTkyMjQyMTI0MjU3MSIsImlhdCI6MTYyOTQ0OTM3MiwiZXhwIjoxNjI5NDUyOTcyLCJpc3MiOiJzdHVkeV90b2dldGhlciJ9.jVCVePKIg2NptBMNx81CaZmWFJ9QaxzdIiThxq7FqsQ";
  var _userId;

  void initState() {
    _controller = AnimationController(
        duration: Duration(seconds: 2), vsync: this, value: 0.1);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);
    _controller.forward();
    super.initState();
    splash_t = GetToken();
    splash_id = GetUserId(_token);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future MainPage(bool _isLoggedIn) async {
    await Future.delayed(Duration(seconds: 0), () => Navigator.pop(context));
    print('로그인 : '+_isLoggedIn.toString());
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
            _isLoggedIn ? CategoryPage() : LoginPage()
        ));
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
      body: FutureBuilder<Splash_T>(
        future: splash_t,
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
          } else{
            if(snapshot.data!.splash_token is String) {
              _token = snapshot.data!.splash_token;
              print(_token);

              FutureBuilder<Splash_Id>(
                future: splash_id,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData == false) {
                    return Column();
                  } else if (snapshot.hasError) {
                    return Text('에러');
                  } else {
                    _userId = snapshot.data!.splash_userid;
                    print(_userId);
                    return Center();
                  }
                },
              );
              MainPage(true);
            } else {
              MainPage(false);
            }
            return Center();
          }
        },
      ),
    );
  }
}