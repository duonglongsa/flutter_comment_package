import 'package:flutter/material.dart';

import 'package:flutter_comment_package/models/post.dart';
import 'package:flutter_comment_package/views/post_template_widget.dart';
import 'package:get/get.dart';

Widget PostScreen({
  required BuildContext context,
  required List<Post> posts,
}) => Obx(() => ListView.builder(
    padding: EdgeInsets.zero,
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: posts.length,
    itemBuilder: (_, index) {
      return ListTile(
        title:  PostWidget(
          context: context,
          userName: posts[index].userName,
          avatarUrl: posts[index].avatarUrl,
          post: posts[index],
        ),
      );
    }
),
);