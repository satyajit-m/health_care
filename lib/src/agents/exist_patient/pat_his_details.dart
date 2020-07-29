import 'package:flutter/material.dart';
import 'package:health_care/const/color_const.dart';
import 'dart:math';

import 'package:health_care/core/models/pat_his_model.dart';

class PatHisDetails extends StatefulWidget {
  final HistoryModel model;
  const PatHisDetails({Key key, @required this.model}) : super(key: key);
  @override
  _PatHisDetailsState createState() => _PatHisDetailsState();
}

class _PatHisDetailsState extends State<PatHisDetails> {
  double bmi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.green,
              ),
            ),
            title: Text(
              'Details',
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text(
              'Date : ${widget.model.date}  Time: ${widget.model.time}',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Physical Measurements',
              style: detHead,
            ),
          ),
          Material(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Height',
                    style: subHead,
                  ),
                  trailing: Text(
                      '${widget.model.ft} Ft  ${widget.model.inc} In',
                      style: subHead),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Weight',
                    style: subHead,
                  ),
                  trailing: Text('${widget.model.kg} Kg  ${widget.model.gm} Gm',
                      style: subHead),
                ),
                Divider(),
                FutureBuilder(
                    future: getBMI(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return ListTile(
                            title: Text(
                              'BMI Index',
                              style: subHead,
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                Text('Status : '),
                                bmi < 25
                                    ? (bmi < 23
                                        ? (bmi < 18.5
                                            ? Text(
                                                'UnderWeight',
                                                style: TextStyle(
                                                    color: Colors.blueGrey),
                                              )
                                            : Text('Normal',
                                                style: TextStyle(
                                                    color: Colors.green)))
                                        : Text('OverWeight',
                                            style: TextStyle(
                                                color: Colors.orange)))
                                    : Text('Obese',
                                        style:
                                            TextStyle(color: Colors.redAccent))
                              ],
                            ),
                            trailing: Text(
                              '$bmi',
                              style: subHead,
                            ));
                      }
                    }),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Symptoms',
              style: detHead,
            ),
            subtitle: Row(children: <Widget>[
              Text('Status : '),
              widget.model.status > 1
                  ? (widget.model.status > 2
                      ? FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(' Urgent Care Needed ',
                              style: TextStyle(color: Colors.redAccent)),
                        )
                      : Text(
                          ' Care Needed ',
                          style: TextStyle(color: Colors.orange),
                        ))
                  : Text(
                      'Good',
                      style: TextStyle(color: Colors.green),
                    ),
            ]),
          ),
          Material(
              color: Colors.white,
              child: Column(children: <Widget>[
                ListTile(
                  title: Text('Alergy'),
                  trailing: widget.model.alergy == 0
                      ? Text(
                          'No',
                          style: TextStyle(color: Colors.green),
                        )
                      : Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                ),
                Divider(),
                ListTile(
                  title: Text('Cold'),
                  trailing: widget.model.cold == 0
                      ? Text(
                          'No',
                          style: TextStyle(color: Colors.green),
                        )
                      : Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                ),
                Divider(),
                ListTile(
                  title: Text('Cough'),
                  trailing: widget.model.cough == 0
                      ? Text(
                          'No',
                          style: TextStyle(color: Colors.green),
                        )
                      : Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                ),
                Divider(),
                ListTile(
                  title: Text('Fever'),
                  trailing: widget.model.fever == 0
                      ? Text(
                          'No',
                          style: TextStyle(color: Colors.green),
                        )
                      : Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                ),
                Divider(),
                ListTile(
                  title: Text('Headache'),
                  trailing: widget.model.headache == 0
                      ? Text(
                          'No',
                          style: TextStyle(color: Colors.green),
                        )
                      : Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                ),
                Divider(),
                ListTile(
                  title: Text('Indigestion'),
                  trailing: widget.model.indigestion == 0
                      ? Text(
                          'No',
                          style: TextStyle(color: Colors.green),
                        )
                      : Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                ),
                Divider(),
              ]))
        ],
      )),
    );
  }

  Future getBMI() async {
    int inches = widget.model.ft * 12 + widget.model.inc;
    double met = inches / 39.37;
    double wet = widget.model.kg + (widget.model.gm / 100);
    bmi = wet / pow(met, 2);
    bmi = double.parse(bmi.toStringAsFixed(2));
    return bmi;
  }
}
