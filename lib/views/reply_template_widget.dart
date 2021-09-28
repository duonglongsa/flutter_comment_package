import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_comment_package/models/reply_commet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget ReplyCommentWidget({
  required BuildContext context,
  required ReplyComment replyComment,
}) => Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const SizedBox(width: 40,),
    CircleAvatar(
      radius: 12,
      backgroundColor: Colors.grey,
      backgroundImage: NetworkImage(replyComment.avatarUrl),
    ),
    const SizedBox(width: 10,),
    Expanded(
      child: Column(
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
                  replyComment.userName,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  replyComment.comment,
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
                  Text(timeago.format(replyComment.timeCreated.toDate())),
                  const SizedBox(
                    width: 24,
                  ),
                  const Text('Like'),
                  const SizedBox(
                    width: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ],
);
