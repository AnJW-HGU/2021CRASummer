import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studytogether/Category/subSearch_page.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:ui';

import 'package:studytogether/main.dart';
import 'subSearch_page.dart';
import '../Data/Post_data.dart';



class AddPost {
  int? postClassifi;
  int? postUser;
  int? postImage;
  String? postTitle;
  String? postContent;

  AddPost (inTitle, inContent) {
    postClassifi = 1;
    postUser = 1;
    // postImage = 0;
    postTitle = inTitle;
    postContent = inContent;
  }

  //jsonEncode 함수 있어서 메소드를 부를 필요는 없음
  Map<String, dynamic> toJson() =>
      {
        'classificationId': postClassifi,
        'userId': postUser,
        // 'image_id': postImage,
        'title': postTitle,
        'content': postContent
      };
}

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {

  final addTitle = TextEditingController();
  final addContent = TextEditingController();

  SearchSubs choiceSub = SearchSubs(null, null, null);

  bool _isSub = false;
  bool _isTitle = false;
  bool _isContent = false;
  bool _isButtonAbled = false;

  @override
  void dispose() {
    // 위젯이 dispose 또는 dismiss 될 때 컨트롤러를 clean up!
    addTitle.dispose();
    addContent.dispose();
    super.dispose();
  }


  // Data
  _addPost(inTitle, inContent) async {
    String url = "https://c64ab34d-ad62-4f6e-9578-9a43e222b9bf.mock.pstmn.io/Create/";
    AddPost _addPost = AddPost(inTitle, inContent);

    return (await apiRequest(url, _addPost));
  }

  apiRequest(url, _post) async {
    var body = utf8.encode(jsonEncode(_post));
    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String> {
        'Content-type': 'application/json',
      },
      body: body,
    );

    String reply = "작성에 실패하였습니다.";
    if (response.statusCode == 200) {
      reply = response.body;
    }
    // Http Client로 만들었던 것
    // HttpClient httpClient = new HttpClient();
    // HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    // request.headers.set('content-type', 'application/json');
    // request.add (utf8.encode(jsonEncode(_post)));
    // HttpClientResponse response = await request.close();
    //
    // // todo - you should check the response.statusCode
    // // String reply = await response.transform(utf8.decoder).join();
    // String reply = "작성되었습니다.";
    // httpClient.close(); // 이때 요청함
    return reply;
  }

  Widget _searchSubButton() {
    return OutlinedButton.icon(
        onPressed: () async {
          choiceSub = await Get.to(() => SubSearchPage());
          print("${choiceSub.searchSubs_professor}");
          if (choiceSub.searchSubs_subject != null) {
            setState(() {
              _isSub = true;
            });
          }
        },
        icon: Icon(
          Icons.add_rounded,
          size: 17.w,
          color: themeColor1,
        ),
        label: Text(
          "과목을 선택해주세요.",
          style: TextStyle(
              color: grayColor1,
              fontFamily: "Barun",
              fontSize: 14.sp,
              fontWeight: FontWeight.w400
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.4, 683.4),
      builder: () {
        return Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              "질문 등록",
              style: TextStyle(
                color: grayColor1,
                fontSize: 15.sp,
                fontWeight: FontWeight.w300,
              ),
            ),

            // 뒤로가기 버튼
            leading: IconButton(
              color: themeColor1,
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              tooltip: "Back Button",
              iconSize: 15.w,
              onPressed: () {
                Get.back();
              },
            ),

            // 완료 버튼
            actions: [
              TextButton(
                onPressed: _isButtonAbled ? () async {
                  Get.back();
                  String result = await _addPost("${addTitle.text}", "${addContent.text}");
                  if (result == "OK") {
                    result = "작성이 완료되었습니다.";
                  }
                  else {
                    result = "작성에 실패하였습니다.";
                  }
                  // _addPostData("${addTitle.text}", "${addContent.text}");
                  // Post inPost = new Post("${addTitle.text}", "${addContent.text}");
                  // inPost._addPost();
                  Get.showSnackbar(
                      GetBar(
                        message: result,
                        duration: Duration(seconds: 1),
                        snackPosition: SnackPosition.TOP,
                        maxWidth: 400.w,
                        backgroundColor: themeColor2,
                        borderRadius: 5,
                        barBlur: 0,
                      ),
                  );
                } : _isButtonDialog,
                child: Text(
                  "완료",
                  style: TextStyle(
                    color: _isButtonAbled ? themeColor1 : grayColor1,
                    fontFamily: "Barun",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 과목 검색 버튼
                    Container(
                      padding: EdgeInsets.only(top: 15, left: 20.w, right: 20.w),
                      alignment: Alignment.centerLeft,
                      child: _isSub? _makeChoiceSub(
                          choiceSub.searchSubs_id, choiceSub.searchSubs_professor, choiceSub.searchSubs_subject)
                          : _searchSubButton(),
                    ),

                    // 제목과 내용을 입력하는 필드
                    Container(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: Column(
                        children: [
                          // 제목 적는 곳
                          TextField(
                            controller: addTitle,
                            onChanged: (value) {
                              if (addTitle.text.length >= 1) {
                                setState(() {
                                  _isTitle = true;
                                });
                                if (_isSub == true && _isTitle == true && _isContent == true) {
                                  setState(() {
                                    _isButtonAbled = true;
                                  });
                                }
                              }else {
                                setState(() {
                                  _isTitle = false;
                                  _isButtonAbled = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: "제목",
                              hintStyle: TextStyle(
                                fontFamily: "Barun",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          // 내용 적는 곳
                          Container(
                            child: TextField(
                              controller: addContent,
                              maxLength: 2500,
                              onChanged: (value) {
                                if (addContent.text.length >= 1) {
                                  setState(() {
                                    _isContent = true;
                                  });
                                  if (_isSub == true && _isTitle == true && _isContent == true) {
                                    setState(() {
                                      _isButtonAbled = true;
                                    });
                                  }
                                }else {
                                  setState(() {
                                    _isContent = false;
                                    _isButtonAbled = false;
                                  });
                                }
                              },
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: "내용을 입력해주세요.",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontFamily: "Barun",
                                  fontSize: 15.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 질문 작성 시 규칙
                    Container(
                      padding: EdgeInsets.only(top: 15, left: 20.w, right: 20.w),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "<질문 작성 시 규칙>"
                            "\n\n"
                            "스터디 투게더는 학생들의 학업을 돕고 건강한 학습 문화를 만들기 위해 이용규칙을 제정하여 운영하고 있습니다. "
                            "위반 시 게시물이 삭제 및 포인트가 철회되고 서비스 이용이 일정 기간 제한될 수 있습니다.\n\n"
                            "1. 부적절한 질문 금지\n"
                            "\t- 수업에서 협업을 금지한 과제나 문제에 대한 질문\n"
                            "\t- 시험문제 등 공개 불가능한 문제에 대한 질문\n\n"
                            "2. 채택이나 포인트 조작 행위 금지\n"
                            "\t- 채택 수를 인위적으로 늘려 포인트를 얻는 행위\n"
                            "\t- 의도적으로 채택을 생략하는 행위\n\n"
                            "3. 기타 금지 사항\n"
                            "\t- 타인을 비난하거나 학업 외적인 내용의 질문 및 답변 금지\n"
                            "\t- 범죄, 불법 행위 등 법령을 위반하는 행위",
                        style: TextStyle(
                          color: grayColor2,
                          fontFamily: "Barun",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 사진첨부버튼이 있는 하단 네비게이션 바
          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            elevation: 0.0,

            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "공사 중이에요! :>",
                          style: TextStyle(
                            fontFamily: "Barun",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        backgroundColor: themeColor2,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.camera_alt_rounded,
                    color: themeColor1,
                    size: 30.w,
                  ),
                  tooltip: "Add Image Button",
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _makeChoiceSub(subId, subProfessor, subSubject) {
    return ElevatedButton.icon(
      icon: Icon(
        Icons.close_rounded,
        size: 17.w,
        color: themeColor4,
      ),
      label: Text(
        subSubject+" - "+subProfessor,
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Barun",
            fontSize: 14.sp,
            fontWeight: FontWeight.w400
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: themeColor1,
      ),

      onPressed: () {
        Get.defaultDialog(
            barrierDismissible: false,
            title: "",
            titleStyle: TextStyle(
              fontFamily: "Barun",
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),

            content: Column(
              children: [
                Text(
                    subSubject+"["+subProfessor+"] 를(을)",
                    style: TextStyle(
                      fontFamily: "Barun",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    )
                ),
                Text(
                    "삭제하시겠습니까?",
                    style: TextStyle(
                      fontFamily: "Barun",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    )
                ),
              ],
            ),

            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "아니오",
                  style: TextStyle(
                    color: themeColor1,
                    fontFamily: "Barun",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              TextButton(
                onPressed: () {
                  setState(() {
                    _isSub = false;
                  });
                  choiceSub = SearchSubs(null, null, null);
                  Get.back();
                },
                child: Text(
                  "예",
                  style: TextStyle(
                    color: themeColor1,
                    fontFamily: "Barun",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ]
        );
      },
    );
  }

  void _isButtonDialog () {
    if (_isSub != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "과목이 필요해요!",
            style: TextStyle(
              fontFamily: "Barun",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: themeColor2,
          duration: Duration(seconds: 1),
        ),
      );
    }
    else if (_isTitle != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "제목이 필요해요!",
            style: TextStyle(
              fontFamily: "Barun",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: themeColor2,
          duration: Duration(seconds: 1),
        ),
      );
    }
    else if (_isContent != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "내용이 필요해요!",
            style: TextStyle(
              fontFamily: "Barun",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: themeColor2,
          duration: Duration(seconds: 1),
        ),
      );
    }

  }
}
