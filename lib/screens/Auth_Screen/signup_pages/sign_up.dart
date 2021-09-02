import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_nutristionist_template/constants/constants.dart';
import 'package:new_nutristionist_template/constants/firebase_const.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _schoolController = TextEditingController();
  TextEditingController _otherCertificatesController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  TextEditingController _expertiseController = TextEditingController();
  bool obscure = true;

  //creates a new profile in database with the credentials filled on this page
  signup() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((signedUser) =>
            nutristionistCollection.doc(signedUser.user?.uid).set({
              'username': _userNameController.text,
              'password': _passwordController.text,
              'email': _emailController.text,
              'degree': degree,
              'school': _schoolController.text,
              'other certification': _otherCertificatesController.text == ''
                  ? 'none'
                  : _otherCertificatesController.text,
              'years of experience': _experienceController.text,
              'area of expertise': _expertiseController.text,
              'following': [],
              'subscribers': [],
              'uid': signedUser.user!.uid,
              'profilePic':
                  'https://www.kindpng.com/picc/m/105-1055656_account-user-profile-avatar-avatar-user-profile-icon.png',
              'Auth': false
            }));
    //sends the user to the sign in screen if new account creation was successful
    Navigator.pop(context);
  }

  String degree = 'Bachelors';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 244, 162, 1),
      // allows user to scroll through pages
      body: PageView(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Page 1 of 2'),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Column(
                      children: [
                        Text(
                          'Nutritionist information',
                          style: TextStyle(
                              fontFamily: 'Tajwal',
                              color: Color.fromRGBO(36, 51, 72, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: TextField(
                            controller: _emailController,
                            style: TextStyle(color: Colors.black),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: TextField(
                            controller: _userNameController,
                            style: TextStyle(color: Colors.black),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'UserName',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: Icon(
                                Icons.drive_file_rename_outline,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: TextField(
                            controller: _passwordController,
                            style: TextStyle(color: Colors.black),
                            obscureText: obscure,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    obscure = !obscure;
                                  });
                                },
                                child: obscure
                                    ? Icon(Icons.remove_red_eye)
                                    : Icon(Icons.remove_red_eye_outlined),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Page 2 of 2'),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Column(
                      children: [
                        Text(
                          'Certification',
                          style: TextStyle(
                              fontFamily: 'Tajwal',
                              color: Color.fromRGBO(36, 51, 72, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        for (int x = 0; x < degrees.length; x++)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  degree = degrees[x];
                                });
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.width / 3,
                                color: degree == degrees[x]
                                    ? Colors.black12
                                    : Color.fromRGBO(146, 168, 189, 100),
                                child: Center(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //        Container(child: targetBodyIcon[x]),
                                        Text(
                                          degrees[x],
                                          style: TextStyle(
                                            fontFamily: 'Tajwal',
                                            fontSize: 20,
                                            color:
                                                Color.fromRGBO(36, 51, 72, 1),

                                            // color: gender == 'male'
                                            //     ? Colors.lightBlue
                                            //     : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: TextField(
                            controller: _schoolController,
                            style: TextStyle(color: Colors.black),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'School',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: Icon(
                                Icons.school,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: TextField(
                            maxLines: null,
                            controller: _otherCertificatesController,
                            style: TextStyle(color: Colors.black),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Other certificates',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: Icon(
                                Icons.document_scanner,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: TextField(
                            controller: _experienceController,
                            style: TextStyle(color: Colors.black),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'years of experience',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: Icon(
                                Icons.watch_later_outlined,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: TextField(
                            controller: _expertiseController,
                            style: TextStyle(color: Colors.black),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Expertise(Bulking,etc)',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: Icon(
                                Icons.watch_later_outlined,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: InkWell(
                            onTap: () {
                              return signup();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(33))),
                              child: Center(
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      fontFamily: 'Tajwal',
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
