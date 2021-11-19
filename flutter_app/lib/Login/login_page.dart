import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:studytogether/main.dart';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);


class App extends StatelessWidget {
  final Future<FirebaseApp> _init = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Firebase core loads fail"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Home();
          }

          return CircularProgressIndicator();
        });
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return LoginPage();
                  } else {
                    return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "${FirebaseAuth.instance.currentUser!.displayName} 님 로그인"),
                            TextButton(
                                child: Text("Logout"),
                                onPressed: FirebaseAuth.instance.signOut)
                          ],
                        ));
                  }
                })));
  }
}

Future<UserCredential> signInWithGoogle() async {
  print("Hello");
// 1. Authentication (인증 정보) 취득
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleAuth =
  await googleUser!.authentication;

// 2. Firebase Auth Sign In
  // Create a new credential

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("firebase login")),
        body: _LoginPageBody()
    );
  }

  Widget _LoginPageBody(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      //배경 넣기
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Login.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        //중간 정렬
        child: Center(
          child: Container(
            //위치 조정
            padding: EdgeInsets.only(top: 235.h, left: 50.w, right: 50.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // //'ST' 넣기
                // Text('ST',style: TextStyle(
                //     fontSize: 64.sp,
                //     fontWeight: FontWeight.w400,
                //     color: themeColor1,
                //     fontFamily: "Barun", //폰트 지정
                //     // shadows: [Shadow(
                //     //   color: blurColor,
                //     //   offset: Offset(0,4.0),
                //     //   blurRadius: 4,
                //     // )]
                // ),),
                // SizedBox(height: 110.h,),
                // //아이콘이 포함된 버튼( 회원가입 버튼 )
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.g_mobiledata_sharp,
                    size: 45,
                    color: themeColor1,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: HexColor("#FFFFFF"),
                    //onPrimary: themeColor2,
                    elevation: 5.0,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                    side: BorderSide(
                      width: 1.5, color: themeColor1,
                    ),
                  ),
                  //버튼이 눌리면 동작
                  onPressed: signInWithGoogle,
                  //버튼 안에 text
                  label: Text("      구글로 회원가입        ", style: TextStyle(
                      fontFamily: "Barun",
                      color: themeColor1,
                      fontWeight: FontWeight.w500,
                      fontSize: 17.sp,
                      shadows: [Shadow(
                        color: blurColor,
                        offset: Offset(0,1.0),
                        blurRadius: 1,
                      )]
                  ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // Center(
    //   child: Column(children: [GoogleLoginButton()]),
    // )
  }
}

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignInButton(Buttons.Google, onPressed: signInWithGoogle);
  }
}