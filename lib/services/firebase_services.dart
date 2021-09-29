import 'package:flutter_comment_package/models/post.dart';
import 'package:flutter_comment_package/models/reply_commet.dart';
import 'package:flutter_comment_package/models/root_comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_comment_package/models/user.dart';

Future<void> addPost(String post, String uID, String userName, String avatarUrl) async {
  try {
    await  FirebaseFirestore.instance
        .collection('posts')
        .add({
      'timeCreated': Timestamp.now(),
      'content': post,
      'userID': uID,
      'userName': userName,
      'avatarUrl': avatarUrl,
    });
  } catch(e) {
    print(e);
  }
}

Future<void> addRootComment(String comment, String postID, PostUser user) async {
  try {
    await  FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('root_comments')
        .add({
      'timeCreated': Timestamp.now(),
      'comment': comment,
      'userID': user.userID,
      'userName': user.userName,
      'avatarUrl': user.avatarUrl,
    });
  } catch(e) {
    print(e);
  }
}

Future<void> addReplyComment(String comment, String postID, String rootID, PostUser user) async {
  try {
    await  FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('root_comments')
        .doc(rootID)
        .collection('reply_comments')
        .add({
      'timeCreated': Timestamp.now(),
      'comment': comment,
      'userID': user.userID,
      'userName': user.userName,
      'avatarUrl': user.avatarUrl,
    });
  } catch(e) {
    print(e);
  }
}

Stream <List<Post>> postStream(){
  final snapshot = FirebaseFirestore.instance.collection('posts')
      .orderBy('timeCreated', descending: true)
      .snapshots();
  return snapshot.map((qShot) => qShot.docs.map(
          (doc) => Post.fromDocumentSnapshot(doc)).toList()
  );
}


Stream <List<RootComment>> commentStream(String postID){
  final snapshot = FirebaseFirestore.instance.collection('posts')
      .doc(postID)
      .collection('root_comments')
      .orderBy('timeCreated', descending: true)
      .snapshots();
  return snapshot.map((qShot) => qShot.docs.map(
          (doc) => RootComment.fromDocumentSnapshot(doc, postID)).toList()
  );
}

Stream <List<ReplyComment>> replyStream(String postID, String rootID){
  final snapshot = FirebaseFirestore.instance.collection('posts')
      .doc(postID)
      .collection('root_comments')
      .doc(rootID)
      .collection('reply_comments')
      .orderBy('timeCreated', descending: true)
      .snapshots();
  return snapshot.map((qShot) => qShot.docs.map(
          (doc) => ReplyComment.fromDocumentSnapshot(doc)).toList()
  );
}