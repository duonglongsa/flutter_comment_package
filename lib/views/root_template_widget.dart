import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_comment_package/models/root_comment.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;




Widget RootCommentWidget({
  required BuildContext context,
  required RootComment rootComment,
  required int rootIndex,
  VoidCallback? onLikeTap,
  VoidCallback? onReplyTap,
}) => Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    CircleAvatar(
      radius: 18,
      backgroundColor: Colors.grey,
      backgroundImage: NetworkImage(rootComment.avatarUrl),
    ),
    const SizedBox(width: 10,),
    Expanded(
      child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rootComment.userName,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    rootComment.comment,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        fontWeight: FontWeight.w300, color: Colors.black),
                  ),
                ],
              ),
            ),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.caption!.copyWith(
                  color: Colors.white60, fontWeight: FontWeight.bold),
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Text(timeago.format(rootComment.timeCreated.toDate())),
                    const SizedBox(
                      width: 24,
                    ),
                    InkWell(
                      onTap: onLikeTap,
                      child: const Text(
                          'Like'
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    InkWell(
                      onTap: onReplyTap,
                      child: const Text(
                          'Reply'
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if(rootComment.isShowingReply.value && rootComment.replies.isNotEmpty) InkWell(
              onTap: () {
                rootComment.isShowingReply.value = false;
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.white60,
                    size: 20,
                  ),
                  Text(
                    'Hide all replies',
                    style: TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            if(!rootComment.isShowingReply.value && rootComment.replies.isNotEmpty) InkWell(
              onTap: () {
                rootComment.isShowingReply.value = true;
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white60,
                    size: 20,
                  ),
                  Text(
                    'Show more (${rootComment.replies.length}) replies',
                    style: const TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
);
