import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:studytogether/main.dart';

class UsersInfoPage extends StatefulWidget {
  const UsersInfoPage({Key? key}) : super(key: key);

  @override
  _UsersInfoPageState createState() => _UsersInfoPageState();
}

class _UsersInfoPageState extends State<UsersInfoPage> {
  final List<String> _studentID = <String>[
    "21700001",
    "21700002",
    "21700010",
    "21700013",
    "21700001",
    "21700002",
    "21700010",
    "21700013",
    "21700001",
    "21700002",
    "21700010",
    "21700013",
    "21700001",
    "21700002",
    "21700010",
    "21700013",
    "21700001",
    "21700002",
    "21700010",
    "21700013",
  ].obs;

  final List<String> _nickName = <String>[
    "닉네네네네에에임",
    "닉네네네네에에임",
    "닉네네네네에에임",
    "닉네네네네에에임",
    "닉네네네네에에임",
    "닉네네네네에에임",
    "닉네네네네에에임",
    "닉네네네네에에임",
    "닉네네네네에에임",
    "닉네네네네에에임",
    "닉네네네네에에임",
    "닉네네네네에에임",
    "닉네네네네에에임",
    "닉네네네네에에임",
    "닉네네네네에에임",
    "닉네네네네에에임",
    "닉네네네네에에임",
    "닉네네네네에에임",
    "닉네네네네에에임",
    "닉네네네네에에임",
  ].obs;

  final List<String> _time = <String>[
    "2021.07.26 11:29",
    "2021.07.26 11:29",
    "2021.07.26 11:29",
    "2021.07.26 11:29",
    "2021.07.26 11:29",
    "2021.07.26 11:29",
    "2021.07.26 11:29",
    "2021.07.26 11:29",
    "2021.07.26 11:29",
    "2021.07.26 11:29",
    "2021.07.26 11:29",
    "2021.07.26 11:29",
    "2021.07.26 11:29",
    "2021.07.26 11:29",
    "2021.07.26 11:29",
    "2021.07.26 11:29",
    "2021.07.26 11:29",
    "2021.07.26 11:29",
    "2021.07.26 11:29",
    "2021.07.26 11:29",
  ].obs;

  var maxInfo = 20;

  var scrollController = ScrollController().obs;

  var _studentIdData = <String>[].obs;
  var _nickNameData = <String>[].obs;
  var _timeData = <String>[].obs;

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
      _nickNameData.addAll(_nickName.sublist(offset));
      _timeData.addAll(_time.sublist(offset));

      isLoading.value = false;
      hasMore.value = false;
    } else {
      _studentIdData.addAll(_studentID.sublist(offset, offset + 10));
      _nickNameData.addAll(_nickName.sublist(offset, offset + 10));
      _timeData.addAll(_time.sublist(offset, offset + 10));

      isLoading.value = false;
      hasMore.value = _studentIdData.length < maxInfo;
    }
  }

  reload() async {
    isLoading.value = true;
    _studentIdData.clear();
    _nickNameData.clear();
    _timeData.clear();

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
                "회원 정보",
                style: TextStyle(
                  fontFamily: "Barun",
                  fontSize: 15.sp,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              backgroundColor: themeColor2,
            ),
            body: _UsersInfoBody());
      },
    );
  }

  Widget _UsersInfoBody() {
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
                var nickNameDatum = _nickNameData[index];
                var timeDatum = _timeData[index];

                return Container(
                  child: _makeUserInfoTile(
                      "$studentIdDatum", "$nickNameDatum", "$timeDatum"),
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
                      Text('회원 정보의 마지막 입니다'),
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

  Widget _makeUserInfoTile(student_id, nick, sign_time) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(
            top: 10.0.h, bottom: 10.0.h, left: 10.0.w, right: 10.0.w),
        child: Row(
          children: [
            CircleAvatar(
              radius: 17,
              backgroundColor: themeColor3,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 3.0, bottom: 3.0, left: 15.0.w, right: 13.0.w),
              child: Text(
                student_id,
                style: TextStyle(
                  fontFamily: "Barun",
                  color: grayColor1,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 10.0.w, right: 13.0.w),
              child: Text(
                nick,
                style: TextStyle(
                  fontFamily: "Barun",
                  color: grayColor1,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 15.0.w),
              child: Text(
                sign_time,
                style: TextStyle(
                  fontFamily: "Barun",
                  color: grayColor1,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
