import 'package:flutter/material.dart';
import 'package:flutter_comment_package/models/post.dart';
import 'package:flutter_comment_package/models/user.dart';
import 'package:flutter_comment_package/services/firebase_services.dart';
import 'package:get/get.dart';

import '../flutter_comment_package.dart';
import 'comment_controller.dart';


class PostController extends GetxController{

  late PostUser user;

  final postList = <Post>[].obs;
  List<Post> get posts => postList.value;

  PostController(this.user);


  void onInit(){
    postList.bindStream(postStream());
  }

  void onCommentTap(BuildContext context, String postID){

    final CommentController commentController = Get.put(CommentController(postID, user));

    commentController.resetCommentScreen(postID);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          builder: (context) =>
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.9,
                child: Obx(() =>
                    CommentScreenWidget(
                      commentController: commentController,
                      context: context,
                    ),),
              )
      );
    });
  }

}