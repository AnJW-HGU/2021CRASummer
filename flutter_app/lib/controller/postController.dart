
import 'package:get/get.dart';
import 'package:http/http.dart';

class PostController extends GetxController {
  String postId = '';
  String postUserId = '';

  void setPostInfo(String postId, String postUserId) {
    this.postId = postId;
    this.postUserId = postUserId;
  }
  void setPostId(String postId) {
    this.postId = postId;
  }
}