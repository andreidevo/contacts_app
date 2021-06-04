

import 'package:contacts_app/screens/mainScreen/MainScreenTabsBLoc.dart';
import 'package:contacts_app/storageModels/StorageModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

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
    var screenHeight = MediaQuery.of(context).size.height;

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

        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Container(
                height: 86,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Contacts Backup",
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
                  "Backup your address book to avoid losing your contacts in case something happens to your phone.",
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

    //
        GestureDetector(
          onTap: () async {

            var status = await Permission.contacts.status;
            print(status);

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

  Widget cardObject(BuildContext context, StorageModel storageModel){

    return Column(
      children: [
        Container(
          height: 90,
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
                      "May 18, 2021",
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
                      "07:54pm • 2 contacts • 65Kb",
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
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: SvgPicture.asset(
                        'lib/assets/button_share.svg',
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