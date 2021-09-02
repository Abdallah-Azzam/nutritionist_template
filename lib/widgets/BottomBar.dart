import 'package:flutter/material.dart';
import 'package:new_nutristionist_template/screens/home_page/home_screen.dart';
import 'package:new_nutristionist_template/screens/subscribers/view_subscribers.dart';
import 'package:new_nutristionist_template/screens/user/user_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  //tells the bottomNavigationBar what page to open when the app is opened
  int selectedIndex = 1;
  //used to initialize pages in the bottom bar
  late List<Map<String, dynamic>> pages;
  //sets the selectedIndex to the new index controlled by user interaction
  setPage(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    // initializes all the pages present on the bottomNavigationBar
    pages = [
      {
        'page': HomeScreen(),
      },
      {
        'page': ViewSubscribers(),
      },
      {
        'page': UserScreen(),
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // the body tells the program what page to open
      body: pages[selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        // once an interaction occurs in the NavigationBar set the page index to that of the user interaction
        onTap: setPage,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people), label: 'subscribers'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
        ],
      ),
    );
  }
}
