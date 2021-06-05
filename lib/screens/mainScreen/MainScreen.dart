

import 'package:contacts_app/screens/mainScreen/MainScreenTabsBLoc.dart';
import 'package:contacts_app/storageModels/StorageModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:contacts_app/screens/gerenalModel.dart';

import 'MainScreenBloc.dart';

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
        context.read<MainScreenTapBloc>().add(MainScreenTapEvent.ChangeTapFirst);
      else if (_controller.index == 1)
        context.read<MainScreenTapBloc>().add(MainScreenTapEvent.ChangeTapSecond);
      else if (_controller.index == 2)
        context.read<MainScreenTapBloc>().add(MainScreenTapEvent.ChangeTapThird);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    mainScreenBloc.circleSize = width / 5;

    return DefaultTabController(
      length: 3,
      child: SafeArea(
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
                    child: BlocBuilder<MainScreenTapBloc, dynamic>(
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
      ),
    );

  }

  Widget firstTab(BuildContext context){
    return Stack(
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  height: 86,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "History",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Bold',
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
                Container(height: 2, color: Color(0xFFF3F3F3),),

                StreamBuilder(
                    stream: mainScreenBloc.mainListStream,
                    initialData: <StorageModel>[],
                    builder: (context, AsyncSnapshot<List<StorageModel>> snap){

                      if (snap.data.isEmpty){
                        return Container();
                      }

                      List<Widget> list = [];
                      for (var j in snap.data) {
                        list.add(cardObject(context, j));
                      }


                      return Expanded(
                        child: ListView(
                          children: [
                            Column(
                              children: list,
                            )
                          ],
                        ),
                      );
                    }),

              ],
            )
        ),

      ],
    );
  }

  Widget secondTab(BuildContext context){
    var screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white,
      child: Stack(
        children: [




          StreamBuilder(
              stream: mainScreenBloc.isLoadingNowStream,
              initialData: StateScreen.INIT,
              builder: (context, snap){

                if (snap.data == StateScreen.LOADING){
                  return Stack(
                    children: [

                      StreamBuilder(
                      stream: mainScreenBloc.updateProgressSizeStream,
                      initialData: mainScreenBloc.circleSize,
                      builder: (context, snap){

                        return Stack(
                          children: [
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: screenHeight / 2,
                                  width: double.infinity,
                                  child: Image.asset(
                                    'lib/assets/background_active.png',
                                    fit: BoxFit.fill,
                                  ),
                                )),
                            Center(
                              child: Container(
                                width: mainScreenBloc.circleSize + 30,
                                height: mainScreenBloc.circleSize + 30,
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    shape: BoxShape.circle
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: mainScreenBloc.circleSize,
                                height: mainScreenBloc.circleSize,
                                decoration: BoxDecoration(
                                    color: GeneralModel.mainAppColor,
                                    shape: BoxShape.circle
                                ),
                              ),
                            ),

                            Align(
                                alignment: Alignment.topCenter,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 86,
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          "Backing Up...",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontFamily: 'Bold',
                                              color: Colors.black
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 2,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24, right: 24),
                                      child: Text(
                                        "Please sit tight while your contacts are being backed up.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'SemiBold',
                                            color: Colors.black
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        );

                      }),

                      StreamBuilder(
                          stream: mainScreenBloc.updateProgressNumberStream,
                          initialData: mainScreenBloc.numberProgress,
                          builder: (context, snap){
                            double number = snap.data;

                            return Center(
                              child: Text(
                                number.toInt().toString() + "%",
                                textAlign: TextAlign.center,
                                style: TextStyle(

                                    fontSize: 28,
                                    fontFamily: 'Bold',
                                    color: Colors.white
                                ),
                              ),
                            );
                          }),

                    ],
                  );
                }
                else if ( snap.data == StateScreen.INIT)
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
                      GestureDetector(
                        onTap: () async {


                          //Iterable<Contact> contacts = await ContactsService.getContacts();
                          var status = await Permission.contacts.status;
                          print(status);

                          if (status.isUndetermined)
                            await Permission.contacts.request();
                          if (status.isDenied)
                            await Permission.contacts.request();


                        },
                        child: Center(
                          child: Image.asset(
                            'lib/assets/white_circle.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var status = await Permission.contacts.status;
                          print(status);

                          if (status.isUndetermined)
                            await Permission.contacts.request();
                          if (status.isDenied)
                            await Permission.contacts.request();


                        },
                        child: Center(
                          child: Image.asset(
                            'lib/assets/circle_create.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var status = await Permission.contacts.status;

                          if (status.isUndetermined)
                            await Permission.contacts.request();
                          if (status.isDenied)
                            await Permission.contacts.request();

                          if (status.isGranted){
                            Iterable<Contact> contacts = await ContactsService.getContacts();
                            mainScreenBloc.loadContactsToFile(contacts);
                          }

                        },
                        child: Center(
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
                      ),

                      Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Container(
                                height: 86,
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    "Backing Up..",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'Bold',
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 2,),
                              Padding(
                                padding: const EdgeInsets.only(left: 24, right: 24),
                                child: Text(
                                  "Please sit tight while your contacts are being backed up.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'SemiBold',
                                      color: Colors.black
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  );
                else
                  return Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.asset(
                          'lib/assets/background.png',
                          fit: BoxFit.cover,
                        ),
                      ),

                      Center(
                        child: Text(
                          "100%",
                          textAlign: TextAlign.center,
                          style: TextStyle(

                              fontSize: 45,
                              fontFamily: 'Bold',
                              color: Colors.white
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 100, left: 24, right: 24),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 56,
                              width: double.infinity,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Colors.white,
                                onPressed: (){
                                  _controller.animateTo(0);
                                  mainScreenBloc.redirectToHistory(MediaQuery.of(context).size.width / 5);
                                },
                                child: Text(
                                  "Open BackUp",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(

                                      fontSize: 15,
                                      fontFamily: 'Bold',
                                      color: GeneralModel.mainAppColor
                                  ),
                                ),
                              ),
                            )
                        ),
                      ),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Container(
                                height: 86,
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    "Completed!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'Bold',
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 2,),
                              Padding(
                                padding: const EdgeInsets.only(left: 24, right: 24),
                                child: Text(
                                  "Your backup has been completed and saved to your archive.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'SemiBold',
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  );
          }),




        ],
      ),
    );
  }

  Widget thirdTab(BuildContext context){
    var screenHeight = MediaQuery.of(context).size.height;
    double step = 25;

    return Container(
      color: Colors.white,
      child: Stack(
        children: [

          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 3 * (screenHeight / 4),
                width: double.infinity,
                child: Image.asset(
                  'lib/assets/background_create.png',
                  fit: BoxFit.fill,
                ),
              )),
          Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(
                    height: 86,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Settings",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Bold',
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),


                ],
              )
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                      generalModel.launchURL("https://www.google.ru/");
                  },
                  child: Text(
                    "Help",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'Bold',
                        color: GeneralModel.mainAppColor
                    ),
                  ),
                ),
                SizedBox(height: step,),
                GestureDetector(
                  onTap: (){
                    generalModel.launchURL("https://www.google.ru/");
                  },
                  child: Text(
                    "Privacy Policy",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'Bold',
                        color: GeneralModel.mainAppColor
                    ),
                  ),
                ),
                SizedBox(height: step,),
                GestureDetector(
                  onTap: (){
                    generalModel.launchURL("https://www.google.ru/");
                  },
                  child: Text(
                    "Terms of Use",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'Bold',
                        color: GeneralModel.mainAppColor
                    ),
                  ),
                ),
                SizedBox(height: step,),
                GestureDetector(
                  onTap: (){
                    generalModel.launchURL("https://www.google.ru/");
                  },
                  child: Text(
                    "Support",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'Bold',
                        color: GeneralModel.mainAppColor
                    ),
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }

  Widget cardObject(BuildContext context, StorageModel storageModel){

    return Column(
      children: [
        Container(
          height: 90,
          color: Colors.white,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(
                      'lib/assets/button_cloud.svg',
                    ),),
              ),
              SizedBox(width: 24,),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      storageModel.data,
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Bold',
                          color: Colors.black
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      storageModel.time + " • " +
                      storageModel.countContacts + " contacts • " +
                      storageModel.fileMemory + "Kb",
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'SemiBold',
                          color: Colors.black
                      ),
                    ),
                  ],
                ),

              ),
              Expanded(
                  child: GestureDetector(
                    onTap: () {
                      mainScreenBloc.shareFunction(storageModel.pathFileVcf);
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: SvgPicture.asset(
                          'lib/assets/button_share.svg',
                        ),
                      ),
                    ),
                  ),
              )
            ],
          ),
        ),
        Container(height: 2, color: Color(0xFFF3F3F3),)
      ],
    );

  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}