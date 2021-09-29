import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_comment_package/controllers/comment_controller.dart';
import 'package:flutter_comment_package/models/root_comment.dart';
import 'package:flutter_comment_package/views/reply_template_widget.dart';
import 'package:flutter_comment_package/views/root_template_widget.dart';
import 'package:get/get.dart';



Widget CommentScreenWidget({
  required BuildContext context,
  required CommentController commentController,

}) => Scaffold(
  bottomSheet: Container(
    decoration: const BoxDecoration(
      color: Colors.black45,
    ),
    height: commentController.isReplying.value? 60 : 45,
    child: Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(commentController.isReplying.value) Row(
              children: [
                const SizedBox(width: 20,),
                Container(
                  height: 15,
                  child: RichText(
                    text: TextSpan(
                      text: 'Replying to ',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: commentController.replyingUserName.value,
                          style: const TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 50,),
                InkWell(
                  onTap: (){
                    commentController.isReplying.value = false;
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),

              ],
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.white70,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: commentController.commentTextController,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, bottom: 7),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    color: Colors.black54,
                    onPressed: (){
                      if (commentController.commentTextController.text != '') {
                        if(commentController.isReplying.value) {
                          commentController.onSendingReply();
                        }
                        else {
                          commentController.onSendingComment();
                        }
                        commentController.commentTextController.text = '';
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ]
      ),
    ),
  ),

  appBar: AppBar(
    toolbarHeight: 40,
    backgroundColor: Colors.blueGrey[600],
    centerTitle: true,
    title: const Text(
        'Comment'
    ),
    leading: IconButton(
      onPressed: () async {
        Get.back();
      },
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
    ),
  ),
  body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blueGrey[600]!,
                      Colors.blueGrey[700]!,
                      Colors.blueGrey[800]!,
                      Colors.blueGrey[900]!,
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20,),
                        Obx(() => ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              //scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: commentController.comments.length,
                              itemBuilder: (_, index) {
                                return ListTile(
                                  title: Obx(() => Column(
                                        children: [
                                          RootCommentWidget(
                                            context: context,
                                            rootComment: commentController.comments[index],
                                            rootIndex: index,
                                            onReplyTap: (){
                                              commentController.comments[index].isShowingReply.value = true;
                                              commentController.replyingUserName.value = commentController.comments[index].userName;
                                              commentController.isReplying.value = true;
                                              commentController.replyingID = commentController.comments[index].commentId;
                                            },
                                          ),
                                          if (commentController.comments[index].isShowingReply.value) Column(
                                                children: [
                                                  ListView.builder(
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: commentController.comments[index].replies.length,
                                                      itemBuilder: (_, i) {
                                                        return  ListTile(
                                                          title: Obx(() =>
                                                              ReplyCommentWidget(
                                                                context: context,
                                                                replyComment: commentController.comments[index].replies[i],
                                                              ),
                                                          ),
                                                        );
                                                      }
                                                  ),
                                                  Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children:  [
                                                        const SizedBox(width: 55,),
                                                        const SizedBox(width: 10,),
                                                        Flexible(
                                                          child: InkWell(
                                                            onTap: (){
                                                              commentController.replyingUserName.value = commentController.comments[index].userName;
                                                              commentController.isReplying.value = true;
                                                              commentController.replyingID = commentController.comments[index].commentId;
                                                            },
                                                            child: Container(
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius:  BorderRadius.circular(20.0),
                                                              ),
                                                              child: TextFormField(
                                                                enabled: false,
                                                                autofocus: true,
                                                                decoration: const InputDecoration(
                                                                  hintText: 'Reply...',
                                                                  hintStyle: TextStyle(
                                                                    fontSize: 13,
                                                                  ),
                                                                  contentPadding: EdgeInsets.only(left: 14, bottom: 10),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ]
                                                  ),
                                                ],
                                              ),

                                        ]
                                    ),
                                  ),

                                );
                              }
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    ),
);



