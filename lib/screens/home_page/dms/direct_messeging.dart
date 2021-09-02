import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_nutristionist_template/constants/firebase_const.dart';

import 'messaging.dart';

class DirectMessaging extends StatefulWidget {
  const DirectMessaging({Key? key}) : super(key: key);

  @override
  _DirectMessagingState createState() => _DirectMessagingState();
}

class _DirectMessagingState extends State<DirectMessaging> {
  late String uid;
  bool loading = true;
  getUserInfo() {
    var fireBaseUser = FirebaseAuth.instance.currentUser!;
    setState(() {
      uid = fireBaseUser.uid;
    });
    loading = false;
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: StreamBuilder<QuerySnapshot>(
                  stream: nutristionistCollection
                      .doc(uid)
                      .collection('followers')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot friends = snapshot.data!.docs[index];
                        return Column(children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 6),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 1,
                                            color: Theme.of(context)
                                                .backgroundColor)),
                                    child: Row(children: [
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: CircleAvatar(
                                                          radius: 18,
                                                          foregroundImage:
                                                              NetworkImage(friends[
                                                                  'profilePic']),
                                                        ),
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                      ),
                                                      Text(
                                                        friends['username'],
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
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Messaging(friends[
                                                                    'userId'])));
                                                  },
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ])
                        ]);
                      },
                    );
                  },
                ),
              ),
            ),
          );
  }
}
