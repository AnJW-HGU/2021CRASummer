import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:get/get.dart';

class PrivacyRulePage extends StatefulWidget {
  @override
  _PrivacyRulePageState createState() => _PrivacyRulePageState();
}

class _PrivacyRulePageState extends State<PrivacyRulePage> {
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
                "개인정보처리방침",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: "Barun",
                  color: grayColor1,
                ),
              ),
            ),
            body: _PrivacyRulePageBody(),
          );
        }
    );
  }

  Widget _PrivacyRulePageBody() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 30.0, bottom: 30.0, left: 20.0.w, right: 20.0.w),
        child: Text(
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
          style: TextStyle(
            fontFamily: "Barun",
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}