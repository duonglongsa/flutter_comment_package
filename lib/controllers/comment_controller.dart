import 'package:flutter/material.dart';
import 'package:flutter_comment_package/models/post.dart';
import 'package:flutter_comment_package/models/root_comment.dart';
import 'package:flutter_comment_package/models/user.dart';
import 'package:flutter_comment_package/services/firebase_services.dart';
import 'package:get/get.dart';

import '../flutter_comment_package.dart';


class CommentController extends GetxController{

  late String postID;
  late PostUser user;

  final commentList = <RootComment>[].obs;
  List<RootComment> get comments => commentList.value;

  TextEditingController commentTextController = new TextEditingController();
  final isReplying = false.obs;
  final replyingUserName = " ".obs;
  late String replyingID;

  CommentController(this.postID, this.user);

  void resetCommentScreen(String pID){
    comments.clear();
    commentList.bindStream(commentStream(pID));
    isReplying.value = false;
  }

  void onSendingComment() async {
    await addRootComment(commentTextController.text, postID, user);
    commentTextController.text = '';
  }

  void onSendingReply() async {
    await addReplyComment(commentTextController.text, postID, replyingID, user);
    commentTextController.text = '';
  }

}