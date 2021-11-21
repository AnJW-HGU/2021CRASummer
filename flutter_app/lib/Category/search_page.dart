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

import 'post_page.dart';

// Posts 데이터 가져오기
List<SearchPosts> SearchPostsfromJson(json) {
  List<SearchPosts> result = [];
  json.forEach((item) {
    result.add(SearchPosts(
        item["subject"],
        item["id"],
        item["user_id"],
        item["title"],
        item["content"],
        item["comments_count"],
        item["written_date"],
        item["adopted_status"]));
  });

  return result;
}

Future<List<SearchPosts>> fetchSearchPosts(inSearchWord) async {
  Map<String, String> queryParams = {"searchKeyword": inSearchWord};
  String queryString = Uri(queryParameters: queryParams).query;

  var requestUrl = "http://128.199.139.159:3000/post/search" + "?" + queryString;
  var response = await http.get(Uri.parse(requestUrl));

  if (response.statusCode == 200) {
    return SearchPostsfromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load posts");
  }
}

// Posts 데이터 형식
class SearchPosts {
  var searchPosts_subject;
  var searchPosts_id;
  var searchPosts_userId;
  var searchPosts_title;
  var searchPosts_content;
  var searchPosts_commentsC;
  var searchPosts_writtenDate;
  var searchPosts_adoptedStatus;

  SearchPosts(
    this.searchPosts_subject,
    this.searchPosts_id,
    this.searchPosts_userId,
    this.searchPosts_title,
    this.searchPosts_content,
    this.searchPosts_commentsC,
    this.searchPosts_writtenDate,
    this.searchPosts_adoptedStatus,
  );
}

//////////////////////////////////////////////////////////////////

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _userId = ""; // 유저 아이디
  final _subSelect = ""; // 선택한 과목
  final _proSelect = ""; // 선택한 과목의 교수님

  var _isNotSubmitted = true;

  final _search = TextEditingController();
  final _scroll = ScrollController().obs;

  List<SearchPosts> _searchPostsDataList = <SearchPosts>[].obs;

  var _maxSearchPost = 20; // 검색한 게시글 총 개수
  var _isSearchLoading = false.obs;
  var _hasMoreSearchPosts = false.obs;

  @override
  void initState() {
    super.initState();

    this._scroll.value.addListener(() {
      if (this._scroll.value.position.pixels ==
              this._scroll.value.position.maxScrollExtent &&
          this._hasMoreSearchPosts.value) {
        _searchPosts("${_search.text}");
      }
    });
  }

  _searchPosts(inSearchWord) async {
    _isSearchLoading.value = true;
    List<SearchPosts> _newSearchPostDataList =
        await fetchSearchPosts(inSearchWord);
    setState(() {
      _searchPostsDataList.addAll(_newSearchPostDataList);
    });
    _isSearchLoading.value = false;
    _hasMoreSearchPosts.value = _searchPostsDataList.length < _maxSearchPost;
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
                textAlignVertical: TextAlignVertical.bottom,
                controller: _search,
                textInputAction: TextInputAction.go,
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
                        _searchPostsDataList.clear();
                      });
                    },
                    padding: EdgeInsets.all(0.0),
                    icon: Icon(
                      Icons.clear,
                      color: themeColor1,
                    ),
                  ),

                  hintText: "검색할 내용을 입력해주세요.",
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
                child: _isNotSubmitted ? _notSubmittedPage() : _searchPost(),
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
                "게시글이 존재하지 않아요 :<",
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

  Widget _searchPost() {
    return Center(
      child: Container(
        child: Obx(
          () => ListView.separated(
            controller: _scroll.value,
            itemCount: _searchPostsDataList.length + 1,
            itemBuilder: (_, index) {
              if (index < _searchPostsDataList.length) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.to(PostPage(), arguments: [
                      _searchPostsDataList[index].searchPosts_id,
                      _searchPostsDataList[index].searchPosts_userId
                    ]);
                  },
                  child: _makeSearchPost(
                      _searchPostsDataList[index].searchPosts_subject,
                      _searchPostsDataList[index].searchPosts_title,
                      _searchPostsDataList[index].searchPosts_content,
                      _searchPostsDataList[index].searchPosts_commentsC,
                      _searchPostsDataList[index].searchPosts_writtenDate,
                      _searchPostsDataList[index].searchPosts_adoptedStatus),
                );
              } else if (_hasMoreSearchPosts.value || _isSearchLoading.value) {
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
                    _searchPostsDataList.clear();
                    _searchPosts("${_search.text}");
                  },
                  icon: Icon(Icons.arrow_upward_rounded),
                ),
              );
            },
            separatorBuilder: (_, index) => Divider(),
          ),
        ),
      ),
    );
  }

  Widget _makeSearchPost(
      inSub, inTitle, inContent, inCount, inDate, inAdopted) {
    return Container(
      padding:
          EdgeInsets.only(top: 10.0.h, bottom: 10.0.h, left: 5.w, right: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                inSub,
                style: TextStyle(
                  color: themeColor1,
                  fontFamily: "Barun",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),

              // 채택여부
              Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: inAdopted
                    ? Icon(
                        Icons.check_rounded,
                        size: 19.sp,
                        color: themeColor1,
                      )
                    : null,
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          Text(
            inTitle,
            style: TextStyle(
              fontFamily: "Barun",
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          Text(
            inContent,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: grayColor2,
              fontFamily: "Barun",
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                child: Text(
                  inDate,
                  style: TextStyle(
                    color: grayColor2,
                    fontFamily: "barun",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    //comment 아이콘
                    padding:
                        EdgeInsets.only(left: 0, right: 3.w, top: 0, bottom: 0),
                    child: Icon(
                      Icons.comment_outlined,
                      size: 15.sp,
                      color: grayColor1,
                    ),
                  ),

                  //comment 수
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      inCount.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: grayColor1,
                        fontFamily: "barun",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
