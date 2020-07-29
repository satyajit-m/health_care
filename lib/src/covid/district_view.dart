import 'package:flutter/material.dart';
import 'package:health_care/const/color_const.dart';
import 'package:health_care/const/size_config.dart';
import 'package:health_care/core/models/covid_model.dart';

Widget getDistOD(CovidDists covid, index) {
  return Column(children: <Widget>[
    Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      color: index % 2 == 0 ? Colors.grey[100] : Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: SizeConfig.screenWidth * 0.3,
                child: Padding(
                  padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.05),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          covid.dconf >= 0
                              ? (covid.dconf > 0
                                  ? Icon(
                                      Icons.arrow_upward,
                                      size: 10,
                                      color: Colors.grey,
                                    )
                                  : SizedBox())
                              : Icon(
                                  Icons.arrow_downward,
                                  size: 10,
                                  color: Colors.grey,
                                ),
                          covid.dconf == 0
                              ? SizedBox()
                              : Text(
                                  '${covid.dconf}',
                                  style: TextStyle(color: Colors.grey),
                                )
                        ],
                      ),
                      Text(
                        '${covid.confirmed}',
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          covid.dactive >= 0
                              ? (covid.dactive > 0
                                  ? Icon(
                                      Icons.arrow_upward,
                                      size: 10,
                                      color: Colors.grey,
                                    )
                                  : SizedBox())
                              : Icon(
                                  Icons.arrow_downward,
                                  size: 10,
                                  color: Colors.grey,
                                ),
                          covid.dactive == 0
                              ? SizedBox()
                              : Text(
                                  '${covid.dactive.abs()}',
                                  style: TextStyle(color: Colors.grey),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          covid.drecov >= 0
                              ? (covid.drecov > 0
                                  ? Icon(
                                      Icons.arrow_upward,
                                      size: 10,
                                      color: Colors.grey,
                                    )
                                  : SizedBox())
                              : Icon(
                                  Icons.arrow_downward,
                                  size: 10,
                                  color: Colors.grey,
                                ),
                          covid.drecov == 0
                              ? SizedBox()
                              : Text(
                                  '${covid.drecov.abs()}',
                                  style: TextStyle(color: Colors.grey),
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
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          covid.ddeceased > 0
                              ? Icon(
                                  Icons.arrow_upward,
                                  size: 10,
                                  color: Colors.grey,
                                )
                              : SizedBox(),
                          covid.ddeceased > 0
                              ? Text(
                                  '${covid.ddeceased.abs()}',
                                  style: TextStyle(color: Colors.grey),
                                )
                              : SizedBox()
                        ],
                      ),
                      Text(
                        "${covid.decs}",
                        style: covidDeceas,
                        overflow: TextOverflow.ellipsis,
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
    Divider(
      height: 1,
      color: Colors.grey,
    )
  ]);
}
