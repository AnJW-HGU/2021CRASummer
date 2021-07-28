import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studytogether/Category/post_page.dart';
import 'dart:ui';

import 'package:studytogether/main.dart';

class NotiPage extends StatefulWidget {
  const NotiPage({Key? key}) : super(key: key);

  @override
  _NotiPageState createState() => _NotiPageState();
}

// class _NotiPageState extends State<NotiPage> {
//   var _flutterLocalNotificationsPlugin;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     var initializationSettingsAndroid = AndroidInitializationSettings('');
//     var initializationSettingsIOS = IOSInitializationSettings();
//
//     var initializationSettings = InitializationSettings(
//         initializationSettingsAndroid, initializationSettingsIOS);
//
//     _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: onSelectNotification);
//   }
//
//   Future<void> onSelectNotification(String payload) async {
//     debugPrint("$payload");
//     showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: Text('Notification Payload'),
//           content: Text('Payload: $payload'),
//         ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('알림'),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             MaterialButton(
//               onPressed: _showNotification,
//               child: Text('Show Notification'),
//             ),
//             MaterialButton(
//               onPressed: _dailyAtTimeNotification,
//               child: Text('Daily At Time Notification'),
//             ),
//             MaterialButton(
//               onPressed: _repeatNotification,
//               child: Text('Repeat Notification'),
//             ),
//           ],
//         ),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//
//   Future<void> _showNotification() async {
//     var android = AndroidNotificationDetails(
//         'your channel id', 'your channel name', 'your channel description',
//         importance: Importance.max, priority: Priority.high);
//
//     var ios = IOSNotificationDetails();
//     var detail = NotificationDetails(android, ios);
//
//     await _flutterLocalNotificationsPlugin.show(
//       0,
//       '단일 Notification',
//       '단일 Notification 내용',
//       detail,
//       payload: 'Hello Flutter',
//     );
//   }
//
//   Future<void> _dailyAtTimeNotification() async {
//     var time = Time(22, 40, 0);
//     var android = AndroidNotificationDetails(
//         'your channel id', 'your channel name', 'your channel description',
//         importance: Importance.max, priority: Priority.high);
//
//     var ios = IOSNotificationDetails();
//     var detail = NotificationDetails(android, ios);
//
//     await _flutterLocalNotificationsPlugin.showDailyAtTime(
//       0,
//       '매일 똑같은 시간의 Notification',
//       '매일 똑같은 시간의 Notification 내용',
//       time,
//       detail,
//       payload: 'Hello Flutter',
//     );
//   }
//
//   Future<void> _repeatNotification() async {
//     var android = AndroidNotificationDetails(
//         'your channel id', 'your channel name', 'your channel description',
//         importance: Importance.max, priority: Priority.high);
//
//     var ios = IOSNotificationDetails();
//     var detail = NotificationDetails(android, ios);
//
//     await _flutterLocalNotificationsPlugin.periodicallyShow(
//       0,
//       '반복 Notification',
//       '반복 Notification 내용',
//       RepeatInterval.everyMinute,
//       detail,
//       payload: 'Hello Flutter',
//     );
//   }
// }


class _NotiPageState extends State<NotiPage> {

  // 과목 리스트
  final List<String>_subList = <String>[
    "자바 프로그래밍", "성경의 이해", "데이터 구조", "실전프로젝트",
    "공학설계입문", "C 프로그래밍", "파이썬", "타이포그래피",
    "무언가", "끼룩", "도비", "토익",
    "과목", "과목", "과목", "과목",
    "과목", "과목", "과목", "과목",
  ].obs;

  // 알림 내용 리스트
  final List<String> _notiList = <String> [
    "새로운 답변이 달렸습니다.", "답변이 채택되었습니다.", "답변이 추천되었습니다.", "새로운 답변이 달렸습니다.",
    "새로운 답변이 달렸습니다.", "답변이 채택되었습니다.", "답변이 추천되었습니다.", "새로운 답변이 달렸습니다.",
    "새로운 답변이 달렸습니다.", "답변이 채택되었습니다.", "답변이 추천되었습니다.", "새로운 답변이 달렸습니다.",
    "새로운 답변이 달렸습니다.", "답변이 채택되었습니다.", "답변이 추천되었습니다.", "새로운 답변이 달렸습니다.",
    "새로운 답변이 달렸습니다.", "답변이 채택되었습니다.", "답변이 추천되었습니다.", "새로운 답변이 달렸습니다.",
  ].obs;

  var _maxPost = 20; // 게시글 총 개수
  var _scroll = ScrollController().obs;

  var _subData = <String>[].obs;
  var _notiData = <String>[].obs;

  var isLoading = false.obs;
  var hasMore = false.obs;

  @override
  void initState() {
    _getPost();

    this._scroll.value.addListener(() {
      if (this._scroll.value.position.pixels == this._scroll.value.position.maxScrollExtent &&
          this.hasMore.value) {
        _getPost();
      }
    });

    super.initState();
  }

  _getPost() async {
    isLoading.value = true;

    await Future.delayed(Duration(seconds: 2));

    int offset = _subData.length;
    _subData.addAll(_subList.sublist(offset, offset+10));
    _notiData.addAll(_notiList.sublist(offset, offset+10));

    isLoading.value = false;
    hasMore.value = _subData.length < _maxPost;
  }

  _reload() async {
    isLoading.value = true;
    _subData.clear();
    _notiData.clear();

    await Future.delayed(Duration(seconds: 2));

    _getPost();
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
              "알림",
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
          ),

          body: SafeArea(
            child: Container (
              padding: EdgeInsets.only(top: 20, left: 30.w, right: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Padding(padding: EdgeInsets.only(bottom: 10)),

                  Expanded(
                    child: _makePost(),
                  )
                ],
              ),

              //
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _makePost() {
    return Container(
      child: Obx(()
      => Padding(
        padding: EdgeInsets.all(0.0),
        child: ListView.separated(
          controller: _scroll.value,
          itemBuilder: (_, index) {
            print(hasMore.value); // 데이터 더 있는지 콘솔창에 출력 (확인용)

            if (index < _subData.length) {
              var subDatum = _subData[index];
              var notiDatum = _notiData[index];
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.to(PostPage(), arguments: "$subDatum");
                },
                child: Container(
                  padding: EdgeInsets.only(top: 10.0, left: 5, bottom: 10.0),
                  child: _makePostTile("$subDatum", "$notiDatum"),
                ),
              );
            }

            if (hasMore.value || isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                        "마지막 알림입니다"
                    ),
                    IconButton(
                      onPressed: () {
                        _reload();
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
      ),),
    );
  }

  Widget _makePostTile(sub, noti) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            sub,
            style: TextStyle(
              color: themeColor1,
              fontFamily: "Barun",
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          Text(
            noti,
            style: TextStyle(
              color: grayColor1,
              fontFamily: "Barun",
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
