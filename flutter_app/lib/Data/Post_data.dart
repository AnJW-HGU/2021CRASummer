import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Category/addPost_page.dart';
// DATA

class Post {
  // POST 요청
  String postClassifi = "011220";
  String postUser = "200404";
  String postImage = "0";
  String? inTitle;
  String? inContent;

  Post(String inTitle, String inContent) {
    this.inTitle = inTitle;
    this.inContent = inContent;
  }

  void _addPost() async {
    String uri = "https://c64ab34d-ad62-4f6e-9578-9a43e222b9bf.mock.pstmn.io/Create";

    http.Response response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': "application/json",
      },
      body: jsonEncode(
        {
          "classification_id":postClassifi,
          "user_id":postUser,
          "image_id":postImage,
          "title":inTitle,
          "content":inContent
        },
      ),
    );
  }


}
