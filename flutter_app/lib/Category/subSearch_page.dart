import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:ui';

import 'package:studytogether/main.dart';

// class AddPost {
//   String? postClassifi;
//   String? postUser;
//   String? postImage;
//   String? postTitle;
//   String? postContent;
//
//   AddPost (inTitle, inContent) {
//     postClassifi = '011220';
//     postUser = '200404';
//     postImage = '0';
//     postTitle = inTitle;
//     postContent = inContent;
//   }
//
//   //jsonEncode 함수 있어서 메소드를 부를 필요는 없음
//   Map<String, dynamic> toJson() =>
//       {
//         'classification_id': postClassifi,
//         'user_id': postUser,
//         'image_id': postImage,
//         'title': postTitle,
//         'content': postContent
//       };
// }


class SubSearchPage extends StatefulWidget {
  const SubSearchPage({Key? key}) : super(key: key);

  @override
  _SubSearchPageState createState() => _SubSearchPageState();
}

class _SubSearchPageState extends State<SubSearchPage> {

  final _userId = ""; // 유저 아이디
  final _subSelect = ""; // 선택한 과목
  final _proSelect = ""; // 선택한 과목의 교수님

  final _subSearchFilter = TextEditingController();

  bool _isSearching = false;

  var _subSearchitem = <String> [];
  var _proSearchitem = <String> [];

  var _subList = <String>[
    "데이타 구조", "데이타 프로그래밍", "데이타 언어", "데2",
    "데이타", "데이타 강형", "데이타 지원", "데이터 모음",
    "데이타인데요", "성경", "재이수", "재수",
  ].obs;

  var _proList = <String>[
    "강형", "소은", "고은", "현서",
    "햄찌", "햄햄", "지원", "도비",
    "교수", "교수?", "교수수", "옥수수",
  ].obs;


  // _SubSearchPageState() {
  //   _subSearch.addListener(() {
  //     if (_subSearch.text.isEmpty) {
  //       setState(() {
  //         _filterText = "";
  //       });
  //     }
  //     else {
  //       setState(() {
  //         _filterText = _subSearch.text;
  //       });
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _subSearchitem.clear();
    _proSearchitem.clear();
    this._isSearching = false;
  }

  @override
  void dispose() {
    // 위젯이 dispose 또는 dismiss 될 때 컨트롤러를 clean up!
    _subSearchFilter.dispose();
    super.dispose();
  }

  // void _addPost(inTitle, inContent) async {
  //   String url = "https://c64ab34d-ad62-4f6e-9578-9a43e222b9bf.mock.pstmn.io/Create/";
  //   AddPost _addPost = AddPost(inTitle, inContent);
  //
  //   print(await apiRequest(url, _addPost));
  // }
  //
  // Future<String> apiRequest(url, _post) async {
  //   HttpClient httpClient = new HttpClient();
  //   HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  //   request.headers.set('content-type', 'application/json');
  //   request.add (utf8.encode(jsonEncode(_post)));
  //   HttpClientResponse response = await request.close();
  //
  //   // todo - you should check the response.statusCode
  //   // String reply = await response.transform(utf8.decoder).join();
  //   String reply = "작성되었습니다.";
  //   httpClient.close(); // 이때 요청함
  //   return reply;
  // }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.4, 683.4),
      builder: () {


        return Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: Container(
              height: 32,
              child: TextField(
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.bottom,
                // textInputAction: TextInputAction.go,
                controller: _subSearchFilter,
                onSubmitted: (text) {
                  setState(() {
                    _subSearchitem.clear();
                    _proSearchitem.clear();
                    _isSearching ? Center(child: CircularProgressIndicator()) :
                    _getSubData();
                  });

                },
                // 과목 검색하기
                decoration: InputDecoration(
                  // border 설정
                  enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: themeColor1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: themeColor1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),

                  // prefixIcon: Icon(Icons.search_rounded, color: themeColor1,),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _subSearchFilter.clear();
                      setState(() {
                        _subSearchitem.clear();
                        _proSearchitem.clear();
                      });
                      // FocusScope.of(context).unfocus();
                      },
                    padding: EdgeInsets.all(0.0),
                    icon: Icon(Icons.clear, color: themeColor1,),
                  ),

                  hintText: "강의명 또는 교수명을 입력하세요.",
                  hintStyle: TextStyle(
                    fontFamily: "Barun",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
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
          ),
          body: SafeArea(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  child: _isSearching ? CircularProgressIndicator() :
                        _subSearchitem.isEmpty ? _initSubSearch() : _makeSubList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _initSubSearch() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "강의가 존재하지 않아요 :<"
            "\n과목 검색하는 방법:",
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 5.h,
              color: themeColor1,
              fontFamily: "Barun",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "예) 스, 스터디, 스터디 투게더",
            textAlign: TextAlign.center,
            style: TextStyle(
              // height: 10.h,
              color: themeColor1,
              fontFamily: "Barun",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _makeSubList() {
    return ListView.separated(
      itemCount: _subSearchitem.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Get.back(),
          child: Container(
            // padding: EdgeInsets.only(top: 10, bottom: 5, left: 25.w, right: 20.w,),
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 25.w, right: 25.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${_subSearchitem[index]}",
                        style: TextStyle(
                          color: themeColor1,
                          fontFamily: "Barun",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 5)),
                      Text(
                        "${_proSearchitem[index]}",
                        style: TextStyle(
                          color: grayColor1,
                          fontFamily: "Barun",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.check_rounded,
                    color: themeColor1,
                  )
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) =>
          Divider(
            color: grayColor2,
            thickness: 1,
            indent: 20.w,
            endIndent: 20.w,
          ),
    );
  }

  void _getSubData() async {
    _isSearching = true;
    await Future.delayed(Duration(seconds: 1));

    if (_subList.isNotEmpty == true) {
      setState(() {
        _subSearchitem.addAll(_subList);
        _proSearchitem.addAll(_proList);
      });
    }
    setState(() {
      _isSearching = false;
    });
  }
}
