import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_care/animation/Animations.dart';
import 'package:health_care/const/color_const.dart';
import 'package:health_care/const/size_config.dart';
import 'package:health_care/core/models/covid_model.dart';
import 'package:health_care/services/covid_api.dart';
import 'package:shimmer/shimmer.dart';

class CovidOD extends StatefulWidget {
  CovidOD({Key key}) : super(key: key);

  final String title = "Carousel Demo";

  @override
  CovidODState createState() => CovidODState();
}

class CovidODState extends State<CovidOD> {
  //var _scaffoldKey = GlobalKey<ScaffoldState>();
  String s = "Block";
  var block = 1;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              'Covid-19 Odisha',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
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
                    child: getShimmer(),
                  ),
                );
              }
              CovidModel covid = snap.data;

              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: SizeConfig.screenHeight * 0.12,
                          child: Card(
                            color: Colors.deepOrange[100],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Total',
                                      style: odHead,
                                    ),
                                  ),
                                ),
                                covid.today.deceased > 0
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.arrow_upward,
                                            color: Colors.grey[600],
                                            size: 15,
                                          ),
                                          Text(
                                            '${covid.today.confirmed}',
                                            style: odDelta,
                                          ),
                                        ],
                                      )
                                    : Container(),
                                Text(
                                  '${covid.total.confirmed}',
                                  style: odTotal,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: SizeConfig.screenHeight * 0.12,
                          child: Card(
                            color: Colors.red[100],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text('Active', style: odHead)),
                                ),
                                covid.today.deceased > 0
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.arrow_upward,
                                            color: Colors.grey[600],
                                            size: 15,
                                          ),
                                          Text(
                                            '${covid.today.active}',
                                            style: odDelta,
                                          ),
                                        ],
                                      )
                                    : (covid.today.deceased < 0
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.arrow_downward,
                                                color: Colors.grey[600],
                                                size: 15,
                                              ),
                                              Text(
                                                '${covid.today.active.abs()}',
                                                style: odDelta,
                                              ),
                                            ],
                                          )
                                        : Container()),
                                Text(
                                  '${covid.total.active}',
                                  style: odActive,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: SizeConfig.screenHeight * 0.12,
                          child: Card(
                            color: Colors.green[100],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text('Recovered', style: odHead)),
                                ),
                                covid.today.recovered > 0
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.arrow_upward,
                                            color: Colors.grey[600],
                                            size: 15,
                                          ),
                                          Text(
                                            '${covid.today.recovered}',
                                            style: odDelta,
                                          ),
                                        ],
                                      )
                                    : Container(),
                                Text(
                                  '${covid.total.recovered}',
                                  style: odRecovered,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: SizeConfig.screenHeight * 0.12,
                          child: Card(
                            color: Colors.blueGrey[100],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text('Deceased', style: odHead)),
                                ),
                                covid.today.deceased > 0
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.arrow_upward,
                                            color: Colors.blueGrey,
                                            size: 15,
                                          ),
                                          Text(
                                            '${covid.today.deceased}',
                                            style: odDelta,
                                          ),
                                        ],
                                      )
                                    : Container(),
                                Text(
                                  '${covid.total.deceased}',
                                  style: odDeceased,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: SizeConfig.screenHeight * 0.12,
                          child: Card(
                            color: Colors.purple[100],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Updated At',
                                      style: odHead,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ),
                                Text(
                                    '${covid.updAt.substring(8, 10)}-${covid.updAt.substring(5, 8)} ${covid.updAt.substring(0, 4)}',
                                    style: odUpdated),
                                Text('${covid.updAt.substring(11, 16)}',
                                    style: odUpdated)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      color: Colors.lightBlue[100],
                      width: SizeConfig.screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'District Wise',
                            style: GoogleFonts.raleway(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  headingText(),
                  SizedBox(
                    height: 15,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: covid.dists.length,
                    itemBuilder: (context, index) {
                      return AnimatedListItem(covid.dists[index], index);
                    },
                  ),
                ],
              );
            },
          )
        ],
      )),
    );
  }

  headingText() {
    return Row(
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
    );
  }

  getShimmer() {
    return Shimmer.fromColors(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: SizeConfig.screenHeight * 0.12,
                  child: Card(
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: SizeConfig.screenHeight * 0.12,
                  child: Card(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: SizeConfig.screenHeight * 0.12,
                  child: Card(
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: SizeConfig.screenHeight * 0.12,
                  child: Card(
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: SizeConfig.screenHeight * 0.12,
                  child: Card(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            color: Colors.white,
            height: 35,
            width: SizeConfig.screenWidth,
          ),
          Divider(),
          Container(
            color: Colors.white,
            height: 25,
            width: SizeConfig.screenWidth,
          ),
          Divider(),
          Container(
            color: Colors.white,
            height: 25,
            width: SizeConfig.screenWidth,
          ),
          Divider(),
          Container(
            color: Colors.white,
            height: 25,
            width: SizeConfig.screenWidth,
          ),
          Divider(),
          Container(
            color: Colors.white,
            height: 25,
            width: SizeConfig.screenWidth,
          ),
          Divider(),
          Container(
            color: Colors.white,
            height: 25,
            width: SizeConfig.screenWidth,
          ),
          Divider(),
          Container(
            color: Colors.white,
            height: 25,
            width: SizeConfig.screenWidth,
          ),
          Divider(),
          Container(
            color: Colors.white,
            height: 25,
            width: SizeConfig.screenWidth,
          ),
          Divider(),
          Container(
            color: Colors.white,
            height: 25,
            width: SizeConfig.screenWidth,
          ),
          Divider(),
          Container(
            color: Colors.white,
            height: 25,
            width: SizeConfig.screenWidth,
          ),
          Divider(),
          Container(
            color: Colors.white,
            height: 25,
            width: SizeConfig.screenWidth,
          ),
          Divider()
        ],
      ),
      baseColor: Colors.grey[100],
      highlightColor: Colors.grey[300],
      period: Duration(milliseconds: 500),
    );
  }
}
