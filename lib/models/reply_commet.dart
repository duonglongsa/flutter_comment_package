import 'package:cloud_firestore/cloud_firestore.dart';

class ReplyComment {
  late String comment;
  late String commentId;
  late Timestamp timeCreated;
  late String userID;
  late String userName;
  late String avatarUrl;
  late String rootID;

  ReplyComment (this.comment, this.commentId, this.timeCreated,);

  ReplyComment .fromDocumentSnapshot(
      QueryDocumentSnapshot snapshot,
      ) {
    commentId = snapshot.id;
    comment = snapshot.get('comment');
    timeCreated = snapshot.get("timeCreated");
    userID = snapshot.get('userID');
    rootID = snapshot.get('rootID');
    avatarUrl = snapshot.get('avatarUrl');
    userName = snapshot.get('userName');
  }

}

