import 'package:flutter/material.dart';
import 'package:flutter_comment_package/controllers/post_controller.dart';

import 'package:flutter_comment_package/models/post.dart';
import 'package:flutter_comment_package/models/user.dart';
import 'package:flutter_comment_package/views/post_template_widget.dart';
import 'package:get/get.dart';

Widget PostScreen({
  required BuildContext context,
  required PostController postController,
}) => Obx(() => ListView.builder(
    padding: EdgeInsets.zero,
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: postController.posts.length,
    itemBuilder: (_, index) {
      return ListTile(
        title:  PostWidget(
          context: context,
          userName: postController.posts[index].userName,
          avatarUrl: postController.posts[index].avatarUrl,
          post: postController.posts[index],
          onCommentTap: () => postController.onCommentTap(context, postController.posts[index].contentId),
        ),
      );
    }
),
);