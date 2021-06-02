

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin{

  TabController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = TabController(initialIndex: 1, length: 3, vsync: this);

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
                  child: TabBar(
                      controller: _controller,

                      tabs: [
                        Tab(child: SvgPicture.asset(
                            'lib/assets/icon_history.svg',
                        ),),
                        Tab(child: SvgPicture.asset(
                          'lib/assets/icon_backup.svg',
                        ),),
                        Tab(child: SvgPicture.asset(
                          'lib/assets/icon_settings.svg',
                        ),),
                      ],
                ),
              )
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