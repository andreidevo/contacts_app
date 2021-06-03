import 'package:contacts_app/screens/mainScreen/MainScreen.dart';
import 'package:contacts_app/screens/mainScreen/MainScreenBLoC.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  generalModel.initHiveFunction();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainScreenBloc(),
      child: MaterialApp(
        title: "Contacts",
        debugShowCheckedModeBanner: false,
        home: MainScreen()


      ),
    );
  }
}