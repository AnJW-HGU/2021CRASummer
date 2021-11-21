import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:ui';

import 'package:studytogether/main.dart';

final post_id = Get.arguments[0].toString();

//POST의 데이터 가져오기
Future<Post> fetchPost() async {
  Map<String, dynamic> queryParams = {
    'postId': post_id,
  };

  String queryString = Uri(queryParameters: queryParams).query;
  var postUrl = "http://128.199.139.159:3000/post/" + post_id;
  var response = await http.get(Uri.parse(postUrl));

  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load post");
  }
}

// Post에 대한 Data형식
class Post {
  var post_id;
  var post_userId;
  var post_userName;
  var post_title;
  var post_content;
  var post_comments_count;
  var post_reports_count;
  var post_writtenDate;
  var post_adopted_status; // 채택된 댓글이 있니?

  Post({
    this.post_id,
    this.post_userId,
    this.post_userName,
    this.post_title,
    this.post_content,
    this.post_comments_count,
    this.post_reports_count,
    this.post_writtenDate,
    this.post_adopted_status,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      post_id: json["id"],
      post_userId: json["user_id"],
      post_userName: json["User"]["nickname"],
      post_title: json["title"],
      post_content: json["content"],
      post_comments_count: json["comments_count"],
      post_reports_count: json["reports_count"],
      post_writtenDate: json["written_date"],
      post_adopted_status: json["adopted_status"],
    );
  }
}

//Comment 작성
_AddComment(inPostId, inUserId, inContent) async {
  String url = "http://128.199.139.159:3000/comment";
  AddComment _addComment = AddComment(inPostId, inUserId, inContent);

  return (await apiRequest(url, _addComment));
}

apiRequest(url, _addComment) async {
  var body = utf8.encode(jsonEncode(_addComment));
  http.Response response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-type': 'application/json',
    },
    body: body,
  );

  String reply = "작성에 실패하였습니다.";
  if (response.statusCode == 200) {
    reply = "작성되었습니다.";
  }
  return reply;
}

// Comment 작성 시 데이터 형식
class AddComment {
  var comment_post_id;
  var comment_user_id;
  var comment_content;

  AddComment(inPostId, inUserId, inContent) {
    comment_post_id = inPostId;
    comment_user_id = inUserId;
    comment_content = inContent;
  }

  //jsonEncode 함수 있어서 메소드를 부를 필요는 없음
  Map<String, dynamic> toJson() => {
        "postId": comment_post_id,
        "userId": comment_user_id,
        "content": comment_content,
      };
}

// Comment 데이터 가져오기
List<Comment> CommentfromJson(json) {
  List<Comment> result = [];
  json.forEach((item) {
    result.add(Comment(
        item["id"],
        item["user_id"],
        item["User"]["nickname"],
        item['content'],
        item["recommends_count"],
        item["written_date"],
        item["adopted_status"]));
  });

  return result;
}

Future<List<Comment>> fetchComment() async {
  Map<String, dynamic> queryParams = {
    'postId': post_id,
  };

  String queryString = Uri(queryParameters: queryParams).query;
  var commentUrl = "http://128.199.139.159:3000/comment/?" + queryString;
  // var commentUrl = "https://c64ab34d-ad62-4f6e-9578-9a43e222b9bf.mock.pstmn.io/comments?postId=1";
  var response = await http.get(Uri.parse(commentUrl));

  if (response.statusCode == 200) {
    return CommentfromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load comment");
  }
}

// Comment 가져올 때 데이터 형식
class Comment {
  var comment_id;
  var comment_userId;
  var comment_nickName;
  var comment_content;
  var comment_recommendCount;
  var comment_writtenDate;
  var comment_adoptedStatus;

  Comment(
    this.comment_id,
    this.comment_userId,
    this.comment_nickName,
    this.comment_content,
    this.comment_recommendCount,
    this.comment_writtenDate,
    this.comment_adoptedStatus,
  );

// factory json
// factory Comment.fromJson(Map<String, dynamic> json) {
//   return Comment(
//     comment_userId: json["user_id"],
//     comment_nickName: json["nickname"],
//     comment_content: json["content"],
//     comment_recommendCount: json["recommends_count"],
//       comment_writtenDate: json["written_date"],
//       comment_apoptedStatus: json["adopted_status"]
//   );
// }
}

