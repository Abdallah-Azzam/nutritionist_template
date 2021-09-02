import 'package:flutter/material.dart';
import 'package:new_nutristionist_template/screens/Auth_Screen/signup_pages/sign_in.dart';
import 'package:new_nutristionist_template/widgets/BottomBar.dart';

//checks if the user is signed in
class Navigate extends StatefulWidget {
  const Navigate({Key? key}) : super(key: key);
  static bool signedIn = false;
  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  @override
  Widget build(BuildContext context) {
    return Navigate.signedIn ? BottomBar() : SignIn();
  }
}

class NotAuthenticated extends StatelessWidget {
  const NotAuthenticated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            'Your information is going through a screening process, sit tight!'),
      ),
    );
  }
}
