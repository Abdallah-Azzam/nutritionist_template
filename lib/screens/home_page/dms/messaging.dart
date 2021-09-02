import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_nutristionist_template/constants/firebase_const.dart';

//TODO: Implement dms

class Messaging extends StatefulWidget {
  final String uid;
  Messaging(this.uid);
  @override
  _MessagingState createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  bool loading = true;
  late String onlineUser;
  late Stream<QuerySnapshot> messageStream;
  getCurrentUser() {
    var fireBaseUser = FirebaseAuth.instance.currentUser!;
    onlineUser = fireBaseUser.uid;
  }

  getStream() {
    var fireBaseUser = FirebaseAuth.instance.currentUser!;
    setState(() {
      messageStream = nutristionistCollection
          .doc(fireBaseUser.uid)
          .collection('followers')
          .doc(widget.uid)
          .collection('messages')
          .snapshots();
    });
    loading = false;
  }

  @override
  void initState() {
    getCurrentUser();
    getStream();
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
                  stream: messageStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [],
                          );
                        });
                  },
                ),
              ),
            ),
          );
  }
}
