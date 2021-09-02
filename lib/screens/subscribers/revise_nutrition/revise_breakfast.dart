// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:new_nutristionist_template/constants/firebase_const.dart';
//
// class ReviseBreakFast extends StatefulWidget {
//   final String uid;
//   final DateTime day;
//   final List<String> addedItems;
//
//   ReviseBreakFast(this.uid, this.day, this.addedItems);
//
//   @override
//   _ReviseBreakFastState createState() => _ReviseBreakFastState();
// }
//
// class _ReviseBreakFastState extends State<ReviseBreakFast> {
//   List breakFast = [];
//   List finalBreakfast = [];
//   List weekBreakfast = [];
//   updateDataBase() async {
//     breakFast = widget.addedItems;
//
//     List compare = List.of(breakFast);
//     compare.sort();
//     print(compare);
//     //for (int i = 0; i < compare.length; i++) {
//     int i = 1;
//     while (compare.length > 0) {
//       String g = compare[0];
//       compare.removeAt(0);
//       // while (compare.contains(g) && finalBreakfast.contains(g)) {
//       //   compare.remove(g);
//       //   print('[]$compare');
//       // }
//       if (!compare.contains(g) && !finalBreakfast.contains(g)) {
//         print(finalBreakfast);
//         compare.remove(g);
//
//         finalBreakfast.add('$g x$i');
//         i = 1;
//       } else {
//         i++;
//       }
//     }
//     // doneBreakfast = List.from(userDoc['DoneBreakfast']);
//     DocumentSnapshot check = await userCollection
//         .doc(widget.uid)
//         .collection('schedule')
//         .doc(DateFormat("dd-MM").format(widget.day))
//         .get();
//     if (!check.exists)
//       userCollection
//           .doc(widget.uid)
//           .collection('schedule')
//           .doc(DateFormat("dd-MM").format(widget.day))
//           .set({
//         'Breakfast': finalBreakfast,
//         'weekBreakfast': breakFast
//       }).whenComplete(
//               () => widget.addedItems.removeRange(0, widget.addedItems.length));
//     await userCollection
//         .doc(widget.uid)
//         .collection('schedule')
//         .doc(DateFormat("dd-MM").format(widget.day))
//         .update({'Breakfast': finalBreakfast, 'weekBreakfast': breakFast})
//         .whenComplete(() => ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('Items Added'))))
//         .whenComplete(
//             () => widget.addedItems.removeRange(0, widget.addedItems.length));
//   }
//
//   int quantity = 0;
//   @override
//   Widget build(BuildContext context) {
//     // for (int i = 0; i < widget.addedItems.length; i++)
//     //   for (int j = 0; j < i; j++)
//     //     if (widget.addedItems[j] == widget.addedItems[i]) {
//     //       setState(() {
//     //         quantity++;
//     //         widget.addedItems.removeAt(i);
//     //       });
//     //     }
//     // final itemProvider = Provider.of<Item>(context);
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               for (int i = 0; i < widget.addedItems.length; i++)
//                 Row(
//                   children: [
//                     Text(widget.addedItems[i]),
//                     InkWell(
//                       child: Icon(Icons.remove),
//                       onTap: () {
//                         setState(() {
//                           widget.addedItems.removeAt(i);
//                         });
//                       },
//                     )
//                   ],
//                 ),
//               InkWell(
//                 onTap: () {
//                   updateDataBase();
//                 },
//                 child: Icon(Icons.done),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