// Recommend(추천) 누르기
_AddRecommend(inCommentId, inUserId) async {
  String url = "http://128.199.139.159:3000/status/recommend";
  Recommend _addRecommend = Recommend(inCommentId, inUserId);

  return (await _recommendRequest(url, _addRecommend));
}

_recommendRequest(url, _addRecommend) async {
  var body = utf8.encode(jsonEncode(_addRecommend));
  http.Response response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-type': 'application/json',
    },
    body: body,
  );

  String reply = "이미 추천한 답변입니다. :<";
  if (response.statusCode == 200) {
    reply = "추천되었습니다.";
  }
  return reply;
}

// Report(신고)의 Data형식
class Recommend {
  var comment_id;
  var recommend_userId;

  Recommend(inCommentId, inUserId) {
    comment_id = inCommentId;
    recommend_userId = inUserId;
  }

  Map<String, dynamic> toJson() => {
        "commentId": comment_id,
        "userId": recommend_userId,
      };
}

// Report(신고) 누르기
_AddReport(inUserId, inSomeId, inType, inContent) async {
  String url = "http://128.199.139.159:3000/status/report";
  Report _addReport = Report(inUserId, inSomeId, inType, inContent);

  return (await _reportRequest(url, _addReport));
}

_reportRequest(url, _addReport) async {
  var body = utf8.encode(jsonEncode(_addReport));
  http.Response response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-type': 'application/json',
    },
    body: body,
  );

  String reply = "다시 신고해주세요. :<";
  if (response.statusCode == 200) {
    reply = "신고되었습니다.";
  }
  return reply;
}

// Report(신고)의 Data형식
class Report {
  var report_userId;
  var report_id;
  var report_type;
  var report_content;

  Report(inUserId, inSomeId, inType, inContent) {
    report_userId = inUserId;
    report_id = inSomeId;
    report_type = inType;
    report_content = inContent;
  }

  Map<String, dynamic> toJson() => {
        "userId": report_userId,
        "id": report_id,
        "type": report_type,
        "content": report_content
      };
}

// Post 삭제
_DeletePost(userId, postId) async {
  Map<String, String> queryParams = {"id": postId};
  String queryString = Uri(queryParameters: queryParams).query;

  var requestUrl = "http://128.199.139.159:3000/post/" + queryString;
  var response = await http.delete(Uri.parse(requestUrl));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    return "FAIL";
  }
}

///////////////////////////////////////////////////////////////////

