import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_comment_package/models/reply_commet.dart';
import 'package:get/get.dart';

class RootComment {
  late String postID;
  late String comment;
  late String commentId;
  late Timestamp timeCreated;
  late String userID;
  late String userName;
  late String avatarUrl;
  late Stream<List<ReplyComment>> replyStream;

  final isShowingReply = false.obs;



  final replyList = <ReplyComment>[].obs;
  List<ReplyComment> get replies => replyList.value;


  RootComment(this.comment, this.commentId, this.timeCreated, this.replyStream);

  RootComment.fromDocumentSnapshot(
      QueryDocumentSnapshot snapshot, String pID
      ) {
    commentId = snapshot.id;
    comment = snapshot.get('comment');
    timeCreated = snapshot.get("timeCreated");
    userID = snapshot.get('userID');
    postID = pID;
    avatarUrl = snapshot.get('avatarUrl');
    userName = snapshot.get('userName');
    replyList.bindStream(replyStream);
  }

}

