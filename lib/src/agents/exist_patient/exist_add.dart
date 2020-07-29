import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_care/const/color_const.dart';
import 'package:health_care/services/Dialogs.dart';
import 'package:intl/intl.dart';

class ExistPatAdd extends StatefulWidget {
  final String phone;
  const ExistPatAdd({Key key, @required this.phone}) : super(key: key);
  @override
  _ExistPatAddState createState() => _ExistPatAddState();
}

class _ExistPatAddState extends State<ExistPatAdd> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  TextEditingController wt = new TextEditingController();
  TextEditingController ht = new TextEditingController();
  int ft;
  int inc;
  int kg;
  int gm;
  var r = [0, 0, 0, 0, 0, 0];

  bool add = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: RawMaterialButton(
                      elevation: 0.0,
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: darkGreen,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      constraints: BoxConstraints.tightFor(
                        width: 40.0,
                        height: 40.0,
                      ),
                      shape: CircleBorder(),
                      fillColor: Colors.white24),
                ),
                SizedBox(
                  width: 25,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'New Health Updates',
                    style: GoogleFonts.roboto(
                        fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              controller: ht,
              readOnly: true,
              onTap: () {
                showPickerHeight(context);
              },
              decoration: InputDecoration(
                  hintText: 'Select Height',
                  labelText: 'Height',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: darkGreen))),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              readOnly: true,
              controller: wt,
              onTap: () {
                showPickerWeight(context);
              },
              decoration: InputDecoration(
                  hintText: 'Select Weight',
                  labelText: 'Weight',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: darkGreen))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.deepOrange[50],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    //padding: EdgeInsets.symmetric(horizontal: -10),
                    child: Center(
                        child: Text(
                      'Select Yes / No for Symptoms',
                      style: TextStyle(fontSize: 18),
                    )),
                  ),
                  Divider(height: 1.0),
                  headache(),
                  Divider(height: 1.0),
                  fever(),
                  Divider(height: 1.0),
                  indigestion(),
                  Divider(height: 1.0),
                  cough(),
                  Divider(height: 1.0),
                  cold(),
                  Divider(height: 1.0),
                  rashes(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          add == true
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  child: RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: darkGreen)),
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    child: Text('+  Add Update'),
                    color: Colors.green.withOpacity(0.8),
                  ),
                )
              : SizedBox(),
        ]),
      ),
    );
  }

  uploadData() async {
    int count = 0;

    for (var i in r) {
      if (i == 1) {
        ++count;
      }
    }
    final _firestore = Firestore.instance;
    var dt = DateTime.now();
    var dateform = DateFormat("dd-MM-yyyy");
    var timeform = DateFormat("Hm");

    String updatedDt = dateform.format(dt);
    String updatedTm = timeform.format(dt);

    await _firestore.runTransaction((transaction) async {
      await transaction
          .set(
              _firestore
                  .collection('users')
                  .document(widget.phone)
                  .collection('health')
                  .document(updatedDt),
              {
                'date': updatedDt,
                'time': updatedTm,
                'height': {'ft': ft ?? 0, 'inc': inc ?? 0},
                'weight': {'kg': kg ?? 0, 'gm': gm ?? 0},
                'hedache': r[0],
                'fever': r[1],
                'indigestion': r[2],
                'cough': r[3],
                'cold': r[4],
                'alergy': r[5],
                'status': count,
                'stamp': dt,
              })
          .catchError((e) {
            print(e);
          })
          .whenComplete(() {})
          .catchError((e) {
            print(e);
            return false;
          });
    }).whenComplete(() {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      showInSnackBar('New Health Data Uploaded ');

      Future.delayed(const Duration(milliseconds: 3000), () {
        Navigator.of(context).pop();

        // Navigator.of(context).pop();
      });
    });
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    ));
  }

  showPickerHeight(BuildContext context) {
    new Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(
            begin: 0,
            end: 7,
          ),
          NumberPickerColumn(begin: 0, end: 11),
        ]),
        delimiter: [
          PickerDelimiter(
              child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[Icon(Icons.more_vert)],
            ),
          ))
        ],
        hideHeader: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FittedBox(fit: BoxFit.fitWidth, child: Text('Feet')),
            FittedBox(fit: BoxFit.fitWidth, child: Text('Inches')),
          ],
        ),
        onConfirm: (Picker picker, List value) {
          ft = value[0];
          inc = value[1];
          ht.text = ' $ft  Feet  $inc  Inches';
        }).showDialog(context);
  }

  showPickerWeight(BuildContext context) {
    new Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: 100),
          NumberPickerColumn(begin: 0, end: 900, jump: 100),
        ]),
        delimiter: [
          PickerDelimiter(
              child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[Icon(Icons.more_vert)],
            ),
          ))
        ],
        hideHeader: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FittedBox(fit: BoxFit.fitWidth, child: Text('Kg')),
            FittedBox(fit: BoxFit.fitWidth, child: Text('Gm')),
          ],
        ),
        onConfirm: (Picker picker, List value) {
          kg = value[0];
          gm = value[1] * 100;
          wt.text = ' $kg  Kg  $gm  Gm';
        }).showDialog(context);
  }

  Widget headache() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Headache ',
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ))),
          ),
          Expanded(
            child: Row(children: <Widget>[
              Radio(
                  value: 1,
                  groupValue: r[0],
                  onChanged: (val) {
                    setState(() {
                      r[0] = val;
                    });
                  }),
              Text(
                'Yes',
                style: new TextStyle(fontSize: 16.0),
              ),
            ]),
          ),
          Expanded(
            child: Row(children: <Widget>[
              Radio(
                  value: 0,
                  groupValue: r[0],
                  onChanged: (val) {
                    setState(() {
                      r[0] = val;
                    });
                  }),
              Text(
                'No',
                style: new TextStyle(fontSize: 16.0),
              ),
            ]),
          ),
        ]);
  }

  fever() {
    return Material(
      color: Colors.grey[50],
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  ' Fever ',
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                )),
          ),
        ),
        Expanded(
          child: Row(children: <Widget>[
            Radio(
                value: 1,
                groupValue: r[1],
                onChanged: (val) {
                  setState(() {
                    r[1] = val;
                  });
                }),
            Text(
              'Yes',
              style: new TextStyle(fontSize: 16.0),
            ),
          ]),
        ),
        Expanded(
          child: Row(children: <Widget>[
            Radio(
                value: 0,
                groupValue: r[1],
                onChanged: (val) {
                  setState(() {
                    r[1] = val;
                  });
                }),
            Text(
              'No',
              style: new TextStyle(fontSize: 16.0),
            ),
          ]),
        ),
      ]),
    );
  }

  indigestion() {
    return Row(children: <Widget>[
      Expanded(
        flex: 2,
        child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  ' Indigestion ',
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ))),
      ),
      Expanded(
        child: Row(children: <Widget>[
          Radio(
              value: 1,
              groupValue: r[2],
              onChanged: (val) {
                setState(() {
                  r[2] = val;
                });
              }),
          Text(
            'Yes',
            style: new TextStyle(fontSize: 16.0),
          ),
        ]),
      ),
      Expanded(
        child: Row(children: <Widget>[
          Radio(
              value: 0,
              groupValue: r[2],
              onChanged: (val) {
                setState(() {
                  r[2] = val;
                });
              }),
          Text(
            'No',
            style: new TextStyle(fontSize: 16.0),
          ),
        ]),
      ),
    ]);
  }

  cough() {
    return Material(
      color: Colors.grey[50],
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        ' Cough ',
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      )),
                )),
            Expanded(
              child: Row(children: <Widget>[
                Radio(
                    value: 1,
                    groupValue: r[3],
                    onChanged: (val) {
                      setState(() {
                        r[3] = val;
                      });
                    }),
                Text(
                  'Yes',
                  style: new TextStyle(fontSize: 16.0),
                ),
              ]),
            ),
            Expanded(
              child: Row(children: <Widget>[
                Radio(
                    value: 0,
                    groupValue: r[3],
                    onChanged: (val) {
                      setState(() {
                        r[3] = val;
                      });
                    }),
                Text(
                  'No',
                  style: new TextStyle(fontSize: 16.0),
                ),
              ]),
            ),
          ]),
    );
  }

  cold() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: Text(
                    ' Cold / Runnning Nose ',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              )),
          Expanded(
            child: Row(children: <Widget>[
              Radio(
                  value: 1,
                  groupValue: r[4],
                  onChanged: (val) {
                    setState(() {
                      r[4] = val;
                    });
                  }),
              Text(
                'Yes',
                style: new TextStyle(fontSize: 16.0),
              ),
            ]),
          ),
          Expanded(
            child: Row(children: <Widget>[
              Radio(
                  value: 0,
                  groupValue: r[4],
                  onChanged: (val) {
                    setState(() {
                      r[4] = val;
                    });
                  }),
              Text(
                'No',
                style: new TextStyle(fontSize: 16.0),
              ),
            ]),
          ),
        ]);
  }

  rashes() {
    return Material(
      color: Colors.grey[50],
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        ' Allergy/Skin Redness ',
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      )),
                )),
            Expanded(
              child: Row(children: <Widget>[
                Radio(
                    value: 1,
                    groupValue: r[5],
                    onChanged: (val) {
                      setState(() {
                        r[5] = val;
                      });
                    }),
                Text(
                  'Yes',
                  style: new TextStyle(fontSize: 16.0),
                ),
              ]),
            ),
            Expanded(
              child: Row(children: <Widget>[
                Radio(
                    value: 0,
                    groupValue: r[5],
                    onChanged: (val) {
                      setState(() {
                        r[5] = val;
                      });
                    }),
                Text(
                  'No',
                  style: new TextStyle(fontSize: 16.0),
                ),
              ]),
            ),
          ]),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () async {
        setState(() {
          add = false;
        });
        Navigator.of(context).pop(); // dismiss dialog
        ProgressDialog.showLoadingDialog(context, _keyLoader);
        await uploadData();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text(
          "Are you sure you want to proceed updating new health details ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
