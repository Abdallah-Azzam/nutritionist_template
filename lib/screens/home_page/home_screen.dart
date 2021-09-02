import 'package:flutter/material.dart';
import 'package:new_nutristionist_template/screens/home_page/feed_screen.dart';

import 'dms/direct_messeging.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [FeedScreen(), DirectMessaging()],
    );
  }
}
