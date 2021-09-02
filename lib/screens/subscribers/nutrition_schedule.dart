import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'customize_day.dart';

class NutritionSchedule extends StatefulWidget {
  final String uid;
  NutritionSchedule(this.uid);

  @override
  _NutritionScheduleState createState() => _NutritionScheduleState();
}

class _NutritionScheduleState extends State<NutritionSchedule> {
  int? i;

  @override
  Widget build(BuildContext context) {
    DateTime day1 = DateTime.now();
    DateTime day2 = day1.add(Duration(days: 1));
    DateTime day3 = day2.add(Duration(days: 1));
    DateTime day4 = day3.add(Duration(days: 1));
    DateTime day5 = day4.add(Duration(days: 1));
    DateTime day6 = day5.add(Duration(days: 1));
    DateTime day7 = day6.add(Duration(days: 1));
    DateTime day8 = day7.add(Duration(days: 1));
    DateTime day9 = day8.add(Duration(days: 1));
    DateTime day10 = day9.add(Duration(days: 1));
    DateTime day11 = day10.add(Duration(days: 1));
    DateTime day12 = day11.add(Duration(days: 1));
    DateTime day13 = day12.add(Duration(days: 1));
    DateTime day14 = day13.add(Duration(days: 1));
    DateTime day15 = day14.add(Duration(days: 1));
    DateTime day16 = day15.add(Duration(days: 1));
    DateTime day17 = day16.add(Duration(days: 1));
    DateTime day18 = day17.add(Duration(days: 1));
    DateTime day19 = day18.add(Duration(days: 1));
    DateTime day20 = day19.add(Duration(days: 1));
    DateTime day21 = day20.add(Duration(days: 1));
    DateTime day22 = day21.add(Duration(days: 1));
    DateTime day23 = day22.add(Duration(days: 1));
    DateTime day24 = day23.add(Duration(days: 1));
    DateTime day25 = day24.add(Duration(days: 1));
    DateTime day26 = day25.add(Duration(days: 1));
    DateTime day27 = day26.add(Duration(days: 1));
    DateTime day28 = day27.add(Duration(days: 1));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'week 1',
                      style: TextStyle(
                          color: Color.fromRGBO(36, 51, 72, 1),
                          fontFamily: 'Tajwal',
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day1, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        color: Color.fromRGBO(253, 209, 58, 0.8),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day1),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day2, widget.uid)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.8),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        height: MediaQuery.of(context).size.height / 7,
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day2),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day3, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.8),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day3),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day4, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.8),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day4),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day5, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.8),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day5),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day6, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.8),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day6),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day7, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.8),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day7),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'week 2',
                      style: TextStyle(
                          color: Color.fromRGBO(36, 51, 72, 1),
                          fontFamily: 'Tajwal',
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day8, widget.uid)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.6),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        height: MediaQuery.of(context).size.height / 7,
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day8),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day9, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.6),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day9),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day10, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.6),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day10),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day11, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.6),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day11),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day12, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.6),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day12),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day13, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.6),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day13),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day14, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.6),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day14),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'week 3',
                      style: TextStyle(
                          color: Color.fromRGBO(36, 51, 72, 1),
                          fontFamily: 'Tajwal',
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day15, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.4),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day15),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day16, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.4),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MM").format(day16),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day17, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.4),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day17),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day18, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.4),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day18),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day19, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.4),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day19),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day20, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.4),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day20),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day21, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.4),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day21),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'week 4',
                      style: TextStyle(
                          fontFamily: 'Tajwal',
                          fontSize: 25,
                          color: Color.fromRGBO(36, 51, 72, 1),
                          fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day22, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.2),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day22),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day23, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.2),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day23),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day24, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.2),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day24),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day25, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.2),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day25),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day26, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.2),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day26),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day27, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.2),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day27),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomizeDay(day28, widget.uid)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 209, 58, 0.2),
                            border: Border.all(
                                width: 0.15,
                                color: Color.fromRGBO(146, 168, 189, 1))),
                        width: MediaQuery.of(context).size.width / 4,
                        child: Center(
                          child: Text(
                            DateFormat("dd-MMM").format(day28),
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
