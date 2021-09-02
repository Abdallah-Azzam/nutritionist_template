import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_nutristionist_template/constants/firebase_const.dart';
import 'package:new_nutristionist_template/models/nutrition_items/breakfast_items.dart';
import 'package:new_nutristionist_template/models/nutrition_items/dinner_items.dart';
import 'package:new_nutristionist_template/models/nutrition_items/lunch_items.dart';
import 'package:new_nutristionist_template/provider/nutrition_provider/breakfast.dart';
import 'package:new_nutristionist_template/provider/nutrition_provider/dinner.dart';
import 'package:new_nutristionist_template/provider/nutrition_provider/lunch.dart';
import 'package:new_nutristionist_template/widgets/nutrition_products/breakfast_product.dart';
import 'package:new_nutristionist_template/widgets/nutrition_products/dinner_product.dart';
import 'package:new_nutristionist_template/widgets/nutrition_products/lunch_product.dart';
import 'package:provider/provider.dart';

class CustomizeDay extends StatefulWidget {
  final DateTime day;
  final String uid;
  CustomizeDay(this.day, this.uid);

  @override
  _CustomizeDayState createState() => _CustomizeDayState();
}

class _CustomizeDayState extends State<CustomizeDay> {
  int view = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: Row(
        children: [],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 4,
                      child: InkWell(
                        child: Container(
                            decoration: BoxDecoration(
                                color: view == 1
                                    ? Color.fromRGBO(146, 168, 189, 0.3)
                                    : Colors.white),
                            child: Center(
                                child: Text(
                              'Breakfast',
                              style: TextStyle(
                                  fontFamily: 'Tajwal',
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(36, 51, 72, 1)),
                            ))),
                        onTap: () {
                          setState(() {
                            view = 1;
                          });
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 4,
                      child: InkWell(
                        child: Container(
                            decoration: BoxDecoration(
                                color: view == 2
                                    ? Color.fromRGBO(146, 168, 189, 0.3)
                                    : Colors.white),
                            child: Center(
                                child: Text(
                              'Lunch',
                              style: TextStyle(
                                  fontFamily: 'Tajwal',
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(36, 51, 72, 1)),
                            ))),
                        onTap: () {
                          setState(() {
                            view = 2;
                          });
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 4,
                      child: InkWell(
                        child: Container(
                            decoration: BoxDecoration(
                                color: view == 3
                                    ? Color.fromRGBO(146, 168, 189, 0.3)
                                    : Colors.white),
                            child: Center(
                                child: Text(
                              'Dinner',
                              style: TextStyle(
                                  fontFamily: 'Tajwal',
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(36, 51, 72, 1)),
                            ))),
                        onTap: () {
                          setState(() {
                            view = 3;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              view == 1
                  ? Container(child: BreakFastView(widget.day, widget.uid))
                  : view == 2
                      ? LunchView(widget.day, widget.uid)
                      : DinnerView(widget.day, widget.uid)
            ],
          ),
        ),
      ),
    );
  }
}

class BreakFastView extends StatefulWidget {
  final DateTime day;
  final String uid;
  BreakFastView(this.day, this.uid);

  @override
  _BreakFastViewState createState() => _BreakFastViewState();
}

class _BreakFastViewState extends State<BreakFastView> {
  List checkItems = [];
  List finalCheck = [];
  List breakFast = [];
  List finalBreakfast = [];
  List weekBreakfast = [];
  updateDataBase() async {
    breakFast = BreakFastProducts.addedItems;

    List compare = List.of(breakFast);
    compare.sort();
    print(compare);
    //for (int i = 0; i < compare.length; i++) {
    int i = 1;
    while (compare.length > 0) {
      String g = compare[0];
      compare.removeAt(0);
      // while (compare.contains(g) && finalBreakfast.contains(g)) {
      //   compare.remove(g);
      //   print('[]$compare');
      // }
      if (!compare.contains(g) && !finalBreakfast.contains(g)) {
        print(finalBreakfast);
        compare.remove(g);

        finalBreakfast.add('$g x$i');
        i = 1;
      } else {
        i++;
      }
    }
    // doneBreakfast = List.from(userDoc['DoneBreakfast']);
    DocumentSnapshot check = await userCollection
        .doc(widget.uid)
        .collection('schedule')
        .doc(DateFormat("dd-MM").format(widget.day))
        .get();
    if (!check.exists)
      userCollection
          .doc(widget.uid)
          .collection('schedule')
          .doc(DateFormat("dd-MM").format(widget.day))
          .set({
        'Breakfast': finalBreakfast,
        'weekBreakfast': breakFast
      }).whenComplete(() => BreakFastProducts.addedItems
              .removeRange(0, BreakFastProducts.addedItems.length));
    await userCollection
        .doc(widget.uid)
        .collection('schedule')
        .doc(DateFormat("dd-MM").format(widget.day))
        .update({'Breakfast': finalBreakfast, 'weekBreakfast': breakFast})
        .whenComplete(() => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Items Added'))))
        .whenComplete(() => BreakFastProducts.addedItems
            .removeRange(0, BreakFastProducts.addedItems.length));
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<Breakfast>(context);
    List<ItemBreakfast> itemList = itemProvider.item;
    return
        // Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Theme.of(context).primaryColor,
        //   actions: [
        //     InkWell(
        //       onTap: () => Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => ReviseBreakFast(widget.uid,
        //                   widget.day, BreakFastProducts.addedItems))),
        //       child: Row(
        //         children: [
        //           Icon(Icons.add_shopping_cart),
        //           Text(BreakFastProducts.addedItems.length.toString())
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        // body:
        Container(
      padding: const EdgeInsets.only(bottom: 43),
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: itemList.length,
              itemBuilder: (BuildContext context, int index) =>
                  ChangeNotifierProvider.value(
                value: itemList[index],
                child: Column(
                  children: [
                    BreakFastProducts(widget.uid, widget.day),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  color: finalCheck.isNotEmpty ? Colors.black : Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 50,
                child: Row(
                  children: [
                    for (String i in finalCheck)
                      Row(
                        children: [
                          Text(
                            i,
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 3,
                          margin: const EdgeInsets.only(bottom: 3),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(141, 30, 23, 1),
                              Color.fromRGBO(141, 30, 23, 0.3)
                            ]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Text(
                            'Submit items',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700),
                          ))),
                      onTap: () {
                        updateDataBase();
                        setState(() {});
                      },
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (checkItems.isNotEmpty) checkItems.clear();
                          if (finalCheck.isNotEmpty) finalCheck.clear();

                          checkItems.addAll(BreakFastProducts.addedItems);
                          checkItems.sort();
                          List compare = List.of(checkItems);
                          compare.sort();
                          print(compare);
                          //for (int i = 0; i < compare.length; i++) {
                          int i = 1;
                          while (compare.length > 0) {
                            String g = compare[0];
                            compare.removeAt(0);
                            checkItems.removeAt(0);
                            // while (compare.contains(g) && finalBreakfast.contains(g)) {
                            //   compare.remove(g);
                            //   print('[]$compare');
                            // }
                            if (!compare.contains(g) &&
                                !finalCheck.contains(g)) {
                              print(finalCheck);
                              compare.remove(g);
                              checkItems.remove(g);
                              finalCheck.add('$g x$i');
                              i = 1;
                            } else {
                              i++;
                            }
                          }
                          finalCheck.sort();
                        });
                      },
                      child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 3,
                          margin: const EdgeInsets.only(bottom: 3),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(141, 30, 23, 1),
                              Color.fromRGBO(141, 30, 23, 0.3)
                            ]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Text(
                            'check items',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700),
                          ))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
    // );
  }
}

class LunchView extends StatefulWidget {
  final DateTime day;
  final String uid;
  LunchView(this.day, this.uid);
  @override
  _LunchViewState createState() => _LunchViewState();
}

class _LunchViewState extends State<LunchView> {
  List finalCheck = [];
  List checkItems = [];
  List lunch = [];
  List finalLunch = [];
  updateDataBase() async {
    lunch = LunchProducts.addedItems;
    List compare = List.of(lunch);
    compare.sort();
    print(compare);
    //for (int i = 0; i < compare.length; i++) {
    int i = 1;
    while (compare.length > 0) {
      String g = compare[0];
      compare.removeAt(0);
      // while (compare.contains(g) && finalBreakfast.contains(g)) {
      //   compare.remove(g);
      //   print('[]$compare');
      // }
      if (!compare.contains(g) && !finalLunch.contains(g)) {
        print(finalLunch);
        compare.remove(g);

        finalLunch.add('$g x$i');
        i = 1;
      } else {
        i++;
      }
    }
    // doneBreakfast = List.from(userDoc['DoneBreakfast']);

    DocumentSnapshot check = await userCollection
        .doc(widget.uid)
        .collection('schedule')
        .doc(DateFormat("dd-MM").format(widget.day))
        .get();
    if (!check.exists)
      userCollection
          .doc(widget.uid)
          .collection('schedule')
          .doc(DateFormat("dd-MM").format(widget.day))
          .set({'Lunch': finalLunch, 'weekLunch': lunch}).whenComplete(() =>
              LunchProducts.addedItems
                  .removeRange(0, LunchProducts.addedItems.length));
    await userCollection
        .doc(widget.uid)
        .collection('schedule')
        .doc(DateFormat("dd-MM").format(widget.day))
        .update({'Lunch': finalLunch, 'weekLunch': lunch})
        .whenComplete(() => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Items Added'))))
        .whenComplete(() => LunchProducts.addedItems
            .removeRange(0, LunchProducts.addedItems.length));
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<Lunch>(context);
    List<ItemLunch> itemList = itemProvider.item;
    return
        // Scaffold(
        //   appBar: AppBar(
        //     backgroundColor: Theme.of(context).primaryColor,
        //     actions: [
        //       InkWell(
        //         onTap: () => Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => ReviseLunch(
        //                     widget.uid, widget.day, LunchProducts.addedItems))),
        //         child: Row(
        //           children: [
        //             Icon(Icons.add_shopping_cart),
        //             Text(LunchProducts.addedItems.length.toString())
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        //   body:
        Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(bottom: 45),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: itemList.length,
              itemBuilder: (BuildContext context, int index) =>
                  ChangeNotifierProvider.value(
                value: itemList[index],
                child: Column(
                  children: [
                    LunchProducts(widget.uid, widget.day),
                    SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  color: finalCheck.isNotEmpty ? Colors.black : Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 50,
                child: Row(
                  children: [
                    for (String i in finalCheck)
                      Row(
                        children: [
                          Text(
                            i,
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 3,
                          margin: const EdgeInsets.only(bottom: 3),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(141, 30, 23, 1),
                              Color.fromRGBO(141, 30, 23, 0.3)
                            ]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Text(
                            'Submit items',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700),
                          ))),
                      onTap: () {
                        updateDataBase();
                        setState(() {});
                      },
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (checkItems.isNotEmpty) checkItems.clear();
                          if (finalCheck.isNotEmpty) finalCheck.clear();

                          checkItems.addAll(LunchProducts.addedItems);
                          checkItems.sort();
                          List compare = List.of(checkItems);
                          compare.sort();
                          print(compare);
                          //for (int i = 0; i < compare.length; i++) {
                          int i = 1;
                          while (compare.length > 0) {
                            String g = compare[0];
                            compare.removeAt(0);
                            checkItems.removeAt(0);
                            // while (compare.contains(g) && finalBreakfast.contains(g)) {
                            //   compare.remove(g);
                            //   print('[]$compare');
                            // }
                            if (!compare.contains(g) &&
                                !finalCheck.contains(g)) {
                              print(finalCheck);
                              compare.remove(g);
                              checkItems.remove(g);
                              finalCheck.add('$g x$i');
                              i = 1;
                            } else {
                              i++;
                            }
                          }
                          finalCheck.sort();
                        });
                      },
                      child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 3,
                          margin: const EdgeInsets.only(bottom: 3),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(141, 30, 23, 1),
                              Color.fromRGBO(141, 30, 23, 0.3)
                            ]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Text(
                            'check items',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700),
                          ))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
    // );
  }
}

class DinnerView extends StatefulWidget {
  final DateTime day;
  final String uid;
  DinnerView(this.day, this.uid);
  @override
  _DinnerViewState createState() => _DinnerViewState();
}

class _DinnerViewState extends State<DinnerView> {
  List finalCheck = [];
  List checkItems = [];
  List dinner = [];
  List finalDinner = [];
  updateDataBase() async {
    dinner = DinnerProducts.addedItems;
    List compare = List.of(dinner);
    compare.sort();
    print(compare);
    //for (int i = 0; i < compare.length; i++) {
    int i = 1;
    while (compare.length > 0) {
      String g = compare[0];
      compare.removeAt(0);
      // while (compare.contains(g) && finalBreakfast.contains(g)) {
      //   compare.remove(g);
      //   print('[]$compare');
      // }
      if (!compare.contains(g) && !finalDinner.contains(g)) {
        print(finalDinner);
        compare.remove(g);

        finalDinner.add('$g x$i');
        i = 1;
      } else {
        i++;
      }
    }
    // doneBreakfast = List.from(userDoc['DoneBreakfast']);

    DocumentSnapshot check = await userCollection
        .doc(widget.uid)
        .collection('schedule')
        .doc(DateFormat("dd-MM").format(widget.day))
        .get();
    if (!check.exists)
      userCollection
          .doc(widget.uid)
          .collection('schedule')
          .doc(DateFormat("dd-MM").format(widget.day))
          .set({'Dinner': finalDinner, 'weekDinner': dinner}).whenComplete(
              () => DinnerProducts.addedItems.clear());
    await userCollection
        .doc(widget.uid)
        .collection('schedule')
        .doc(DateFormat("dd-MM").format(widget.day))
        .update({'Dinner': finalDinner, 'weekDinner': dinner})
        .whenComplete(() => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Items Added'))))
        .whenComplete(() => DinnerProducts.addedItems.clear());
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<Dinner>(context);
    List<ItemDinner> itemList = itemProvider.item;

    return
        // Scaffold(
        //   appBar: AppBar(
        //     backgroundColor: Theme.of(context).primaryColor,
        //     actions: [
        //       InkWell(
        //         onTap: () => Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => ReviseDinner(
        //                     widget.uid, widget.day, DinnerProducts.addedItems))),
        //         child: Row(
        //           children: [
        //             Icon(Icons.add_shopping_cart),
        //             Text(DinnerProducts.addedItems.length.toString())
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        //   body:
        Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(bottom: 45),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: itemList.length,
              itemBuilder: (BuildContext context, int index) =>
                  ChangeNotifierProvider.value(
                value: itemList[index],
                child: Column(
                  children: [
                    DinnerProducts(widget.uid, widget.day),
                    SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  color: finalCheck.isNotEmpty ? Colors.black : Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 50,
                child: Row(
                  children: [
                    for (String i in finalCheck)
                      Row(
                        children: [
                          Text(
                            i,
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 3,
                          margin: const EdgeInsets.only(bottom: 3),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(141, 30, 23, 1),
                              Color.fromRGBO(141, 30, 23, 0.3)
                            ]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Text(
                            'Submit items',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700),
                          ))),
                      onTap: () {
                        updateDataBase();
                        setState(() {});
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ReviseDinner(widget.uid,
                        //             widget.day, DinnerProducts.addedItems)));
                      },
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (checkItems.isNotEmpty) checkItems.clear();
                          if (finalCheck.isNotEmpty) finalCheck.clear();

                          checkItems.addAll(DinnerProducts.addedItems);
                          checkItems.sort();
                          List compare = List.of(checkItems);
                          compare.sort();
                          print(compare);
                          //for (int i = 0; i < compare.length; i++) {
                          int i = 1;
                          while (compare.length > 0) {
                            String g = compare[0];
                            compare.removeAt(0);
                            checkItems.removeAt(0);
                            // while (compare.contains(g) && finalBreakfast.contains(g)) {
                            //   compare.remove(g);
                            //   print('[]$compare');
                            // }
                            if (!compare.contains(g) &&
                                !finalCheck.contains(g)) {
                              print(finalCheck);
                              compare.remove(g);
                              checkItems.remove(g);
                              finalCheck.add('$g x$i');
                              i = 1;
                            } else {
                              i++;
                            }
                          }
                          finalCheck.sort();
                        });
                      },
                      child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 3,
                          margin: const EdgeInsets.only(bottom: 3),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(141, 30, 23, 1),
                              Color.fromRGBO(141, 30, 23, 0.3)
                            ]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Text(
                            'check items',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700),
                          ))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
    // );
  }
}