// UI
class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late Future<Post> post;
  List<Comment> _commentDataList = <Comment>[].obs;

  final userId = 1;
  final userPosted = false;

  final commentController = TextEditingController();
  final _scroll = ScrollController().obs;

  var _maxPost = 20;
  var _isLoading = false.obs;
  var _hasMoreComment = false.obs;

  bool _isComment = true;

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getComment();
    this._scroll.value.addListener(() {
      if (this._scroll.value.position.pixels ==
              this._scroll.value.position.maxScrollExtent &&
          this._hasMoreComment.value) {
        _getComment();
      }
    });

    post = fetchPost();
  }

  _getComment() async {
    _isLoading.value = true;
    List<Comment> _newCommentDataList = await fetchComment();
    setState(() {
      _commentDataList.addAll(_newCommentDataList);
    });
    _isLoading.value = false;
    _hasMoreComment.value = _commentDataList.length < _maxPost;
  }

  /*
  게시글에서 필요한 것
  아이콘... 질문자와 비교해서...
  게시글 refresh
    1. 댓글 또는 대댓글 달면 refresh
    2. 신고?
  댓글 refresh
    1. 추천 누르면 refresh
   게시글 삭제하면 삭제하고 뒤로가기, 게시판 refresh
   */

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.4, 683.4),
      builder: () {
        return Scaffold(
          backgroundColor: themeColor2,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              "질문",
              style: TextStyle(
                color: grayColor1,
                fontFamily: "Barun",
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
            ),

            // 뒤로가기 버튼
            leading: IconButton(
              color: themeColor2,
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              tooltip: "Back Button",
              iconSize: 15.w,
              onPressed: () {
                Get.back();
              },
            ),

            actions: [
              IconButton(
                color: grayColor2,
                icon: Icon(
                  Icons.more_vert,
                ),
                tooltip: "Post Menu Button",
                iconSize: 25.w,
                onPressed: () {
                  if (userPosted == true) {
                    _postedMenu(post_id);
                  } else {
                    _unPostedMenu(post_id);
                  }
                },
              )
            ],
          ),
          body: SafeArea(
            child: FutureBuilder<Post>(
              future: post,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          controller: _scroll.value,
                          child: Column(
                            children: [
                              // 배경? == 질문+댓글
                              Container(
                                padding: EdgeInsets.only(
                                    top: 0.h,
                                    left: 30.w,
                                    right: 30.w,
                                    bottom: 25.h),
                                child: Column(
                                  children: [
                                    // 프로필과 닉네임
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: themeColor4,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: Text(
                                            snapshot.data!.post_userName,
                                            style: TextStyle(
                                              color: themeColor2,
                                              fontFamily: "Barun",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    // 질문 제목과 질문 내용
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 20.h),
                                          child: Text(
                                            snapshot.data!.post_title,
                                            style: TextStyle(
                                              fontFamily: "Barun",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.h),
                                          child: Text(
                                            snapshot.data!.post_content,
                                            style: TextStyle(
                                              fontFamily: "Barun",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 15.h,
                                          left: 0,
                                          right: 0,
                                          bottom: 0),
                                    ),
                                    // 날짜와 댓글 총 수
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              //comment 아이콘
                                              padding: EdgeInsets.only(
                                                  left: 0,
                                                  right: 3.w,
                                                  top: 0,
                                                  bottom: 0),
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
                                                snapshot
                                                    .data!.post_comments_count
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: grayColor1,
                                                  fontFamily: "barun",
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ),

                                            // 채택여부 -> 이건 어차피 댓글로 보여지니까
                                            // Padding(
                                            //   padding: EdgeInsets.only(left: 5.w),
                                            //   child: snapshot.data!.post_adopted_status ?
                                            //   Icon(
                                            //     Icons.star_rounded,
                                            //     size: 19.sp,
                                            //     color: grayColor1,
                                            //   ) :
                                            //   Icon(
                                            //     Icons.star_outline_rounded,
                                            //     size: 19.sp,
                                            //     color: grayColor1,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 0,
                                              left: 0,
                                              right: 0,
                                              bottom: 0),
                                          child: Text(
                                            snapshot.data!.post_writtenDate
                                                .substring(0, 10),
                                            style: TextStyle(
                                              color: grayColor1,
                                              fontFamily: "barun",
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: blurColor,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                ),
                              ),

                              // 댓글 관련
                              Container(
                                width: 450.w,
                                constraints: BoxConstraints(
                                  minHeight: 400.h,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 20.h,
                                      bottom: 20.h,
                                      left: 15.w,
                                      right: 15.w),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: 15.w,
                                        left: 20.w,
                                        right: 20.w,
                                        bottom: 20.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: blurColor,
                                          blurRadius: 4,
                                          offset: Offset(2, 0),
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        for (int i = 0;
                                            i < _commentDataList.length;
                                            i++)
                                          Container(
                                            child: Column(
                                              children: [
                                                // 프로필 & 닉네임 & 채택
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // 프로필 & 닉네임
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {},
                                                          child: CircleAvatar(
                                                            radius: 20,
                                                            backgroundColor:
                                                                themeColor4,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10.w),
                                                          child: Text(
                                                            _commentDataList[i]
                                                                .comment_nickName,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  "Barun",
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    // 채택
                                                    if (_commentDataList[i]
                                                            .comment_adoptedStatus ==
                                                        true) IconButton(
                                                        onPressed: () {},
                                                        tooltip:
                                                            "Adopted Button",
                                                        icon: Icon(
                                                          Icons.check_rounded,
                                                          color: themeColor2,
                                                        ),
                                                        alignment: Alignment
                                                            .centerRight,
                                                      ),
                                                  ],
                                                ),

                                                // 댓글 내용
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      top: 10.h, bottom: 15.h),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    _commentDataList[i]
                                                        .comment_content,
                                                    style: TextStyle(
                                                      fontFamily: "Barun",
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),

                                                // 댓글 날짜와 추천 및 신고
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      child: Text(
                                                        _commentDataList[i]
                                                            .comment_writtenDate.substring(0, 10),
                                                        style: TextStyle(
                                                          color: grayColor1,
                                                          fontFamily: "Barun",
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Material(
                                                      child: Row(
                                                        children: [
                                                          // 댓글추천
                                                          InkWell(
                                                            onTap: () async {
                                                              String result =
                                                                  await _AddRecommend(
                                                                      _commentDataList[
                                                                              i]
                                                                          .comment_id,
                                                                      userId);
                                                              if (result ==
                                                                  "OK") {
                                                                result =
                                                                    "추천이 완료되었습니다. :>";
                                                              }
                                                              Get.showSnackbar(
                                                                GetBar(
                                                                  message:
                                                                      result,
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .TOP,
                                                                  maxWidth:
                                                                      400.w,
                                                                  backgroundColor:
                                                                      themeColor2,
                                                                  borderRadius:
                                                                      5,
                                                                  barBlur: 0,
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    "추천",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          grayColor1,
                                                                      fontFamily:
                                                                          "Barun",
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                      padding: EdgeInsets
                                                                          .all(2
                                                                              .w)),
                                                                  Text(
                                                                    _commentDataList[
                                                                            i]
                                                                        .comment_recommendCount
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          grayColor1,
                                                                      fontFamily:
                                                                          "Barun",
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),

                                                          Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          5.w)),

                                                          // 댓글 신고
                                                          _reportButton(
                                                              _commentDataList[
                                                                      i]
                                                                  .comment_id),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                // 디스커션 구분선
                                                // Divider(
                                                //   color: grayColor2,
                                                // ),

                                                // 대댓글 버튼
                                                // GestureDetector(
                                                //   behavior: HitTestBehavior.opaque,
                                                //   onTap: () {
                                                //     print("대댓글 작성할래");
                                                //   },
                                                //   child: Container(
                                                //     padding: EdgeInsets.only(left: 10.w),
                                                //     child: Row(
                                                //       children: [
                                                //         Icon(
                                                //           Icons.add_rounded,
                                                //           color: grayColor2,
                                                //           size: 16.sp,
                                                //         ),
                                                //         Text(
                                                //           "Discussion",
                                                //           style: TextStyle(
                                                //             color: grayColor2,
                                                //             fontFamily: "Barun",
                                                //             fontSize: 14.sp,
                                                //             fontWeight: FontWeight.w400,
                                                //           ),
                                                //         )
                                                //       ],
                                                //     ),
                                                //   ),
                                                // ),

                                                // 댓글 구분선
                                                Divider(
                                                  color: grayColor1,
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // 답변 입력창
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight: 80.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                width: 1,
                                color: grayColor1,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 15.w),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: TextField(
                                      controller: commentController,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      // onSubmitted: (value) {
                                      //   print("${commentController.text}");
                                      // },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "답변을 입력하세요.",
                                        hintStyle: TextStyle(
                                          fontFamily: "Barun",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),

                                        // border: OutlineInputBorder(
                                        //   borderSide: BorderSide(
                                        //     color: grayColor2,
                                        //     width: 1,
                                        //   ),
                                        //   borderRadius: BorderRadius.circular(15),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _AddComment(snapshot.data!.post_id, userId,
                                        "${commentController.text}");
                                    commentController.clear();
                                  },
                                  icon: Icon(
                                    Icons.check,
                                    color: grayColor1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return _loadingPost();
              },
            ),
          ),
        );
      },
    );
  }

  void _postedMenu(inPostId) {
    Get.defaultDialog(
        backgroundColor: Colors.white.withOpacity(0.8),
        barrierDismissible: false,
        title: "",
        titleStyle: TextStyle(
          fontFamily: "Barun",
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
        content:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          // 수정 기능
          // GestureDetector(
          //   behavior: HitTestBehavior.opaque,
          //   onTap: () async {
          //     Get.back();
          //     String result = "수정되었습니다 :>";
          //     Get.showSnackbar(
          //       GetBar(
          //         message: result,
          //         duration: Duration(seconds: 1),
          //         snackPosition: SnackPosition.TOP,
          //         maxWidth: 400.w,
          //         backgroundColor: themeColor2,
          //         borderRadius: 5,
          //         barBlur: 0,
          //       ),
          //     );
          //   },
          //   child: Container(
          //     alignment: Alignment.center,
          //     child: Text(
          //       "수정",
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontFamily: "Barun",
          //         fontSize: 17.sp,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ),
          // ),

          Divider(
            color: grayColor2,
          ),

          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              Get.back();
              String result = await _DeletePost(userId, inPostId);
              if (result == "OK") {
                result = "삭제가 완료되었습니다. :>";
              } else {
                result = "삭제가 실패했습니다 :<";
              }
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
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "삭제",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Barun",
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          Divider(
            color: grayColor2,
          ),
        ]),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "취소",
              style: TextStyle(
                color: grayColor1,
                fontFamily: "Barun",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ]);
  }

  void _unPostedMenu(inPostId) {
    Get.defaultDialog(
        backgroundColor: Colors.white.withOpacity(0.8),
        barrierDismissible: false,
        title: "",
        titleStyle: TextStyle(
          fontFamily: "Barun",
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
        content:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Divider(
            color: grayColor2,
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              Get.back();
              _reportSome(post_id, 'post');
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "신고",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Barun",
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Divider(
            color: grayColor2,
          ),
        ]),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "취소",
              style: TextStyle(
                color: grayColor1,
                fontFamily: "Barun",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ]);
  }

  Widget _reportButton(inSomeId) {
    return InkWell(
      onTap: () {
        _reportSome(inSomeId, 'comment');
        print("Report Button");
      },
      child: Container(
        child: Text(
          "신고",
          style: TextStyle(
            color: grayColor1,
            fontFamily: "Barun",
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  void _reportSome(inSomeId, inReportType) {
    Get.defaultDialog(
        backgroundColor: Colors.white.withOpacity(0.8),
        barrierDismissible: false,
        title: "",
        titleStyle: TextStyle(
          fontFamily: "Barun",
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                Get.back();
                String result = await _AddReport(
                    userId, inSomeId, inReportType, "아너코드 위반 게시물");
                if (result == "OK") {
                  result = "신고가 완료되었습니다. :>";
                }
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
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "아너코드 위반 게시물",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Barun",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Divider(
              color: grayColor2,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                Get.back();
                String result = await _AddReport(
                    userId, inSomeId, inReportType, "폭력적/혐오적인 게시물");
                if (result == "OK") {
                  result = "신고가 완료되었습니다. :>";
                }
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
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "폭력적/혐오적인 게시물",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Barun",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Divider(
              color: grayColor2,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                Get.back();
                String result = await _AddReport(
                    userId, inSomeId, inReportType, "상업/사기/조작 관련 게시물");
                if (result == "OK") {
                  result = "신고가 완료되었습니다. :>";
                }
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
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "상업/사기/조작 관련 게시물",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Barun",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Divider(
              color: grayColor2,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                Get.back();
                String result = await _AddReport(
                    userId, inSomeId, inReportType, "정치/어그로 관련 게시물");
                if (result == "OK") {
                  result = "신고가 완료되었습니다. :>";
                }
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
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "정치/어그로 관련 게시물",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Barun",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Divider(
              color: grayColor2,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                Get.back();
                String result =
                    await _AddReport(userId, inSomeId, inReportType, "성적인 게시물");
                if (result == "OK") {
                  result = "신고가 완료되었습니다. :>";
                }
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
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "성적인 게시물",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Barun",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Divider(
              color: grayColor2,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                Get.back();
                String result = await _AddReport(
                    userId, inSomeId, inReportType, "부적절한 게시물");
                if (result == "OK") {
                  result = "신고가 완료되었습니다. :>";
                }
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
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "부적절한 게시물",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Barun",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Divider(
              color: grayColor2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "취소",
              style: TextStyle(
                color: grayColor1,
                fontFamily: "Barun",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ]);
  }

  Widget _loadingPost() {
    return Column(
      children: [
        // 배경? == 질문+댓글
        Container(
          padding:
              EdgeInsets.only(top: 0.h, left: 30.w, right: 30.w, bottom: 25.h),
          child: Column(
            children: [
              // 프로필과 닉네임
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: themeColor4,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Container(
                      width: 100.w,
                      height: 15.h,
                      color: themeColor4,
                    ),
                  ),
                ],
              ),

              // 질문 제목과 질문 내용
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Container(
                      height: 15.h,
                      color: grayColor2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Container(
                      height: 50.h,
                      color: grayColor2,
                    ),
                  ),
                ],
              ),

              Padding(
                padding:
                    EdgeInsets.only(top: 15.h, left: 0, right: 0, bottom: 0),
              ),
              // 날짜와 댓글 총 수
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        //comment 아이콘
                        padding: EdgeInsets.only(
                            left: 0, right: 3.w, top: 0, bottom: 0),
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
                          "0",
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
                  Padding(
                    padding:
                        EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                    child: Text(
                      "00.00.00",
                      style: TextStyle(
                        color: grayColor1,
                        fontFamily: "barun",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                color: blurColor,
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ],
          ),
        ),
      ],
    );
  }
}
