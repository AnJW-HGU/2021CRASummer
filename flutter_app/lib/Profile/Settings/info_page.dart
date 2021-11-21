import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<List<Info>> fetchInfo() async {
  String userUrl = 'http://128.199.139.159:3000/announcement';
  var response = await http.get(Uri.parse(userUrl));

  if(response.statusCode == 200) {
    return InfofromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load User");
  }
}


// 공지사항 어디서 받아오는지 ?
class Info{
  var kind;
  var title;
  var content;

  Info(
    this.kind,
    this.title,
    this.content,
  );
}

List<Info> InfofromJson(json) {
  List<Info> result = [];

  json.forEach((item){
    result.add(
      Info(item['kind'], item['title'], item['content'])
    );
  });

  return result;
}


class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  List<Info> _infoDataList = [];

  int _maxInfo = 0;

  var scrollController = ScrollController().obs;

  var _isLoading = false.obs;
  var _hasMore = false.obs;

  var _refreshKey = GlobalKey<RefreshIndicatorState>();

  Future <dynamic> fetchLength() async {
    String lengthUrl = 'http://128.199.139.159:3000/announcement/length';
    var response = await http.get(Uri.parse(lengthUrl));

    if(response.statusCode == 200) {
      return lengthfromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load Length");
    }
  }

  int lengthfromJson(json) {
    int length = 0;

    length = int.parse(json['length'].toString());
    print(length);
    return length;
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getInfo();

    this.scrollController.value.addListener(() {
      if(this.scrollController.value.position.pixels ==
          this.scrollController.value.position.maxScrollExtent && this._hasMore.value) {
        _getInfo();
      }
    });
  }

  _getInfo() async {
    _isLoading.value = true;
    List<Info> _newInfoDataList = await fetchInfo();
    _maxInfo = await fetchLength();
    await Future.delayed(Duration(seconds: 2));

    setState((){
      _infoDataList.addAll(_newInfoDataList);
    });

    _isLoading.value = false;
    _hasMore.value = _infoDataList.length < _maxInfo;
    }

  reload() async {
    _isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    _infoDataList.clear();
    _getInfo();
  }

  Future<Null> refresh() async {
    _infoDataList.clear();
    _isLoading.value = false;
    _hasMore.value = false;
    _getInfo();
    await Future.delayed(Duration(seconds: 1));
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
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                "공지사항",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: "Barun",
                  color: grayColor1,
                ),
              ),
            ),
            body: RefreshIndicator(
              key: _refreshKey,
              child: Container(
                child: Obx(
                      () => Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: ListView.separated(
                      controller: scrollController.value,
                      itemBuilder: (BuildContext _context, index) {
                        if (index < _infoDataList.length) {
                          return Container(
                            child: _makeInfoTile(
                              "${_infoDataList[index].kind}",
                              "${_infoDataList[index].title}",
                              "${_infoDataList[index].content}",
                            ));
                        }
                        if (_hasMore.value || _isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Column(
                              children: [
                                Text('공지사항의 마지막 입니다'),
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
                      itemCount: _infoDataList.length + 1,
                    ),
                  ),
                ),
              ),
              onRefresh: () => refresh(),
            ),
          );
        }
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