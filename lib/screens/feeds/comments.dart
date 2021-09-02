import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_nutristionist_template/constants/firebase_const.dart';
import 'dart:core';
import 'package:timeago/timeago.dart' as tAgo;

class Comments extends StatefulWidget {
  final String documentId;
  final bool isPublic;
  final bool isUser;
  Comments(this.documentId, this.isPublic, this.isUser);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  TextEditingController? _commentController;

  addPublicComment() async {
    var fireBaseUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot userDoc =
        await nutristionistCollection.doc(fireBaseUser.uid).get();
    nutritionistPublicPost
        .doc(widget.documentId)
        .collection('comments')
        .doc()
        .set({
      'comment': _commentController!.text,
      'username': userDoc['username'],
      'profilePic': userDoc['profilePic'],
      'time': DateTime.now(),
      'uid': userDoc['uid']
    });
    DocumentSnapshot commentCount =
        await nutritionistPublicPost.doc(widget.documentId).get();

    nutritionistPublicPost.doc(widget.documentId).update({
      'commentCount': commentCount['commentCount'] + 1,
    });
    _commentController!.clear();
  }

  addUserComment() async {
    var fireBaseUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot userDoc =
        await nutristionistCollection.doc(fireBaseUser.uid).get();
    userPost.doc(widget.documentId).collection('comments').doc().set({
      'comment': _commentController!.text,
      'username': userDoc['username'],
      'profilePic': userDoc['profilePic'],
      'time': DateTime.now(),
      'uid': userDoc['uid']
    });
    DocumentSnapshot commentCount = await userPost.doc(widget.documentId).get();

    userPost.doc(widget.documentId).update({
      'commentCount': commentCount['commentCount'] + 1,
    });
    _commentController!.clear();
  }

  addComment() async {
    var fireBaseUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot userDoc =
        await nutristionistCollection.doc(fireBaseUser.uid).get();
    nutritionistPostCollection
        .doc(widget.documentId)
        .collection('comments')
        .doc()
        .set({
      'comment': _commentController!.text,
      'username': userDoc['username'],
      'profilePic': userDoc['profilePic'],
      'time': DateTime.now(),
      'uid': userDoc['uid']
    });
    DocumentSnapshot commentCount =
        await nutritionistPostCollection.doc(widget.documentId).get();

    nutritionistPostCollection.doc(widget.documentId).update({
      'commentCount': commentCount['commentCount'] + 1,
    });
    _commentController!.clear();
  }

  ScrollController? _scrollController;
  @override
  void initState() {
    _commentController = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      bottomSheet: BottomAppBar(
        child: BottomAppBar(
          color: Theme.of(context).primaryColor,
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  style: TextStyle(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor),
                  textAlign: TextAlign.center,
                  controller: _commentController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).backgroundColor,
                            width: 1)),
                    hintText: 'Add Comment',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0,
                heroTag: '',
                onPressed: () {
                  setState(() {
                    if (_commentController != null) {
                      widget.isPublic
                          ? addPublicComment()
                          : widget.isUser
                              ? addUserComment()
                              : addComment();
                    }
                  });
                },
                child: Icon(
                  Icons.arrow_circle_up_outlined,
                  size: 32,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: FloatingActionButton(
            heroTag: '3',
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).iconTheme.color,
            )),
        title: Text(
          'Comments',
          style: TextStyle(
              color: Theme.of(context).textSelectionTheme.selectionColor),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        controller: _scrollController,
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: widget.isPublic
                    ? nutritionistPublicPost
                        .doc(widget.documentId)
                        .collection('comments')
                        .snapshots()
                    : widget.isUser
                        ? userPost
                            .doc(widget.documentId)
                            .collection('comments')
                            .snapshots()
                        : nutritionistPostCollection
                            .doc(widget.documentId)
                            .collection('comments')
                            .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, int index) {
                        DocumentSnapshot nutritionistCommentDoc =
                            snapshot.data!.docs[index];
                        return ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    foregroundImage: NetworkImage(
                                        nutritionistCommentDoc['profilePic']),
                                  ),
                                  Text(nutritionistCommentDoc['username'],
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Indie',
                                      )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        nutritionistCommentDoc['comment'],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Text(tAgo
                                      .format(nutritionistCommentDoc['time']
                                          .toDate())
                                      .toString()),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DottedLine(
                                  dashColor: Theme.of(context).dividerColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }),
            Divider(),
            ListTile(),
          ],
        ),
      ),
    );
  }
}
