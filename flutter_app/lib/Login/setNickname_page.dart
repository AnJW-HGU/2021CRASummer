import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:studytogether/Category/category_page.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:studytogether/splash_page.dart';
import 'package:http/http.dart' as http;

setNickname(String _id, String nickname_nickname) async {
  var response = await http.post(
      Uri.parse('https://0c5f29c1-526c-4b53-af83-ce20fecb0819.mock.pstmn.io/nickname?user_id=000000'),
      headers: <String, String> {
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, dynamic> {
        'id': _id, //앞 페이지에서 받아오기
        'nickname': nickname_nickname
      })
  );

  if (response.statusCode == 200) {
    if(response.body.isNotEmpty) {
      return Nickname.fromJson(json.decode(response.body));
    }

  } else {
    // 만약 요청이 실패하면, 에러를 던집니다.
    throw Exception('Failed to load post');
  }
}

class Nickname {
  //var nickname_id;
  var nickname_nickname;

  Nickname({this.nickname_nickname});

  factory Nickname.fromJson(String nickname_nickname) {
    return Nickname(
      //nickname_id: json["id"],
      nickname_nickname: nickname_nickname,
    );
  }
}

class SetNicknamePage extends StatefulWidget {
  @override
  _SetNicknamePageState createState() => _SetNicknamePageState();
}

class _SetNicknamePageState extends State<SetNicknamePage> {
  String _id = Get.arguments; //회원가입 페이지에서 id 받아오기
  bool _isChecked1 = false; //이용약관
  bool _isChecked2 = false; //개인정보 처리
  bool _isNamed = false; //닉네임을 입력했는지

  final _nickName = TextEditingController();

