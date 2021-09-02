import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_nutristionist_template/constants/firebase_const.dart';
import 'package:new_nutristionist_template/screens/subscribers/view_subscriber_info.dart';

class ViewSubscribers extends StatefulWidget {
  const ViewSubscribers({Key? key}) : super(key: key);

  @override
  _ViewSubscribersState createState() => _ViewSubscribersState();
}

class _ViewSubscribersState extends State<ViewSubscribers> {
  late Stream<QuerySnapshot> subscribersStream;
  late String onlineUserUid;
  bool loading = true;
  getCurrentUser() async {
    var fireBaseUser = FirebaseAuth.instance.currentUser!;

    onlineUserUid = fireBaseUser.uid;
  }

  String? userName;
  getInfo(uid) async {
    setState(() {
      userName = userDoc?['username'];
    });
  }

  DocumentSnapshot? userDoc;
  late Stream<QuerySnapshot> userStream;
  getStream() {
    subscribersStream = nutristionistCollection
        .doc(onlineUserUid)
        .collection('subscribers')
        .snapshots();

    loading = false;
    userStream = userCollection
        .where(subscribersStream.toString(), isEqualTo: onlineUserUid)
        .snapshots();
  }

  @override
  void initState() {
    getCurrentUser();
    getStream();
    getInfo(onlineUserUid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: Container(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: AppBar(
              title: Text('Subscribers'),
              leading: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.transparent,
                  )),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: StreamBuilder<QuerySnapshot>(
                  stream: subscribersStream,
                  builder: (BuildContext context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot subDoc = snapshot.data!.docs[index];

                          return Column(children: [
                            Divider(
                              color: Colors.transparent,
                            ),
                            Container(
                                child: Row(
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
                                                              NetworkImage(subDoc[
                                                                  'profilePic']),
                                                        ),
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                      ),
                                                      Text(
                                                        subDoc['username'],
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
                                                                ViewSubscriberInfo(
                                                                    subDoc[
                                                                        'userId'])));
                                                  },
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ],
                            )),
                          ]);
                        });
                  },
                ),
              ),
            ),
          );
  }
}
