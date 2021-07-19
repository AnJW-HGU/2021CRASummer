import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';

class MyQPage extends StatefulWidget {
  @override
  _MyQPageState createState() => _MyQPageState();
}

class _MyQPageState extends State<MyQPage> {
  final List<String> _subList = <String>[
    "성경의 이해", "데이타구조", "분 류", "분류우",
    "분류", "분류에오", "분 류", "분류우",
    "분류", "분류에오", "분 류", "분류우",
    "분류", "분류에오", "분 류", "분류우",
    "분류", "분류에오", "분 류", "분류우",
  ].obs;

  final List<String> _titleList = <String>[
    "질문 제목1", "질문 제목2", "질문 제목3", "질문 제목4",
    "질문 제목5", "질문 제목6", "질문 제목7", "질문 제목8",
    "질문 제목9", "질문 제목10", "질문 제목11", "질문 제목12",
    "질문 제목13", "질문 제목14", "질문 제목15", "질문 제목16",
    "질문 제목17", "질문 제목18", "질문 제목19", "질문 제목20",
  ].obs;

  final List<String> _contentList = <String>[
    "질문 내용이에오", "질문 내용이에오", "질문 내용이에오", "질문 내용이에오",
    "질문 내용이에오", "질문 내용이에오", "질문 내용이에오", "질문 내용이에오",
    "질문 내용이에오", "질문 내용이에오", "질문 내용이에오", "질문 내용이에오",
    "질문 내용이에오", "질문 내용이에오", "질문 내용이에오", "질문 내용이에오",
    "질문 내용이에오", "질문 내용이에오", "질문 내용이에오", "질문 내용이에오",
  ].obs;

  var maxInfo = 20;

  var scrollController = ScrollController().obs;

  var _subData = <String>[].obs;
  var _titleData = <String>[].obs;
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
    _titleData.addAll(_titleList.sublist(offset, offset+10));
    _contentData.addAll(_contentList.sublist(offset, offset+10));

    isLoading.value = false;
    hasMore.value = _subData.length < maxInfo;
  }

  reload() async {
    isLoading.value = true;
    _subData.clear();
    _titleData.clear();
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
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                color: themeColor1,
                icon: Icon(Icons.arrow_back_ios_new_rounded, size: 15.w,),
              ),
              title: Text(
                "질문 수",
                style: TextStyle(
                  fontFamily: "Barun",
                  fontSize: 15.sp,
                  color: grayColor1,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: _MyQPageBody(),
          );
        }
    );
  }

  Widget _MyQPageBody() {
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
                var titleDatum = _titleData[index];
                var contentDatum = _contentData[index];

                return Container(
                  child: _makeInfoTile("$subDatum", "$titleDatum", "$contentDatum"),
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
                      Text('질문 수의 마지막 입니다'),
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

  Widget _makeInfoTile(sub, title, content) {
    return Container(
      child : ExpansionTile(
        subtitle: Text(
          title,
          style: TextStyle(
            fontFamily: "Barun",
            fontSize: 14.sp,
            color: Colors.black,
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
        initiallyExpanded: false,
        backgroundColor: Colors.white,
        children: <Widget>[
          Divider(height: 1),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0.w, right: 20.0.w ),
            child: Text(
              content,
              style: TextStyle(
                fontFamily: "Barun",
                fontSize: 14.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
