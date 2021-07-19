import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:studytogether/main.dart';

class NotiPage extends StatefulWidget {
  const NotiPage({Key? key}) : super(key: key);

  @override
  _NotiPageState createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  final List<String> _subList = <String>[
    "성경의 이해", "성경의 이해", "데이터 구조", "데이터 구조",
    "분류", "분류에오", "분 류", "분류우",
    "분류", "분류에오", "분 류", "분류우",
    "분류", "분류에오", "분 류", "분류우",
    "분류", "분류에오", "분 류", "분류우",
  ].obs;

  // final List<String> _titleList = <String>[
  //   "제목1", "제목2", "제목3", "제목4",
  //   "제목5", "제목6", "제목7", "제목8",
  //   "제목9", "제목10", "제목11", "제목12",
  //   "제목13", "제목14", "제목15", "제목16",
  //   "제목17", "제목18", "제목19", "제목20",
  // ].obs;

  final List<String> _contentList = <String>[
    "새로운 답변이 달렸습니다.", "새로운 답변이 달렸습니다.", "답변이 채택되었습니다.", "답변이 채택되었습니다.",
    "새로운 답변이 달렸습니다.", "새로운 답변이 달렸습니다.", "답변이 채택되었습니다.", "답변이 채택되었습니다.",
    "새로운 답변이 달렸습니다.", "새로운 답변이 달렸습니다.", "답변이 채택되었습니다.", "답변이 채택되었습니다.",
    "새로운 답변이 달렸습니다.", "새로운 답변이 달렸습니다.", "답변이 채택되었습니다.", "답변이 채택되었습니다.",
    "새로운 답변이 달렸습니다.", "새로운 답변이 달렸습니다.", "답변이 채택되었습니다.", "답변이 채택되었습니다.",
  ].obs;


  var maxInfo = 20;

  var scrollController = ScrollController().obs;

  var _subData = <String>[].obs;
  // var _titleData = <String>[].obs;
  var _contentData = <String>[].obs;

  var isLoading = false.obs;
  var hasMore = false.obs;

  @override
  void initState() {
    _getInfo();

    this.scrollController.value.addListener(() {
      if(this.scrollController.value.position.pixels ==
          this.scrollController.value.position.maxScrollExtent && this.hasMore.value) {
        _getInfo();
      }
    });
    super.initState();
  }

  _getInfo() async {
    isLoading.value = true;

    await Future.delayed(Duration(seconds: 2));

    int offset = _subData.length;
    _subData.addAll(_subList.sublist(offset, offset+10));
    // _titleData.addAll(_titleList.sublist(offset, offset+10));
    _contentData.addAll(_contentList.sublist(offset, offset+10));

    isLoading.value = false;
    hasMore.value = _subData.length < maxInfo;
  }

  reload() async {
    isLoading.value = true;
    _subData.clear();
    // _titleData.clear();
    _contentData.clear();

    await Future.delayed(Duration(seconds: 2));

    _getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.4, 683.4),
      builder: () {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              color: themeColor1,
              icon: Icon(Icons.arrow_back_ios_new_rounded, size: 15.w,),
            ),
            title: Text(
              "알림",
              style: TextStyle(
                fontFamily: "Barun",
                fontSize: 15.sp,
                color: grayColor1,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),

          body: _NotiPageBody()
        );
      },
    );
  }

  Widget _NotiPageBody(){
    return Container(
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
          child: ListView.separated(
            controller: scrollController.value,
            itemBuilder: (_, index) {
              print(hasMore.value);

              if (index < _subData.length) {
                var subDatum = _subData[index];
                // var titleDatum = _titleData[index];
                var contentDatum = _contentData[index];

                return Container(
                  child: _makeNotiTile("$subDatum", "$contentDatum"),
                );
              }
              if (hasMore.value || isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    children: [
                      Text('알림의 마지막 입니다'),
                      IconButton(
                        onPressed: () {
                          reload();
                        },
                        icon: Icon(Icons.arrow_upward_rounded),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, index) => Divider(),
            itemCount: _subData.length + 1,
          ),
        ),
      ),
    );
  }

  Widget _makeNotiTile(sub, content) {
    return Container(
      child : ListTile(
        subtitle: Text(
          content,
          style: TextStyle(
            fontFamily: "Barun",
            fontSize: 14.sp,
            color: grayColor2,
          ),
        ),
        title: new Text(
          sub,
          style: TextStyle(
            fontFamily: "Barun",
            fontSize: 14.sp,
            color: themeColor2,
          ),
        ),
        // initiallyExpanded: false,
        // backgroundColor: Colors.white,
        // children: <Widget>[
        //   Divider(height: 1),
        //   Container(
        //     alignment: Alignment.centerLeft,
        //     padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0.w, right: 20.0.w ),
        //     child: Text(
        //       content,
        //       style: TextStyle(
        //         fontFamily: "Barun",
        //         fontSize: 14.sp,
        //       ),
        //     ),
        //   )
        // ],
      ),
    );
  }
}
