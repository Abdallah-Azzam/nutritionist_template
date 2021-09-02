import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_nutristionist_template/constants/firebase_const.dart';
import '../feeds/addPost.dart';
import '../feeds/comments.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int i = 0;

  String? newComment;

  postLiked(String documentId) async {
    var fireBaseUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot document =
        await nutritionistPublicPost.doc(documentId).get();
    if (document['likes'].contains(fireBaseUser.uid)) {
      nutritionistPublicPost.doc(documentId).update({
        'likes': FieldValue.arrayRemove([fireBaseUser.uid]),
      });
    } else {
      nutritionistPublicPost.doc(documentId).update({
        'likes': FieldValue.arrayUnion([fireBaseUser.uid]),
      });
    }
  }

  userPostLiked(String documentId) async {
    var fireBaseUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot document = await userPost.doc(documentId).get();
    if (document['likes'].contains(fireBaseUser.uid)) {
      userPost.doc(documentId).update({
        'likes': FieldValue.arrayRemove([fireBaseUser.uid]),
      });
    } else {
      userPost.doc(documentId).update({
        'likes': FieldValue.arrayUnion([fireBaseUser.uid]),
      });
    }
  }

  String? newPost;

  int? commentPages;

  String? uid;
  @override
  void initState() {
    getCurrentUserUID();

    super.initState();
  }

  getCurrentUserUID() async {
    var fireBaseUser = FirebaseAuth.instance.currentUser!;

    setState(() {
      uid = fireBaseUser.uid;
    });
  }

  int view = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FloatingActionButton(
              heroTag: '7',
              child: Icon(
                Icons.add,
                color: Colors.green,
              ),
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              focusElevation: 5,
              onPressed: () {
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddPost();
                  }));
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  child: Container(
                    color: view == 1 ? Colors.blue : Colors.white,
                    child: Text('Nutritionist'),
                  ),
                  onTap: () {
                    setState(() {
                      view = 1;
                    });
                  },
                ),
                InkWell(
                  child: Container(
                    color: view == 2 ? Colors.blue : Colors.white,
                    child: Text('Public'),
                  ),
                  onTap: () {
                    setState(() {
                      view = 2;
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: view == 1
                  ? StreamBuilder<QuerySnapshot>(
                      stream: nutritionistPublicPost
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: Container(
                                  child: CircularProgressIndicator()));
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot postDoc =
                                snapshot.data!.docs[index];
                            return Column(
                              children: [
                                Divider(
                                  color: Colors.transparent,
                                ),
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Theme.of(context)
                                                      .backgroundColor)),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: CircleAvatar(
                                                              radius: 18,
                                                              foregroundImage:
                                                                  NetworkImage(
                                                                      postDoc[
                                                                          'profilePic']),
                                                            ),
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(10),
                                                          ),
                                                          Text(
                                                            postDoc['username'],
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .textSelectionTheme
                                                                    .selectionColor),
                                                          ),
                                                        ],
                                                      ),
                                                      if (postDoc['type'] == 1)
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Divider(
                                                              color: Theme.of(
                                                                      context)
                                                                  .dividerColor,
                                                              thickness: 1,
                                                            ),
                                                            Text(
                                                              postDoc['post'],
                                                              maxLines: null,
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .textSelectionTheme
                                                                      .selectionColor),
                                                            ),
                                                          ],
                                                        ),
                                                      if (postDoc['type'] == 2)
                                                        Column(
                                                          children: [
                                                            Divider(
                                                              thickness: 1,
                                                              color: Theme.of(
                                                                      context)
                                                                  .dividerColor,
                                                            ),
                                                            Image(
                                                              image: NetworkImage(
                                                                  postDoc[
                                                                      'image']),
                                                            ),
                                                          ],
                                                        ),
                                                      Divider(
                                                        thickness: 1,
                                                        color: Theme.of(context)
                                                            .dividerColor,
                                                      ),
                                                      if (postDoc['type'] == 3)
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Image(
                                                              image: NetworkImage(
                                                                  postDoc[
                                                                      'image']),
                                                            ),
                                                            Divider(
                                                              thickness: 1,
                                                              color: Theme.of(
                                                                      context)
                                                                  .dividerColor,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    '${postDoc['username']}:'),
                                                                SizedBox(
                                                                  width: 12,
                                                                ),
                                                                Text(
                                                                  postDoc[
                                                                      'post'],
                                                                  maxLines:
                                                                      null,
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(
                                                              thickness: 1,
                                                              color: Theme.of(
                                                                      context)
                                                                  .dividerColor,
                                                            ),
                                                          ],
                                                        ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  postLiked(
                                                                      postDoc[
                                                                          'id']);
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                        postDoc['likes'].contains(uid)
                                                                            ? Icons
                                                                                .thumb_up
                                                                            : Icons
                                                                                .thumb_up_off_alt,
                                                                        color: postDoc['likes'].contains(uid)
                                                                            ? Colors.blue
                                                                            : Colors.grey),
                                                                    Text(
                                                                        'Likes(${postDoc['likes'].length.toString()})'),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons.textsms,
                                                                  color: Colors
                                                                      .grey),
                                                              GestureDetector(
                                                                child: Text(
                                                                    'Comment(${postDoc['commentCount'].toString()})',
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .textSelectionTheme
                                                                            .selectionColor)),
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder:
                                                                              (context) {
                                                                    return Comments(
                                                                        postDoc[
                                                                            'id'],
                                                                        true,
                                                                        false);
                                                                  }));
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      top: 8,
                                                      left: 8,
                                                      right: 8),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(bottom: 35),
                                ),
                              ],
                            );
                          },
                        );
                      })
                  : StreamBuilder<QuerySnapshot>(
                      stream: userPost
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: Container(
                                  child: CircularProgressIndicator()));
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot postDoc =
                                snapshot.data!.docs[index];
                            return Column(
                              children: [
                                Divider(
                                  color: Colors.transparent,
                                ),
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Theme.of(context)
                                                      .backgroundColor)),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: CircleAvatar(
                                                              radius: 18,
                                                              foregroundImage:
                                                                  NetworkImage(
                                                                      postDoc[
                                                                          'profilePic']),
                                                            ),
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(10),
                                                          ),
                                                          Text(
                                                            postDoc['username'],
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .textSelectionTheme
                                                                    .selectionColor),
                                                          ),
                                                        ],
                                                      ),
                                                      if (postDoc['type'] == 1)
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Divider(
                                                              color: Theme.of(
                                                                      context)
                                                                  .dividerColor,
                                                              thickness: 1,
                                                            ),
                                                            Text(
                                                              postDoc['post'],
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .textSelectionTheme
                                                                      .selectionColor),
                                                            ),
                                                          ],
                                                        ),
                                                      if (postDoc['type'] == 2)
                                                        Column(
                                                          children: [
                                                            Divider(
                                                              thickness: 1,
                                                              color: Theme.of(
                                                                      context)
                                                                  .dividerColor,
                                                            ),
                                                            Image(
                                                              image: NetworkImage(
                                                                  postDoc[
                                                                      'image']),
                                                            ),
                                                          ],
                                                        ),
                                                      Divider(
                                                        thickness: 1,
                                                        color: Theme.of(context)
                                                            .dividerColor,
                                                      ),
                                                      if (postDoc['type'] == 3)
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Image(
                                                              image: NetworkImage(
                                                                  postDoc[
                                                                      'image']),
                                                            ),
                                                            Divider(
                                                              thickness: 1,
                                                              color: Theme.of(
                                                                      context)
                                                                  .dividerColor,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    '${postDoc['username']}:'),
                                                                SizedBox(
                                                                  width: 12,
                                                                ),
                                                                Text(postDoc[
                                                                    'post']),
                                                              ],
                                                            ),
                                                            Divider(
                                                              thickness: 1,
                                                              color: Theme.of(
                                                                      context)
                                                                  .dividerColor,
                                                            ),
                                                          ],
                                                        ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  userPostLiked(
                                                                      postDoc[
                                                                          'id']);
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                        postDoc['likes'].contains(uid)
                                                                            ? Icons
                                                                                .thumb_up
                                                                            : Icons
                                                                                .thumb_up_off_alt,
                                                                        color: postDoc['likes'].contains(uid)
                                                                            ? Colors.blue
                                                                            : Colors.grey),
                                                                    Text(
                                                                        'Likes(${postDoc['likes'].length.toString()})'),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons.textsms,
                                                                  color: Colors
                                                                      .grey),
                                                              GestureDetector(
                                                                child: Text(
                                                                    'Comment(${postDoc['commentCount'].toString()})',
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .textSelectionTheme
                                                                            .selectionColor)),
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder:
                                                                              (context) {
                                                                    return Comments(
                                                                        postDoc[
                                                                            'id'],
                                                                        false,
                                                                        true);
                                                                  }));
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      top: 8,
                                                      left: 8,
                                                      right: 8),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(bottom: 35),
                                ),
                              ],
                            );
                          },
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
