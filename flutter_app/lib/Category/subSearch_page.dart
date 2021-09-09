import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:ui';

import 'package:studytogether/main.dart';

import 'myBoard_page.dart';

// Subject Search 결과 데이터 가져오기
List<SearchSubs> SearchSubsfromJson(json) {
  List<SearchSubs> result = [];
  json.forEach((item) {
    result.add(SearchSubs(item["id"], item["subject"], item["professor_name"]));
  });
  return result;
}

Future<List<SearchSubs>> fetchSearchSubs(inSearchword) async {
  var searchSubsUrl =
      "https://c64ab34d-ad62-4f6e-9578-9a43e222b9bf.mock.pstmn.io/classification/search?";
  Map<String, String> queryParams = {"searchKeyword": inSearchword};
  String queryString = Uri(queryParameters: queryParams).query;

  var requestUrl = searchSubsUrl + "?" + queryString;
  var response = await http.get(Uri.parse(requestUrl));

  if (response.statusCode == 200) {
    return SearchSubsfromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load subject");
  }
}

// Subject Search 데이터 형식
class SearchSubs {
  var searchSubs_id;
  var searchSubs_subject;
  var searchSubs_professor;

  SearchSubs(
    this.searchSubs_id,
    this.searchSubs_subject,
    this.searchSubs_professor,
  );
}

class SubSearchPage extends StatefulWidget {
  const SubSearchPage({Key? key}) : super(key: key);

  @override
  _SubSearchPageState createState() => _SubSearchPageState();
}

class _SubSearchPageState extends State<SubSearchPage> {
  final _userId = ""; // 유저 아이디
  final _idSelect = ""; // 선택한 과목의 id
  final _subSelect = ""; // 선택한 과목
  final _proSelect = ""; // 선택한 과목의 교수님

  var _isNotSubmitted = true;

  final _search = TextEditingController();
  var _scroll = ScrollController().obs;

  List<SearchSubs> _searchSubsDataList = <SearchSubs>[].obs;

  var _maxSearchSub = 20; // 찾은 과목 총 개수
  var _isSearchLoading = false.obs;
  var _hasMoreSearchSubs = false.obs;

  @override
  void initState() {
    super.initState();

    this._scroll.value.addListener(() {
      if (this._scroll.value.position.pixels == this._scroll.value.position.maxScrollExtent &&
          this._hasMoreSearchSubs.value) {
        _searchPosts("${_search.text}");
      }
    });
  }

  _searchPosts(inSearchWord) async {
    _isSearchLoading.value = true;
    List<SearchSubs> _newSearchSubsDataList =
        await fetchSearchSubs(inSearchWord);
    setState(() {
      _searchSubsDataList.addAll(_newSearchSubsDataList);
    });
    _isSearchLoading.value = false;
    _hasMoreSearchSubs.value = _searchSubsDataList.length < _maxSearchSub;
  }

  @override
  void dispose() {
    // 위젯이 dispose 또는 dismiss 될 때 컨트롤러를 clean up!
    _search.dispose();
    super.dispose();
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
            elevation: 0.0,
            centerTitle: true,
            title: Container(
              height: 32,
              child: TextField(
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.bottom,
                // textInputAction: TextInputAction.go,
                controller: _search,
                onSubmitted: (value) {
                  if (_search.text.length > 0) {
                    setState(() {
                      _isNotSubmitted = false;
                    });
                    print("${_search.text}");
                    _searchPosts("${_search.text}");
                  } else {
                    setState(() {
                      _isNotSubmitted = true;
                    });
                  }
                },
                // 과목 검색하기
                decoration: InputDecoration(
                  // border 설정
                  enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: themeColor1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: themeColor1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))),

                  // prefixIcon: Icon(Icons.search_rounded, color: themeColor1,),
                  suffixIcon: IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _search.clear();
                      setState(() {
                        _isNotSubmitted = true;
                        _searchSubsDataList.clear();
                      });
                    },
                    padding: EdgeInsets.all(0.0),
                    icon: Icon(
                      Icons.clear,
                      color: themeColor1,
                    ),
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
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                padding: EdgeInsets.only(
                  bottom: 10.h,
                  left: 15.w,
                  right: 15.w,
                ),
                child: _isNotSubmitted ? _notSubmittedPage() : _searchSub(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _notSubmittedPage() {
    return Center(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 100.h),
              child: Text(
                "과목이 존재하지 않아요 :<",
                style: TextStyle(
                  color: themeColor1,
                  fontFamily: "Barun",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                "과목 검색하는 방법 :",
                style: TextStyle(
                  color: themeColor1,
                  fontFamily: "Barun",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.h),
              child: Text(
                "스터디, 스, 스터디투게더",
                style: TextStyle(
                  color: themeColor1,
                  fontFamily: "Barun",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchSub() {
    return Center(
      child: Container(
        child: Obx(
          () => ListView.separated(
            controller: _scroll.value,
            itemCount: _searchSubsDataList.length + 1,
            itemBuilder: (_, index) {
              if (index < _searchSubsDataList.length) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.back();
                  },
                  child: _makeSearchSub(
                      _searchSubsDataList[index].searchSubs_subject,
                      _searchSubsDataList[index].searchSubs_professor),
                );
              }

              else if (_hasMoreSearchSubs.value || _isSearchLoading.value) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return Container(
                child: IconButton(
                  onPressed: () {
                    _isSearchLoading.value = true;
                    _searchSubsDataList.clear();
                    _searchPosts("${_search.text}");
                  },
                  icon: Icon(Icons.arrow_upward_rounded),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: grayColor2,
              thickness: 1,
            ),
          ),
        ),
      ),
    );
  }
}

Widget _makeSearchSub(inSubject, inProfessor) {
  return Container(
    child: Container(
// padding: EdgeInsets.only(top: 10, bottom: 5, left: 25.w, right: 20.w,),
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  inSubject,
                  style: TextStyle(
                    color: themeColor1,
                    fontFamily: "Barun",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 5)),
                Text(
                  inProfessor,
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
}
