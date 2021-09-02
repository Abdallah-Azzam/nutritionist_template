import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_nutristionist_template/constants/firebase_const.dart';
import 'package:new_nutristionist_template/screens/subscribers/nutrition_schedule.dart';

class ViewSubscriberInfo extends StatefulWidget {
  final String uid;
  ViewSubscriberInfo(this.uid);

  @override
  _ViewSubscriberInfoState createState() => _ViewSubscriberInfoState();
}

class _ViewSubscriberInfoState extends State<ViewSubscriberInfo> {
  String? name;
  String? allergies;
  String? height;
  String? currentWeight;
  String? targetWeight;
  String? targetBodyType;
  String? foodPref;
  String? healthConcerns;
  bool loading = true;
  getSubscribersInfo() async {
    DocumentSnapshot subDoc = await userCollection.doc(widget.uid).get();
    setState(() {
      name = subDoc['username'];
      allergies = subDoc['allergies'];
      height = subDoc['height'];
      currentWeight = subDoc['currentWeight'];
      targetWeight = subDoc['targetWeight'];
      targetBodyType = subDoc['targetBodyType'];
      foodPref = subDoc['foodPreference'];
      healthConcerns = subDoc['Health'];
    });
    loading = false;
  }

  @override
  void initState() {
    getSubscribersInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: Container(child: CircularProgressIndicator()))
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text('${name!}'),
              // actions: [
              //   InkWell(
              //     child: CircleAvatar(
              //       backgroundColor: Colors.green,
              //       child: Icon(Icons.check),
              //     ),
              //     onTap: () {
              //       showDialog(
              //           context: context,
              //           builder: (context) {
              //             return Center(
              //               child: Container(
              //                 color: Colors.white,
              //                 width: 300,
              //                 height: 300,
              //                 child: Scaffold(
              //                   body: Column(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Text(
              //                           'Press continue if this subscribers nutrition schedule is complete'),
              //                       InkWell(
              //                         child: Container(child: Text('continue')),
              //                         onTap: () {},
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             );
              //           });
              //     },
              //   ),
              // ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        controller: ScrollController(),
                        itemCount: 1,
                        physics: ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                child: Text(
                                  'Basic Info:',
                                  style: TextStyle(
                                      color: Color.fromRGBO(36, 51, 72, 1),
                                      fontFamily: 'Tajwal',
                                      fontSize: 25,
                                      fontWeight: FontWeight.w200),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 14),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.black)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Height:',
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(36, 51, 72, 1),
                                              fontFamily: 'Tajwal',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          'CM ${height.toString()}',
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(36, 51, 72, 1),
                                              fontFamily: 'Tajwal',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        )
                                      ],
                                    ),
                                    Divider(
                                        color: Color.fromRGBO(36, 51, 72, 1),
                                        thickness: 0.6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'currentWeight:',
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(36, 51, 72, 1),
                                              fontFamily: 'Tajwal',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          'KG ${currentWeight!}',
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(36, 51, 72, 1),
                                              fontFamily: 'Tajwal',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        )
                                      ],
                                    ),
                                    Divider(
                                        color: Color.fromRGBO(36, 51, 72, 1),
                                        thickness: 0.6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Target weight:',
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(36, 51, 72, 1),
                                              fontFamily: 'Tajwal',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          'kg ${targetWeight!}',
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(36, 51, 72, 1),
                                              fontFamily: 'Tajwal',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        )
                                      ],
                                    ),
                                    Divider(
                                        color: Color.fromRGBO(36, 51, 72, 1),
                                        thickness: 0.6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Goal: ',
                                          style: TextStyle(
                                              fontFamily: 'Tajwal',
                                              color:
                                                  Color.fromRGBO(36, 51, 72, 1),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          targetBodyType!,
                                          style: TextStyle(
                                              fontFamily: 'Tajwal',
                                              color:
                                                  Color.fromRGBO(36, 51, 72, 1),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 14, right: 14, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Additional info:',
                                      style: TextStyle(
                                          color: Color.fromRGBO(36, 51, 72, 1),
                                          fontFamily: 'Tajwal',
                                          fontSize: 25,
                                          fontWeight: FontWeight.w200),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Allergies: ',
                                        style: TextStyle(
                                            fontFamily: 'Tajwal',
                                            color:
                                                Color.fromRGBO(36, 51, 72, 1),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      ),
                                    ),
                                    Text(
                                      allergies!,
                                      style: TextStyle(
                                          fontFamily: 'Tajwal',
                                          color: Color.fromRGBO(36, 51, 72, 1),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 14.0, right: 14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Food Preference: ',
                                      style: TextStyle(
                                          fontFamily: 'Tajwal',
                                          color: Color.fromRGBO(36, 51, 72, 1),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      foodPref!,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontFamily: 'Tajwal',
                                          color: Color.fromRGBO(36, 51, 72, 1),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 14.0, right: 14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Health concerns: ',
                                      style: TextStyle(
                                          fontFamily: 'Tajwal',
                                          color: Color.fromRGBO(36, 51, 72, 1),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      healthConcerns!,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontFamily: 'Tajwal',
                                          color: Color.fromRGBO(36, 51, 72, 1),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                    // Padding(
                    // padding: const EdgeInsets.all(MediaQuery.of(context)),
                    // child:
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(253, 209, 58, 1),
                                        Color.fromRGBO(253, 209, 58, 0.6),
                                      ])),
                                  child: Center(
                                    child: Text(
                                      'Create schedule',
                                      style: TextStyle(
                                          color: Color.fromRGBO(36, 51, 72, 1),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NutritionSchedule(widget.uid)))),

                          // FloatingActionButton(
                          //     child: Icon(Icons.forward),
                          //     onPressed: () => Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) =>
                          //                 NutritionSchedule(widget.uid)))),
                        ],
                      ),
                    ),
                    // )
                  ],
                ),
              ),
            ),
          );
  }
}
