import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_nutristionist_template/constants/firebase_const.dart';
import 'package:new_nutristionist_template/screens/feeds/comments.dart';
import 'package:new_nutristionist_template/screens/user/user_settings.dart';

class UserScreen extends StatefulWidget {
  static bool view = false;
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  //used later on to only show the user posts
  late Stream<QuerySnapshot> userStream;

  //saves the firebase user id to be used later
  late Stream<QuerySnapshot> userPublicStream;
  String? uid;
  getCurrentUser() {
    var fireBaseUser = FirebaseAuth.instance.currentUser!;
    setState(() {
      uid = fireBaseUser.uid;
    });
  }

  late String degree;
  late String school;
  late String expertise;
  late String experience;
  late String certification;
  int view = 1;
//to switch between the circular progress indicator and the stream of posts
  bool loading = true;
  bool? isFollowing;
  //saves the users information located in the database in variables, then sets loading to false
  String? username;
  String? profilePic;
  getUserInfo() async {
    var fireBaseUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot userDoc =
        await nutristionistCollection.doc(fireBaseUser.uid).get();
    var followersCount = await nutristionistCollection
        .doc(fireBaseUser.uid)
        .collection('followers')
        .get();
    var subscribersCount = await nutristionistCollection
        .doc(fireBaseUser.uid)
        .collection('subscribers')
        .get();
    var followingCount = await nutristionistCollection
        .doc(fireBaseUser.uid)
        .collection('following')
        .get();
    nutristionistCollection
        .doc(fireBaseUser.uid)
        .collection('followers')
        .doc(fireBaseUser.uid)
        .get()
        .then((document) => {
              if (document.exists)
                {
                  setState(() {
                    isFollowing = true;
                  })
                }
              else
                {
                  setState(() {
                    isFollowing = false;
                  })
                }
            });
    setState(() {
      username = userDoc['username'];
      following = followingCount.docs.length;
      followers = followersCount.docs.length;
      profilePic = userDoc['profilePic'];
      subscribers = subscribersCount.docs.length;
      degree = userDoc['degree'];
      school = userDoc['school'];
      certification = userDoc['other certification'];
      expertise = userDoc['area of expertise'];
      experience = userDoc['years of experience'];
      loading = false;
    });
  }

  postLiked(String documentId) async {
    var fireBaseUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot document =
        await nutritionistPostCollection.doc(documentId).get();
    if (document['likes'].contains(fireBaseUser.uid)) {
      nutritionistPostCollection.doc(documentId).update({
        'likes': FieldValue.arrayRemove([fireBaseUser.uid]),
      });
    } else {
      nutritionistPostCollection.doc(documentId).update({
        'likes': FieldValue.arrayUnion([fireBaseUser.uid]),
      });
    }
  }

