import 'package:contacts_app/screens/mainScreen/MainScreen.dart';
import 'package:flutter/material.dart';


void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  generalModel.initHiveFunction();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Contacts",
      debugShowCheckedModeBanner: false,
      home: MainScreen()
    );
  }
}