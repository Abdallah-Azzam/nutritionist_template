import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_nutristionist_template/constants/firebase_const.dart';

class ReviseDinner extends StatefulWidget {
  final String uid;
  final DateTime day;
  final List<String> addedItems;

  ReviseDinner(this.uid, this.day, this.addedItems);

  @override
  _ReviseDinnerState createState() => _ReviseDinnerState();
}

class _ReviseDinnerState extends State<ReviseDinner> {
  List dinner = [];
  List finalDinner = [];
  updateDataBase() async {
    dinner = widget.addedItems;
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
          .set({'Dinner': finalDinner, 'weekDinner': dinner});
    await userCollection
        .doc(widget.uid)
        .collection('schedule')
        .doc(DateFormat("dd-MM").format(widget.day))
        .update({'Dinner': finalDinner, 'weekDinner': dinner}).whenComplete(
            () => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Items Added'))));
  }

  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    // for (int i = 0; i < widget.addedItems.length; i++)
    //   for (int j = 0; j < i; j++)
    //     if (widget.addedItems[j] == widget.addedItems[i]) {
    //       setState(() {
    //         quantity++;
    //         widget.addedItems.removeAt(i);
    //       });
    //     }
    // final itemProvider = Provider.of<Item>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < widget.addedItems.length; i++)
                Row(
                  children: [
                    Text(widget.addedItems[i]),
                    InkWell(
                      child: Icon(Icons.remove),
                      onTap: () {
                        setState(() {
                          widget.addedItems.removeAt(i);
                        });
                      },
                    )
                  ],
                ),
              InkWell(
                onTap: () {
                  updateDataBase();
                },
                child: Icon(Icons.done),
              )
            ],
          ),
        ),
      ),
    );
  }
}