  publicPostLiked(String documentId) async {
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

//gets the userStream and saves it in a stream variable
  getStream() {
    var fireBaseUser = FirebaseAuth.instance.currentUser!;
    setState(() {
      userStream = nutritionistPostCollection
          .where('uid', isEqualTo: fireBaseUser.uid)
          .snapshots();

      userPublicStream = nutritionistPublicPost
          .where('uid', isEqualTo: fireBaseUser.uid)
          .snapshots();
    });
  }

  late int subscribers;
  late int following;
  late int followers;
  @override
  void initState() {
    getUserInfo();
    getCurrentUser();
    getStream();
    super.initState();
  }

  //used for sliverAppBar colors on change
  var top = 0.0;
  @override
  Widget build(BuildContext context) {
    // if loading is true it displays a circularProgressIndicator, otherwise it shows the user profile
    return !loading
        ? SafeArea(
            child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  flexibleSpace: StreamBuilder<QuerySnapshot>(
                    stream: nutristionistCollection.snapshots(),
                    builder: (context, snapshot) {
                      return LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          top = constraints.biggest.height;
                          return Container(
                            child: FlexibleSpaceBar(
                              collapseMode: CollapseMode.parallax,
                              centerTitle: true,
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AnimatedOpacity(
                                    opacity: top <= 110 ? 1 : 0,
                                    duration: Duration(milliseconds: 300),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: kToolbarHeight / 1.8,
                                          width: kToolbarHeight / 1.8,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.white,
                                                  blurRadius: 1,
                                                ),
                                              ],
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image:
                                                    NetworkImage(profilePic!),
                                              )),
                                        ),
                                        Text(
                                          'username',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              background: Image(
                                image: NetworkImage(profilePic!),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            username!,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Following',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      following.toString(),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Followers',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      followers.toString(),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Subscribers',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(subscribers.toString(),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                            fontSize: 14)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'User Info:',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.school),
                                      Text(
                                        ' Degree: ',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: 'Tajwal'),
                                      ),
                                      Text(
                                        degree,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Tajwal'),
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 0,
                                  color: Colors.white,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.apartment_outlined),
                                    Text(
                                      ' School: ',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'Tajwal'),
                                    ),
                                    Text(
                                      school,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Tajwal'),
                                    )
                                  ],
                                ),
                                Divider(
                                  thickness: 0,
                                  color: Colors.white,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.work_outline),
                                    Text(
                                      ' Years of experience: ',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'Tajwal'),
                                    ),
                                    Text(
                                      experience,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Tajwal'),
                                    )
                                  ],
                                ),
                                Divider(
                                  thickness: 0,
                                  color: Colors.white,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.badge),
                                    Text(
                                      ' Expertise: ',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'Tajwal'),
                                    ),
                                    Text(
                                      expertise,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Tajwal'),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return UserSettings();
                          }));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(141, 30, 23, 1),
                                Color.fromRGBO(141, 30, 23, 0.3),
                              ])),
                          child: Center(
                              child: Text(
                            'Edit Profile',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w700),
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Reviews',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                for (int i = 0; i < 5; i++)
                                  Icon(Icons.star_border)
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'User Posts',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: Container(
                              child: Text('Public Post'),
                            ),
                            onTap: () {
                              setState(() {
                                view = 2;
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Text('Private Post'),
                            ),
                            onTap: () {
                              setState(() {
                                view = 1;
                              });
                            },
                          )
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.only(bottom: 0),
                          child: DottedLine(
                            dashColor: Theme.of(context).dividerColor,
                          )),
                      view == 1
                          ? StreamBuilder<QuerySnapshot>(
                              stream: userStream,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  reverse: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Theme.of(
                                                                  context)
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
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        CircleAvatar(
                                                                      radius:
                                                                          18,
                                                                      foregroundImage:
                                                                          NetworkImage(
                                                                              postDoc['profilePic']),
                                                                    ),
                                                                    margin:
                                                                        const EdgeInsets.all(
                                                                            10),
                                                                  ),
                                                                  Text(
                                                                    postDoc[
                                                                        'username'],
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .textSelectionTheme
                                                                            .selectionColor),
                                                                  ),
                                                                ],
                                                              ),
                                                              if (postDoc[
                                                                      'type'] ==
                                                                  1)
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Divider(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .dividerColor,
                                                                      thickness:
                                                                          1,
                                                                    ),
                                                                    Text(
                                                                      postDoc[
                                                                          'post'],
                                                                      maxLines:
                                                                          null,
                                                                      style: TextStyle(
                                                                          color: Theme.of(context)
                                                                              .textSelectionTheme
                                                                              .selectionColor),
                                                                    ),
                                                                  ],
                                                                ),
                                                              if (postDoc[
                                                                      'type'] ==
                                                                  2)
                                                                Column(
                                                                  children: [
                                                                    Divider(
                                                                      thickness:
                                                                          1,
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
                                                                color: Theme.of(
                                                                        context)
                                                                    .dividerColor,
                                                              ),
                                                              if (postDoc[
                                                                      'type'] ==
                                                                  3)
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
                                                                      thickness:
                                                                          1,
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
                                                                          width:
                                                                              12,
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
                                                                      thickness:
                                                                          1,
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
                                                                        onTap:
                                                                            () {
                                                                          postLiked(
                                                                              postDoc['id']);
                                                                        },
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Icon(postDoc['likes'].contains(uid) ? Icons.thumb_up : Icons.thumb_up_off_alt,
                                                                                color: postDoc['likes'].contains(uid) ? Colors.blue : Colors.grey),
                                                                            Text('Likes(${postDoc['likes'].length.toString()})'),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                          Icons
                                                                              .textsms,
                                                                          color:
                                                                              Colors.grey),
                                                                      GestureDetector(
                                                                        child: Text(
                                                                            'Comment(${postDoc['commentCount'].toString()})',
                                                                            style:
                                                                                TextStyle(color: Theme.of(context).textSelectionTheme.selectionColor)),
                                                                        onTap:
                                                                            () {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) {
                                                                            return Comments(
                                                                                postDoc['id'],
                                                                                false,
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
                                                          padding:
                                                              EdgeInsets.only(
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
                                        ),
                                      ],
                                    );
                                  },
                                );
                              })
                          : StreamBuilder<QuerySnapshot>(
                              stream: userPublicStream,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                }
                                return ListView.builder(
                                  reverse: true,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Theme.of(
                                                                  context)
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
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        CircleAvatar(
                                                                      radius:
                                                                          18,
                                                                      foregroundImage:
                                                                          NetworkImage(
                                                                              postDoc['profilePic']),
                                                                    ),
                                                                    margin:
                                                                        const EdgeInsets.all(
                                                                            10),
                                                                  ),
                                                                  Text(
                                                                    postDoc[
                                                                        'username'],
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .textSelectionTheme
                                                                            .selectionColor),
                                                                  ),
                                                                ],
                                                              ),
                                                              if (postDoc[
                                                                      'type'] ==
                                                                  1)
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Divider(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .dividerColor,
                                                                      thickness:
                                                                          1,
                                                                    ),
                                                                    Text(
                                                                      postDoc[
                                                                          'post'],
                                                                      maxLines:
                                                                          null,
                                                                      style: TextStyle(
                                                                          color: Theme.of(context)
                                                                              .textSelectionTheme
                                                                              .selectionColor),
                                                                    ),
                                                                  ],
                                                                ),
                                                              if (postDoc[
                                                                      'type'] ==
                                                                  2)
                                                                Column(
                                                                  children: [
                                                                    Divider(
                                                                      thickness:
                                                                          1,
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
                                                                color: Theme.of(
                                                                        context)
                                                                    .dividerColor,
                                                              ),
                                                              if (postDoc[
                                                                      'type'] ==
                                                                  3)
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
                                                                      thickness:
                                                                          1,
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
                                                                          width:
                                                                              12,
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
                                                                      thickness:
                                                                          1,
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
                                                                        onTap:
                                                                            () {
                                                                          publicPostLiked(
                                                                              postDoc['id']);
                                                                        },
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Icon(postDoc['likes'].contains(uid) ? Icons.thumb_up : Icons.thumb_up_off_alt,
                                                                                color: postDoc['likes'].contains(uid) ? Colors.blue : Colors.grey),
                                                                            Text('Likes(${postDoc['likes'].length.toString()})'),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                          Icons
                                                                              .textsms,
                                                                          color:
                                                                              Colors.grey),
                                                                      GestureDetector(
                                                                        child: Text(
                                                                            'Comment(${postDoc['commentCount'].toString()})',
                                                                            style:
                                                                                TextStyle(color: Theme.of(context).textSelectionTheme.selectionColor)),
                                                                        onTap:
                                                                            () {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) {
                                                                            return Comments(
                                                                                postDoc['id'],
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
                                                          padding:
                                                              EdgeInsets.only(
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
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }),
                    ],
                  ),
                ),
              ],
            ),
          ))
        : Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
