import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'setting_page.dart';

// postman 주소 https://4a20d71c-75da-40dd-8040-6e97160527b9.mock.pstmn.io/put?user_id=1
// Post 넣어야됨
Future<User> editNickname(String nickname) async{
  final response = await http.put(
      Uri.parse('http://128.199.139.159:3000/user/1/nickname'),
      headers: <String, String> {
        'Content-Type' : 'application/json',
      },
      body: jsonEncode(<String, String>{
        'nickname' : nickname,
      })
  );
  if(response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load nickname');
  }
}

class User {
  var nickname;

  User({required this.nickname});

  factory User.fromJson(String nickname) {
    return User(
      nickname: nickname,
    );
  }

// Map <String, dynamic> toJson() => {
//   'nickname' : nickname,
// };
}


class EditNicknamePage extends StatefulWidget {
  @override
  _EditNicknamePageState createState() => _EditNicknamePageState();
}

class _EditNicknamePageState extends State<EditNicknamePage> {
  final _newnickName = TextEditingController(text: Get.arguments);
  final int maxLength = 8;
  String textValue = Get.arguments;
  String n= "";

  // 데이터 받아져 왔나 ?
  Future<User>? _user;

  @override
  // 위젯이 dispose 또는 dismiss 될 때 컨트롤러를 clean up!
  void dispose() {
    _newnickName.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    editNickname(n);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(411.4, 683.4),
        builder: () {
          return Scaffold(
            backgroundColor: themeColor1,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Get.off(()=>SettingPage());
                },
                color: Colors.white,
                icon: Icon(Icons.arrow_back_ios_new_rounded, size: 15.w,),
              ),
              elevation: 0.0,
              backgroundColor: themeColor1,
              title: Text(
                '닉네임 변경',
                style: TextStyle(
                    fontFamily: "Barun",
                    color: Colors.white,
                    fontSize: 15.sp
                ),
              ),
              centerTitle: true,
            ),
            body: Center(
                child: FutureBuilder<User>(
                    future: _user,
                    builder: (context, snapshot) {
                      print(snapshot.data);
                      if(snapshot.data == null) {
                        return Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 70)),
                            // 닉네임 입력 칸
                            Container(
                              alignment: Alignment.center,
                              width: 200.w,
                              child: TextField(
                                controller: _newnickName,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[ㄱ-ㅎ|가-힣|ㆍ|ᆢ]'))],
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontSize: 20.sp, fontFamily: "Barun", fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  counterStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.75),
                                  ),
                                  hintText: "변경할 닉네임을 입력해주세요",
                                  counterText: "",
                                  suffix: Text("${textValue.length} / $maxLength", style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.75), fontFamily: "Barun")),
                                  hintStyle: TextStyle(fontSize: 14.sp, color: Colors.white, fontFamily: "Barun",),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white.withOpacity(0.75))
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white.withOpacity(0.75))
                                  ),
                                ),
                                maxLength: maxLength,
                                onChanged: (value) {
                                  setState(() {
                                    textValue = value;
                                  });
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 15),),
                            Text(
                              '닉네임은 최대 8자까지 가능합니다.',
                              style: TextStyle(fontFamily: "Barun", color: Colors.white.withOpacity(0.75), fontSize: 13.sp),
                            ),
                            Padding(padding: EdgeInsets.only(top: 3),),
                            Text(
                              '띄워쓰기, 영어, 특수문자 제외',
                              style: TextStyle(fontFamily: "Barun", color: Colors.white.withOpacity(0.75), fontSize: 13.sp),
                            ),
                            Padding(padding: EdgeInsets.only(top: 30),),
                            // 변경완료 버튼
                            MaterialButton(
                                minWidth: 100,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.white,
                                elevation: 5,
                                child: Text("변경 완료", style: TextStyle(fontFamily: "Barun", color: themeColor1, fontSize: 15.sp),),
                                onPressed: () {
                                  setState((){
                                    _user = editNickname(_newnickName.text);
                                  });
                                  Get.off(() => SettingPage());
                                }
                            ),
                          ],
                        );
                      } else if(snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    }
                )
            ),
          );
        }
    );
  }

}