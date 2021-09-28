import 'package:flutter/widgets.dart';
import 'package:flutter_comment_package/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;


Widget PostWidget({
  required BuildContext context,
  required Post post,
  required String userName,
  required String avatarUrl,
  VoidCallback? onLikeTap,
  VoidCallback? onCommentTap,
}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(avatarUrl),
        ),
        const SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: Theme.of(context).textTheme.caption!.copyWith(
                  fontWeight: FontWeight.w600, color: Colors.white),
            ),
            Text(
              timeago.format(post.timeCreated.toDate()),
              style: Theme.of(context).textTheme.caption!.copyWith(
                  fontWeight: FontWeight.w400, color: Colors.white30, fontSize: 12),
            ),
          ],
        ),
      ],
    ),
    const SizedBox(height: 8,),
    Text(
      post.content,
      style: Theme.of(context).textTheme.caption!.copyWith(
          fontWeight: FontWeight.w300, color: Colors.white),
    ),
    Row(
      children: [
        TextButton(
          onPressed: onLikeTap,
          child: Row(
            children: const [
              Icon(
                Icons.thumb_up_alt_outlined,
                color: Colors.white60,
                size: 16,
              ),
              SizedBox(width: 5,),
              Text(
                'Like',
                style: TextStyle(
                  color: Colors.white60,
                ),
              )
            ],
          ),
        ),
        TextButton(
          onPressed: onCommentTap,
          child: Row(
            children: const [
              Icon(
                Icons.comment,
                color: Colors.white60,
                size: 16,
              ),
              SizedBox(width: 5,),
              Text(
                'Comment',
                style: TextStyle(
                  color: Colors.white60,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  ],
);
