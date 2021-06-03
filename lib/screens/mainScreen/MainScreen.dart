

import 'package:contacts_app/screens/mainScreen/MainScreenBLoC.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin{

  TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(initialIndex: 1, length: 3, vsync: this);

    _controller.addListener((){
      if (_controller.index == 0)
        context.read<MainScreenBloc>().add(MainScreenBlocEvent.first);
      else if (_controller.index == 1)
        context.read<MainScreenBloc>().add(MainScreenBlocEvent.second);
      else if (_controller.index == 2)
        context.read<MainScreenBloc>().add(MainScreenBlocEvent.third);
    });
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: Stack(
            children: [
              TabBarView(
                controller: _controller,
                children: [
                  firstTab(context),
                  secondTab(context),
                  thirdTab(context),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 70,
                  width: double.infinity,
                  color: Colors.white,
                  child: BlocBuilder<MainScreenBloc, List<Color>>(
                      builder: (context, colorList){
                        return TabBar(
                          controller: _controller,

                          tabs: [
                            Tab(
                              child: SvgPicture.asset(
                                'lib/assets/icon_history.svg',
                                color: colorList[0],
                              ),
                            ),
                            Tab(
                              child: SvgPicture.asset(
                                'lib/assets/icon_backup.svg',
                                color: colorList[1],
                              ),
                            ),
                            Tab(
                              child: SvgPicture.asset(
                                'lib/assets/icon_settings.svg',
                                color: colorList[2],
                              ),
                            ),
                          ],
                        );
                      },
                      ),
                ),
              )
            ],
          )),
    );

  }

  Widget firstTab(BuildContext context){
    var screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [

        Center(
          child: Image.asset(
            'lib/assets/circle_create.png',
            fit: BoxFit.cover,
          ),
        ),

      ],
    );
  }
  Widget secondTab(BuildContext context){
    var screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight / 2,
              width: double.infinity,
              child: Image.asset(
                'lib/assets/background_create.png',
                fit: BoxFit.fill,
              ),
            )),
        Center(
          child: Image.asset(
            'lib/assets/white_circle.png',
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Image.asset(
            'lib/assets/circle_create.png',
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Text(
            "Create\nBackup",
            textAlign: TextAlign.center,
            style: TextStyle(

                fontSize: 28,
                fontFamily: 'Bold',
                color: Colors.white
            ),
          ),
        ),
      ],
    );
  }
  Widget thirdTab(BuildContext context){
    var screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [


        Center(
          child: Image.asset(
            'lib/assets/circle_create.png',
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Text(
            "Create\nBackup",
            textAlign: TextAlign.center,
            style: TextStyle(

                fontSize: 28,
                fontFamily: 'Bold',
                color: Colors.white
            ),
          ),
        ),
      ],
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}