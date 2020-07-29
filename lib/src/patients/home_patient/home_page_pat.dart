import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_care/const/color_const.dart';
import 'package:health_care/const/size_config.dart';
import 'package:health_care/src/agents/exist_patient/pat_history.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomePagePat extends StatefulWidget {
  HomePagePat({Key key}) : super(key: key);

  @override
  _HomePagePatState createState() => _HomePagePatState();
}

class _HomePagePatState extends State<HomePagePat> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: ListView(children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
            height: SizeConfig.screenHeight * 0.4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF3383CD),
                  Color(0xFF11249F),
                ],
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: SizeConfig.screenHeight * 0.3,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: SizeConfig.screenHeight * 0.25),
                          child: Image.asset('assets/img/Drcorona.png'),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                width: SizeConfig.screenWidth * 0.4,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'Stay',
                                          style: GoogleFonts.lato(
                                              fontSize: 25,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: RotateAnimatedTextKit(
                                          repeatForever: true,
                                          duration:
                                              Duration(milliseconds: 2500),
                                          pause: Duration(milliseconds: 1000),
                                          text: [
                                            "Home",
                                            "Safe",
                                          ],
                                          textStyle: GoogleFonts.lato(
                                              fontSize: 25,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  alignment: Alignment.center,
                  child: TypewriterAnimatedTextKit(
                      onTap: () {
                        print("Tap Event");
                      },
                      speed: Duration(milliseconds: 180),
                      text: [
                        "Wash Your Hands Frequently",
                        "Maintain Social Distancing",
                        "Always Wear A Mask",
                      ],
                      repeatForever: true,
                      textStyle: GoogleFonts.lato(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.start,
                      alignment:
                          AlignmentDirectional.topStart // or Alignment.topLeft
                      ),
                ),
              ],
            ),
          ),
          Container(
            color: lightBlueIsh,
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.history,
                      color: Colors.white,
                    )),
                Expanded(
                    flex: 3,
                    child: Text('Previous Health Updates',
                        style: GoogleFonts.sourceSansPro(
                            fontSize: 20, color: Colors.white))),
              ],
            ),
          ),
          FutureBuilder(
              future: getPhone(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return patHistory(context, snapshot.data);
                }
              })
        ]),
      ),
    );
  }

  Future<String> getPhone() async {
    final _auth = FirebaseAuth.instance;
    dynamic user;
    String userPhoneNumber;

    user = await _auth.currentUser();
    userPhoneNumber = user.phoneNumber;
    return userPhoneNumber;
  }
}
