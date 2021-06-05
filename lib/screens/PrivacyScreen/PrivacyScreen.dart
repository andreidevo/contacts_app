import 'package:contacts_app/screens/gerenalModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class PrivacyScreen extends StatefulWidget {
  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: SvgPicture.asset(
                            'lib/assets/close.svg',
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            generalModel.launchURL("https://www.google.ru/");
                          },
                          child: Text(
                            "Restore Purchases",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Medium',
                                color: GeneralModel.mainAppColor
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 58, left: 24, right: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Contacts Backup",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Medium',
                            color: Colors.black
                        ),
                      ),
                      SizedBox(height: 8,),
                      Image.asset('lib/assets/Pro.png'),
                      SizedBox(height: 16,),
                      Text(
                        "We understand that your contacts are important for you, so we have developed Contact Backup Master to keep your address book secure at all times",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Medium',
                            color: Color(0xFF8D8D8D)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 24, right: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: SvgPicture.asset(
                              'lib/assets/cycle.svg',
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Automatic Backups",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'SemiBold',
                                        color: Color(0xFF000000)
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Text(
                                    "Automatically back up your contacts",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Medium',
                                        color: Color(0xFF8D8D8D)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: SvgPicture.asset(
                              'lib/assets/cloud.svg',
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Cloud Storage",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'SemiBold',
                                        color: Color(0xFF000000)
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Text(
                                    "Store your backups securely in the cloud",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Medium',
                                        color: Color(0xFF8D8D8D)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: SvgPicture.asset(
                              'lib/assets/shild.svg',
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Backups Protection",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'SemiBold',
                                        color: Color(0xFF000000)
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Text(
                                    "Your cloud backups will be securely protected",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Medium',
                                        color: Color(0xFF8D8D8D)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 60, left: 24, right: 24),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Free unlimited access",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Medium',
                              color: Color(0xFF8D8D8D)
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 56,
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: InkWell(
                                     // Handle your callback.
                                    splashColor: Colors.indigo.withOpacity(0.5),
                                    child: Ink(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('lib/assets/button.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "Get Master version",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Bold',
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )

                        ),
                      ],
                    )
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            generalModel.launchURL("https://www.google.ru/");
                          },
                          child: Text(
                            "Terms of Use",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Medium',
                                color: GeneralModel.mainAppColor
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            generalModel.launchURL("https://www.google.ru/");
                          },
                          child: Text(
                            "Privacy police",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Medium',
                                color: GeneralModel.mainAppColor
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
