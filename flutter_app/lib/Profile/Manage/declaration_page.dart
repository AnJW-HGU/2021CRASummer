import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:get/get.dart';

import 'package:studytogether/main.dart';
import 'answer_page.dart';

class DeclarationPage extends StatefulWidget {
  @override
  _DeclaraionPageState createState() => _DeclaraionPageState();
}

class _DeclaraionPageState extends State<DeclarationPage> {
  final List<bool> _isChecked = <bool>[
    false, false, false, false, false,
    true, true, true, true, true,
    false, false, false, false, false,
    true, true, true, true, true,
  ];

  final List<String> _studentID = <String>[
    "21700001", "21700002", "21700010", "21700013",
    "21700001", "21700002", "21700010", "21700013",
    "21700001", "21700002", "21700010", "21700013",
    "21700001", "21700002", "21700010", "21700013",
    "21700001", "21700002", "21700010", "21700013",
  ].obs;

  final List<String> _titleContent = <String>[
    "제모옥", "제모옥", "제모옥", "제모옥",
    "제모옥", "제모옥", "제모옥", "제모옥",
    "제모옥", "제모옥", "제모옥", "제모옥",
    "제모옥", "제모옥", "제모옥", "제모옥",
    "제모옥", "제모옥", "제모옥", "제모옥",
  ].obs;

  var maxInfo = 20;

  var scrollController = ScrollController().obs;

  var _studentIdData = <String>[].obs;
  var _titleContentData = <String>[].obs;
  var _isCheckedData = <bool>[].obs;

  var isLoading = false.obs;
  var hasMore = false.obs;

  @override
  void initState() {
    _getInfo();

    this.scrollController.value.addListener(() {
      if (this.scrollController.value.position.pixels ==
          this.scrollController.value.position.maxScrollExtent &&
          this.hasMore.value) {
        _getInfo();
      }
    });
    super.initState();
  }

  _getInfo() async {
    isLoading.value = true;

    await Future.delayed(Duration(seconds: 2));

    int offset = _studentIdData.length;
    if (_studentID.length < 10) {
      _studentIdData.addAll(_studentID.sublist(offset));
      _titleContentData.addAll(_titleContent.sublist(offset));
      _isCheckedData.addAll(_isChecked.sublist(offset));

      isLoading.value = false;
      hasMore.value = false;
    } else {
      _studentIdData.addAll(_studentID.sublist(offset, offset + 10));
      _titleContentData.addAll(_titleContent.sublist(offset, offset + 10));
      _isCheckedData.addAll(_isChecked.sublist(offset, offset + 10));

      isLoading.value = false;
      hasMore.value = _studentIdData.length < maxInfo;
    }
  }

  reload() async {
    isLoading.value = true;
    _studentIdData.clear();
    _titleContentData.clear();
    _isCheckedData.clear();

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
                color: Colors.white,
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 15.w,
                ),
              ),
              title: Text(
                "신고",
                style: TextStyle(
                  fontFamily: "Barun",
                  fontSize: 15.sp,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              backgroundColor: themeColor2,
            ),
            body: _NamedPageBody());
      },
    );
  }

  Widget _NamedPageBody() {
    return Container(
      child: Obx(
            () => Padding(
          padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
          child: ListView.separated(
            controller: scrollController.value,
            itemBuilder: (_, index) {
              print(hasMore.value);

              if (index < _studentIdData.length) {
                var studentIdDatum = _studentIdData[index];
                var titleContentDatum = _titleContentData[index];
                var isCheckedDatum = _isCheckedData[index];

                return Container(
                  child: _makeNamedTile(
                      "$studentIdDatum", "$titleContentDatum", isCheckedDatum),
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
                      Text('신고의 마지막 입니다'),
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
            itemCount: _studentIdData.length + 1,
          ),
        ),
      ),
    );
  }

  Widget _makeNamedTile(studentId, title_content, isChecked_in) {
    return Container(
      child: ListTile(
        title: new Text(
          studentId,
          style: TextStyle(
            fontFamily: "Barun",
            fontSize: 14.sp,
            color: themeColor2,
          ),
        ),
        subtitle: Text(
          title_content,
          style: TextStyle(
            fontFamily: "Barun",
            fontSize: 16.sp,
            color: grayColor1,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: isChecked_in
            ? Icon(
          Icons.check_box_rounded,
        )
            : Icon(
          Icons.check_box_outline_blank_rounded,
        ),
        onTap: () {
          Get.to(AnswerPage(), arguments: [studentId, title_content]);
        },
      ),
    );
  }
}
