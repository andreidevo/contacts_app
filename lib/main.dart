import 'package:contacts_app/screens/gerenalModel.dart';
import 'package:contacts_app/screens/mainScreen/MainScreen.dart';
import 'package:contacts_app/screens/mainScreen/MainScreenTabsBLoc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart' ;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  generalModel.initHiveFunction();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainScreenTapBloc(),
        ),
      ],
      child: MaterialApp(
          title: "Contacts",
          debugShowCheckedModeBanner: false,
          home: MainScreen()
      ),
    );
  }
}