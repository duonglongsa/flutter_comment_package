import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  late String content;
  late String contentId;
  late Timestamp timeCreated;
  late String userName;
  late String avatarUrl;
  late String userID;

  Post(this.content, this.contentId, this.timeCreated, this.userName, this.avatarUrl);


  Post.fromDocumentSnapshot(
      QueryDocumentSnapshot snapshot,
      ) {
    contentId = snapshot.id;
    content = snapshot.get('content');
    timeCreated = snapshot.get("timeCreated");
    userID = snapshot.get('userID');
    avatarUrl = snapshot.get('avatarUrl');
    userName = snapshot.get('userName');

  }

}

