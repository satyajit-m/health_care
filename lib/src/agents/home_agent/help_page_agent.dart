import 'package:flutter/material.dart';
import 'package:health_care/const/color_const.dart';
import 'package:health_care/const/size_config.dart';
import 'package:health_care/core/models/covid_model.dart';
import 'package:health_care/services/covid_api.dart';

class HelpPageAgent extends StatefulWidget {
  HelpPageAgent({Key key}) : super(key: key);

  final String title = "Carousel Demo";

  @override
  HelpPageAgentState createState() => HelpPageAgentState();
}

class HelpPageAgentState extends State<HelpPageAgent> {
  //var _scaffoldKey = GlobalKey<ScaffoldState>();
  String s = "Block";
  var block = 1;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              'Covid-19 Odisha',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: SizeConfig.screenWidth * 0.3,
                child: Padding(
                  padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.05),
                  child: Text(
                    "District",
                    style: covidHead,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: SizeConfig.screenWidth * 0.15,
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "Total",
                    style: covidHead,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: SizeConfig.screenWidth * 0.15,
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "Active",
                    style: covidHead,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: SizeConfig.screenWidth * 0.15,
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "Recovered",
                    style: covidHead,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: SizeConfig.screenWidth * 0.15,
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "Deceased",
                    style: covidHead,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          FutureBuilder(
            future: getCases(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Container(
                  height: SizeConfig.screenHeight * 0.8,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: snap.data.length,
                itemBuilder: (context, index) {
                  CovidModel covid = snap.data[index];
                  return Column(children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      color: index % 2 == 0 ? Colors.black : Colors.white12,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                width: SizeConfig.screenWidth * 0.3,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.screenWidth * 0.05),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        covid.dist,
                                        style: covidDists,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: SizeConfig.screenWidth * 0.15,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          covid.dconf >= 0
                                              ? (covid.dconf > 0
                                                  ? Icon(
                                                      Icons.arrow_upward,
                                                      size: 10,
                                                      color: Colors
                                                          .grey,
                                                    )
                                                  : SizedBox())
                                              : Icon(
                                                  Icons.arrow_downward,
                                                  size: 10,
                                                  color:
                                                      Colors.grey,
                                                ),
                                          covid.dconf == 0
                                              ? SizedBox()
                                              : Text(
                                                  '${covid.dconf}',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey),
                                                )
                                        ],
                                      ),
                                      Text(
                                        '${covid.total}',
                                        style: covidTotal,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: SizeConfig.screenWidth * 0.15,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    children: <Widget>[
                                       Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          covid.dactive >= 0
                                              ? (covid.dactive > 0
                                                  ? Icon(
                                                      Icons.arrow_upward,
                                                      size: 10,
                                                      color: Colors
                                                          .grey,
                                                    )
                                                  : SizedBox())
                                              : Icon(
                                                  Icons.arrow_downward,
                                                  size: 10,
                                                  color:
                                                      Colors.grey,
                                                ),
                                          covid.dactive == 0
                                              ? SizedBox()
                                              : Text(
                                                  '${covid.dactive.abs()}',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey),
                                                )
                                        ],
                                      ),
                                      Text(
                                        "${covid.active}",
                                        style: covidActive,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: SizeConfig.screenWidth * 0.15,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    children: <Widget>[
                                       Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          covid.drecov >= 0
                                              ? (covid.drecov > 0
                                                  ? Icon(
                                                      Icons.arrow_upward,
                                                      size: 10,
                                                      color: Colors
                                                          .grey,
                                                    )
                                                  : SizedBox())
                                              : Icon(
                                                  Icons.arrow_downward,
                                                  size: 10,
                                                  color:
                                                      Colors.grey,
                                                ),
                                          covid.drecov == 0
                                              ? SizedBox()
                                              : Text(
                                                  '${covid.drecov.abs()}',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey),
                                                )
                                        ],
                                      ),
                                      Text(
                                        "${covid.recov}",
                                        style: covidRecov,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: SizeConfig.screenWidth * 0.15,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    "${covid.decs}",
                                    style: covidDeceas,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    )
                  ]);
                },
              );
            },
          )
        ],
      )),
    );
  }
}
