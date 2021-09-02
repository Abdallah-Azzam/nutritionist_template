import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_nutristionist_template/provider/nutrition_provider/breakfast.dart';
import 'package:new_nutristionist_template/provider/dark_theme+provider.dart';
import 'package:new_nutristionist_template/provider/nutrition_provider/dinner.dart';
import 'package:new_nutristionist_template/provider/nutrition_provider/lunch.dart';
import 'package:new_nutristionist_template/screens/Auth_Screen/Navigator.dart';
import 'package:new_nutristionist_template/theme_data.dart';
import 'package:provider/provider.dart';

void main() async {
  //initializing database
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkTHemeProvider themeProvider = DarkTHemeProvider();
  void getCurrentAppTheme() async {
    themeProvider.darkTheme = await themeProvider.themePreference.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeProvider;
        }),
        ChangeNotifierProvider(create: (_) {
          return Dinner();
        }),
        ChangeNotifierProvider(create: (_) {
          return Lunch();
        }),
        ChangeNotifierProvider(create: (_) {
          return Breakfast();
        }),

      ],
      child: Consumer<DarkTHemeProvider>(
        builder: (BuildContext context, themeData, child) {
          return MaterialApp(
            theme: Styles.themeData(themeProvider.darkTheme, context),
            //setting initial path to the signed in brain
            home: Navigate(),
          );
        },
      ),
    );
  }
}