  Future<Nickname>? nickname;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // 위젯이 dispose 또는 dismiss 될 때 컨트롤러를 clean up!
    _nickName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(411.4, 683.4),
        builder: () {
          return Scaffold(
            backgroundColor: HexColor("#FFFFFF"),
            resizeToAvoidBottomInset: false,
            body: _setNicknamePageBody(),
          );
        }
    );
  }

  //body
  Widget _setNicknamePageBody() {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        //배경
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.only(top: 150.h, left: 80.w, right: 80.w),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text('  닉네임을 설정해주세요:)',style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: themeColor2,
                            fontFamily: "Barun",
                          ),),
                        ],
                      ),
                      SizedBox(height: 10,),

                      //닉네임 받기
                      TextField(
                        //autofocus: true,
                        controller: _nickName,
                        textInputAction: TextInputAction.go,
                        onSubmitted: (value) {
                          if(_nickName.text.length >= 1) {
                            setState(() {
                              _isNamed = true;
                            });
                          } else{
                            setState(() {
                              _isNamed = false;
                            });
                          }
                          print("${_nickName.text}");
                        },
                        textAlign: TextAlign.center,
                        //닉네임 문자 제한
                        maxLength: 8,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[ㄱ-ㅎ|가-힣|ㆍ|ᆢ]'))],
                        cursorHeight: 20,
                        decoration: InputDecoration(
                          counterStyle: TextStyle(
                            color: themeColor1.withOpacity(0.75),
                            fontSize: 13.sp,
                          ),
                          //counterText: "",
                          contentPadding: EdgeInsets.symmetric(vertical: 3),
                          hintText: '닉네임은 한글만 가능합니다',
                          hintStyle: TextStyle(
                            fontFamily: "Barun",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: HexColor("#C2C2C2"),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: themeColor2)
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: themeColor2),
                          ),
                          //counterStyle: TextStyle(
                          //  color: themeColor2,
                          //),
                        ),
                      ),

                      //선 긋기
                      Padding(
                        padding: EdgeInsets.only(top: 15.h, left: 10.w, right: 10.w, bottom: 6.h),
                        child: Divider(color: themeColor3, thickness: 1.5,),
                      ),

                      //이용약관
                      Container(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: ListTileTheme(
                          dense: true,
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.all(0),
                            title: Text('이용약관', style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: themeColor2,
                              fontFamily: "Barun",
                            ),),
                            value: _isChecked1,
                            onChanged: (value) {
                              Get.defaultDialog(
                                title: '이용약관',
                                content: Flexible(
                                  child: SingleChildScrollView(
                                      child: getContent1()),
                                ),
                                barrierDismissible: false,
                                radius: 15.0,
                                confirm: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _isChecked1 = true;
                                      });
                                      Get.back();
                                    },
                                    child: Text("동의", style: TextStyle(fontFamily: "Barun",))),
                                cancel: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _isChecked1 = false;
                                      });
                                      Get.back();
                                    },
                                    child: Text("취소", style: TextStyle(fontFamily: "Barun",))),
                                titleStyle: TextStyle(fontFamily: "Barun"),
                                middleTextStyle: TextStyle(fontFamily: "Barun"),
                              );
                            },
                            activeColor: themeColor2,
                            checkColor: Colors.white,
                            isThreeLine: false,
                            selected: _isChecked1,
                          ),
                        ),
                      ),

                      //개인정보처리방침
                      Container(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text('개인정보 처리방침', style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: themeColor2,
                            fontFamily: "Barun",
                          ),),
                          value: _isChecked2,
                          onChanged: (value) {
                            Get.defaultDialog(
                              title: '개인정보 처리방침',
                              //middleText: '약관에 동의 한다면 확인',
                              content: Flexible(
                                child: SingleChildScrollView(
                                    child: getContent2()),
                              ),
                              barrierDismissible: false,
                              radius: 15.0,
                              confirm: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isChecked2 = true;
                                    });
                                    Get.back();
                                  },
                                  child: Text("동의", style: TextStyle(fontFamily: "Barun",))),
                              cancel: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isChecked2 = false;
                                    });
                                    Get.back();
                                  },
                                  child: Text("취소", style: TextStyle(fontFamily: "Barun",))),
                              titleStyle: TextStyle(fontFamily: "Barun"),
                              middleTextStyle: TextStyle(fontFamily: "Barun"),
                            );
                          },
                          activeColor: themeColor2,
                          checkColor: Colors.white,
                          isThreeLine: false,
                          selected: _isChecked2,
                        ),
                      ),

                      //선 긋기
                      Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w, bottom: 30.h),
                        child: Divider(color: themeColor3, thickness: 1.5,),
                      ),

                      //확인 버튼
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 45,
                        onPressed: _isChecked1 ? (_isChecked2 ? (_isNamed ? whenTap : null) : null) : null,
                        color: themeColor1,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text("확인", style: TextStyle(
                          fontFamily: "Barun",
                          color: HexColor("#FFFFFF"),
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp,
                          shadows: [Shadow(
                            color: blurColor,
                            offset: Offset(0,2.0),
                            blurRadius: 2,
                          )],
                        ),),
                        //버튼 비활성화 색
                        disabledColor: grayColor2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //확인 버튼이 눌렸을 때
  void whenTap(){
    setNickname(_id, _nickName.text);
    Get.offAll(SplashPage());
  }

  //이용약관 내용
  Widget getContent1() {
    return Container(
        padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 10.h,),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('제 1장 총칙'
                  '\n\n'
                  '제 1조 (목적)'
                  '\n이 약관은 “CRA”(이하 “회사”라 합니다)가 제공하는 “스터디투게더”(이하 ‘서비스’라 합니다)를 회사와 이용계약을 체결한 ‘고객’이 이용함에 있어 필요한 회사와 고객의 권리 및 의무, 기타 제반 사항을 정함을 목적으로 합니다.'
                  '\n\n'
                  '제 2조 (약관 외 준칙)'
                  '\n이 약관에 명시되지 않은 사항에 대해서는 위치 정보의 보호 및 이용 등에 관한 법률, 전기통신사업법, 정보통신망 이용 촉진 및 보호 등에 관한 법률 등 관계법령 및 회사가 정한 서비스의 세부이용지침 등의 규정에 따릅니다.'
                  '\n\n'
                  '제 2장 서비스의 이용'
                  '\n\n'
                  '제 3조 (가입자격)'
                  '\n① 서비스에 가입할 수 있는 자는 Application 이 설치가능한 모든 한동대학교 메일을 가지고 있는 사람 입니다.'
                  '\n\n'
                  '제 4조 (서비스 가입)'
                  '\n① “Application 관리자”가 정한 본 약관에 고객이 동의하면 서비스 가입의 효력이 발생합니다.'
                  '\n②“Application 관리자”는 다음 각 호의 고객 가입신청에 대해서는 이를 승낙하지 않을 수 있습니다.'
                  '\n    1. 고객 등록 사항을 누락하거나 오기하여 신청하는 경우'
                  '\n    2. 공공질서 또는 미풍양속을 저해하거나 저해할 목적으로 신청한 경우'
                  '\n    3. 기타 회사가 정한 이용신청 요건이 충족되지 않았을 경우'
                  '\n\n'
                  '제 5조 (서비스의 탈퇴)'
                  '\n서비스 탈퇴를 희망하는 고객은 “Application 담당자”가 정한 소정의 절차(설정메뉴의 탈퇴)를 통해 서비스 해지를 신청할 수 있습니다.'
                  '\n\n'
                  '제 6조 (서비스의 수준)'
                  '\n① 서비스의 이용은 연중무휴 1일 24시간을 원칙으로 합니다. 단, 회사의 업무상이나 기술상의 이유로 서비스가 일시 중지될 수 있으며, 운영상의 목적으로 회사가 정한 기간에는 서비스가 일시 중지될 수 있습니다. 이러한 경우 회사는 사전 또는 사후에 이를 공지합니다.'
                  '\n② 위치정보는 관련 기술의 발전에 따라 오차가 발생할 수 있습니다.'
                  '\n\n'
                  '제 7조 (서비스 이용의 제한 및 정지)'
                  '\n회사는 고객이 다음 각 호에 해당하는 경우 사전 통지 없이 고객의 서비스 이용을 제한 또는 정지하거나 직권 해지를 할 수 있습니다.'
                  '\n    1. 타인의 서비스 이용을 방해하거나 타인의 개인정보를 도용한 경우'
                  '\n    2. 서비스를 이용하여 법령, 공공질서, 미풍양속 등에 반하는 행위를 한 경우'
                  '\n    3. 서비스 자체에서 금지한 행위를 한 경우'
                  '\n\n'
                  '제 8조 (서비스의 변경 및 중지)'
                  '\n① 회사는 다음 각 호의 1에 해당하는 경우 고객에게 서비스의 전부 또는 일부를 제한, 변경하거나 중지할 수 있습니다.'
                  '\n    1. 서비스용 설비의 보수 등 공사로 인한 부득이한 경우'
                  '\n    2. 정전, 제반 설비의 장애 또는 이용량의 폭주 등으로 정상적인 서비스 이용에 지장이 있는 경우'
                  '\n    3. 서비스 제휴업체와의 계약 종료 등과 같은 회사의 제반 사정 또는 법률상의 장애 등으로 서비스를 유지할 수 없는 경우'
                  '\n    4.기타 천재지변, 국가비상사태 등 불가항력적 사유가 있는 경우'
                  '\n② 제1항에 의한 서비스 중단의 경우에는 회사는 인터넷 등에 공지하거나 고객에게 통지합니다. 다만, 회사가 통제할 수 없는 사유로 인한 서비스의 중단 (운영자의 고의, 과실이 없는 디스크 장애, 시스템 다운 등)으로 인하여 사전 통지가 불가능한 경우에는 사후에 통지합니다.'
                  '\n\n'
                  '제 5장 기타'
                  '\n\n'
                  '제 19조 (회사의 연락처)'
                  '\n회사의 상호와 이메일은 다음과 같습니다.'
                  '\n    1. 상호: “CRA”'
                  '\n    2. 회사 이메일 :'
                  '\n\n'
                  '제 20조 (양도금지)'
                  '\n고객 및 회사는 고객의 서비스 가입에 따른 본 약관상의 지위 또는 권리, 의무의 전부 또는 일부를 제3자에게 양도, 위임하거나 담보제공 등의 목적으로 처분할 수 없습니다.'
                  '\n\n'
                  '제 21조 (손해배상)'
                  '\n① 고객의 고의나 과실에 의해 이 약관의 규정을 위반함으로 인하여 회사에 손해가 발생하게 되는 경우, 이 약관을 위반한 고객은 회사에 발생하는 모든 손해를 배상하여야 합니다.'
                  '\n② 고객이 서비스를 이용함에 있어 행한 불법행위나 고객의 고의나 과실에 의해 이 약관 위반행위로 인하여 회사가 당해 고객 이외의 제3자로부터 손해배상청구 또는 소송을 비롯한 각종 이의제기를 받는 경우 당해 고객은 그로 인하여 회사에 발생한 손해를 배상하여야 합니다.'
                  '\n③ 회사가 위치정보의 보호 및 이용 등에 관한 법률 제 15조 내지 제26조의 규정을 위반한 행위 혹은 회사가 제공하는 서비스로 인하여 고객에게 손해가 발생한 경우, 회사가 고의 또는 과실 없음을 입증하지 아니하면, 고객의 손해에 대하여 책임을 부담합니다.'
                  '\n\n'
                  '제 22조 (면책사항)'
                  '\n① 회사는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면제됩니다.'
                  '\n② 회사는 고객의 귀책사유로 인한 서비스의 이용장애에 대하여 책임을 지지 않습니다.'
                  '\n③ 회사는 고객이 서비스를 이용하여 기대하는 수익을 상실한 것에 대하여 책임을 지지 않으며, 그 밖에 서비스를 통하여 얻은 자료로 인한 손해 등에 대하여도 책임을 지지 않습니다.'
                  '\n④ 회사에서 제공하는 서비스 및 서비스를 이용하여 얻은 정보에 대한 최종판단은 고객이 직접 하여야 하고, 그에 따른 책임은 전적으로 고객 자신에게 있으며, 회사는 그로 인하여 발생하는 손해에 대해서 책임을 부담하지 않습니다.'
                  '\n⑤ 회사의 업무상 또는 기술상의 장애로 인하여 서비스를 개시하지 못하는 경우 회사는 공지사항 등에 이를 공지하거나 E-mail 등의 방법으로 고객에게 통지합니다. 단, 회사가 통제할 수 없는 사유로 인하여 사전 공지가 불가능한 경우에는 사후에 공지합니다.'
                  '\n\n'
                  '제 23조 (분쟁의 해결 및 관할법원)'
                  '\n① 서비스 이용과 관련하여 회사와 고객 사이에 분쟁이 발생한 경우, 회사와 고객은 분쟁의 해결을 위해 성실히 협의합니다.'
                  '\n② 제1항의 협의에서도 분쟁이 해결되지 않을 경우 양 당사자는 정보통신망 이용촉진 및 정보보호 등에 관한 법률 제33조의 규정에 의한 개인정보분쟁조정위원회에 분쟁조정을 신청할 수 있습니다.',
                style: TextStyle(fontFamily: "Barun", fontSize: 15.sp),
              ),
            ],
          ),
        ),
    );
  }

  //개인정보 처리방침 내용
  Widget getContent2() {
    return Container(
      padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 10.h,),
      child: SafeArea(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "<개인정보처리방침>\n\n"
                "■ 개인정보 수집 및 이용 목적\n"
                "회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다.\n\n"
                "＊ 게시판 이용\n"
                "- 회원가입을 한 사용자는 게시판 글 작성, 댓글 작성, 추천, 채택 등 커뮤니티 활동을 이용할 수 있습니다.\n"
                "＊ 스터디 모집 이용\n"
                "- 회원가입을 한 사용자는 스터디 모집, 스터디 신청 등 스터디와 관련된 활동을 이용할 수 있습니다.\n\n"

                "■ 개인정보 수집 항목\n"
                "회사는 회원가입, 서비스 신청을 위해 아래와 같은 개인정보를 수집하고 있습니다.\n\n"
                "＊ 수집항목: 학번 이메일(한동 구글 이메일), 이름(한동 구글 계정), 닉네임\n"
                "＊ 개인정보 수집방법: 앱 설치 시 회원가입 페이지에서 구글 이메일 인증을 통해서 가입\n\n"

                "■  제 3자 제공시 제공받는 자의 성명, 제공받는 자의 이용 목적과 제공하는 항목\n"
                "회사는 고객님의  정보를 제 3자에게 제공하지 않습니다. "
                "개인정보를 ‘개인정보의 수집 및 활용 목적, 수집하는 개인정보 항목’에서 고지한 범위 내에서 활용하며, "
                "동 범위를 초과하여 이용하거나 타인 또는 타 기업, 기관에 제공하지 않습니다.\n\n"

                "■ 개인정보의 보유 및 이용 기간, 개인정보의 파기 절차 및 파기 방법\n"
                "고객의 개인정보는 회원탈퇴 등 수집 및 이용목적이 달성되거나 동의철회 요청이 있는 경우 지체없이 파기됩니다.\n\n"

                "＊ 개인정보 보유 및 이용기간\n"
                "회사는 개인정보 수집 및 이용목적이 달성된 후에는 예외 없이 해당 정보를 파기합니다.\n\n"

                "＊ 개인정보 파기절차 및 파기방법\n"
                "회사는 개인정보 수집 및 이용목적이 달성된 후에는 예외 없이 해당 정보를 파기합니다.\n\n"

                "＊ 파기절차\n"
                "회원님이 회원가입 등을 위해 입력하신 정보는 목적이 달성된 후 별도의 DB로 옮겨져(종이의 경우 별도의 서류함) "
                "내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(보유 및 이용기간 참조) 일정 기간 저장된 후 파기되어집니다.\n\n"
                "별도 DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 보유되어지는 것 이외의 다른 목적으로 이용되지 않습니다.\n\n"

                "＊ 파기방법\n"
                "- 종이에 출력된 개인정보는 분쇄기로 분쇄 또는 소각하여 파기합니다.\n\n"
                "- 전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.\n\n"

                "■ 이용자 및 법정대리인의 권리와 그 행사방법\n"
                "개인정보관리책임자에게 서면, 전화 또는 이메일로 연락하시면 지체없이 변경된 개인정보에 대하여 정정 및 철회의 조치를 하겠습니다.\n\n"
                "귀하가 개인정보의 오류에 대한 정정을 요청하신 경우에는 정정을 완료하기 전까지 당해 개인정보를 이용 또는 제공하지 않습니다. "
                "또한 잘못된 개인정보를 제3자에게 이미 제공한 경우에는 정정 처리결과를 제3자에게 지체없이 통지하여 정정이 이루어지도록 하겠습니다.\n\n"
                "회사는 이용자 혹은 법정 대리인의 요청에 의해 해지 또는 삭제된 개인정보는 회사가 수집하는 개인정보의 보유 및 이용기간”에 명시된 바에 따라 처리하고 "
                "그 외의 용도로 열람 또는 이용할 수 없도록 처리하고 있습니다.\n\n"

                "■ 개인정보 자동수집 장치의 설치, 운영 및 거부에 관한 사항\n"
                "서비스 이용 시 자동 생성되는 개인정보를 수집하는 장치를 운영하지 않습니다.\n\n"

                "■ 개인정보 보호책임자 또는 담당자의 이름 및 연락처\n"
                "고객의 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 아래와 같이 관련 부서 및 개인정보관리책임자를 지정하고 있습니다. "
                "개인정보와 관련하여 민원이나 문의가 있으시면, 연락주시기 바랍니다. 성심성의껏 응대하겠습니다.\n"
                "\t＊ 개인정보 책임자: 안지원\n"
                "\t＊ 담당부서: 서비스팀\n"
                "\t＊ 전화번호: 010-7920-7003\n"
                "\t＊ 이메일: 22000404@handong.edu\n"
                "회사의 서비스를 이용하시며 발생하는 모든 개인정보보호 관련 민원을 개인정보관리책임자 혹은 담당부서로 신고하실 수 있습니다. "
                "회사는 이용자들의 신고사항에 대해 신속하게 충분한 답변을 드릴 것입니다.\n\n"

                "■ 기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.\n"
                "1. 개인분쟁조정위원회 (www.1336.or.kr/1336)\n"
                "2. 정보보호마크인증위원회 (www.eprivacy.or.kr/02-580-0533~4)\n"
                "3. 대검찰청 인터넷범죄수사센터 (http://icic.sppo.go.kr/02-3480-3600)\n"
                "4. 경찰청 사이버테러대응센터(www.ctrc.go.kr/)\n",
              style: TextStyle(fontFamily: "Barun", fontSize: 15.sp),
            ),
          ],
        ),
      ),
    );
  }
}