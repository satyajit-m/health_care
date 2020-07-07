import 'package:flutter/material.dart';
import 'package:health_care/const/color_const.dart';
import 'package:health_care/const/route_constants.dart';
import 'package:health_care/core/functions/Dialog.dart';
import 'package:health_care/src/forms/AreaApi/AreaModel.dart';
import 'package:health_care/src/forms/AreaApi/Repository.dart';
import 'package:health_care/src/forms/blocs/bloc.dart';
import 'package:health_care/src/forms/blocs/provider.dart';
import 'package:intl/intl.dart';

class NewPatForm extends StatefulWidget {
  NewPatForm() {}
  @override
  _NewPatFormState createState() => _NewPatFormState();
}

class _NewPatFormState extends State<NewPatForm> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int currentStep = 0;
  bool complete = false;
  int length = 0;
  var fetchAdr = 0;
  List<String> area = ['Select Area'];

  String _selectedDate = 'Tap to select date';
  TextEditingController dateCtl = TextEditingController();

  TextEditingController pinCtl = TextEditingController();
  TextEditingController blockCtl = TextEditingController();
  TextEditingController divCtl = TextEditingController();
  TextEditingController distCtl = TextEditingController();
  TextEditingController stateCtl = TextEditingController();

  TextEditingController gIdCtl = TextEditingController();

  String _radioValue1 = 'none';
  String fwd = "Proceed";
  final String bck = "Back";
  String dropdownValue = 'Select Area';

  bool finalSubmit = false;

  goTo(int step) {
    setState(() => currentStep = step);
  }

  next() {
    if (currentStep == length - 2) {
      fwd = "Complete";
    }
    if (currentStep + 1 != length) {
      goTo(currentStep + 1);
    }
  }

  cancel() {
    if (currentStep == length - 1) {
      fwd = "Proceed";
    }
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  Future<void> _selectDate(BuildContext context, Bloc bloc) async {
    final DateTime d = await showDatePicker(
      //we wait for the dialog to return
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    if (d != null) //if the user has selected a date
      setState(() {
        // we format the selected date and assign it to the state variable
        _selectedDate = new DateFormat.yMMMd("en_US").format(d);
        //bloc.changeDate(_selectedDate);
        dateCtl.text = _selectedDate;
      });
  }

  List<Step> getSteps(Bloc bloc, BuildContext context) {
    List<Step> steps = [
      personalStep(bloc),
      addressStep(bloc, context),
      idStep(bloc)
    ];
    length = steps.length;
    return steps;
  }

  var bloc = Bloc();
  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);

    return Provider(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
          backgroundColor: accentColor,
          title: Text('New Patient - Create Account'),
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: Stepper(
              type: StepperType.vertical,
              steps: getSteps(bloc, context),
              currentStep: currentStep,
              controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                return StreamBuilder(
                    stream: bloc.showProgress,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (!snapshot.hasData) {
                        return Row(children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: RaisedButton(
                              child: Text('Back'),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              color: Colors.deepOrangeAccent,
                              onPressed: onStepCancel,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 2,
                            child: StreamBuilder(
                                stream: currentStep < 2
                                    ? bloc.firstPatSubmit
                                    : bloc.patId,
                                builder: (context, snapshot) {
                                  return RaisedButton(
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    child: Text(fwd),
                                    splashColor: Colors.white,
                                    onPressed: snapshot.hasData
                                        ? currentStep == 2
                                            ? bloc.submitPat
                                            : next
                                        : null,
                                  );
                                }),
                          )
                        ]);
                      } else {
                        if (!snapshot.data) {
                          // Scaffold.of(context).showSnackBar(
                          //     SnackBar(content: Text('Data Upload Success')));
                          // Navigator.pop(context);

                          return Column(
                            children: <Widget>[
                              Text("Account Creation Success"),
                              RaisedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Exit'),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                    });
              },
              onStepContinue: next,
              onStepCancel: cancel,
            ),
          ),
        ]),
      ),
    );
  }

  void _handleRadioValueChange1(String value) {
    setState(() {
      _radioValue1 = value;
    });
  }

  Step personalStep(Bloc bloc) {
    return Step(
      title: const Text('Personal Details'),
      isActive: currentStep >= 0,
      state: currentStep >= 0 ? StepState.complete : StepState.disabled,
      content: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.person_outline,
            ),
            title: StreamBuilder(
              stream: bloc.name,
              builder: (context, snapshot) {
                return TextField(
                    onChanged: bloc.changeName,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                      hintText: 'John Doe',
                      labelText: 'Patient Name',
                      errorText: snapshot.error,
                    ));
              },
            ),
          ),
          ListTile(
              leading: Icon(Icons.mail_outline),
              title: StreamBuilder(
                  stream: bloc.patemail,
                  builder: (context, snapshot) {
                    return TextField(
                      onChanged: bloc.changePatEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'john@abc.com',
                        labelText: 'Email Id',
                        errorText: snapshot.error,
                      ),
                    );
                  })),
          ListTile(
            leading: Icon(Icons.phone),
            title: StreamBuilder(
              stream: bloc.phone,
              builder: (context, snapshot) {
                return TextField(
                  onChanged: bloc.changePhone,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: '0123456789',
                    labelText: 'PhoneNo.',
                    errorText: snapshot.error,
                  ),
                );
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.date_range),
            title: StreamBuilder(
                stream: bloc.date,
                builder: (context, snapshot) {
                  return TextField(
                    controller: dateCtl,
                    showCursor: false,
                    onTap: () {
                      _selectDate(context, bloc);
                    },
                    onChanged: bloc.changeDate(dateCtl.text),
                    keyboardType: TextInputType.datetime,
                    maxLength: 15,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'January 1,2000',
                      labelText: 'Date Of Birth.',
                    ),
                  );
                }),
          ),
          ListTile(
            leading: Icon(Icons.person_pin),
            title: Text('Gender'),
            subtitle: StreamBuilder(
                stream: bloc.date,
                builder: (context, snapshot) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Radio(
                            value: 'Male',
                            groupValue: _radioValue1,
                            onChanged: (String val) {
                              bloc.changeGender(val);
                              _handleRadioValueChange1(val);
                            }),
                        new Text(
                          'Male',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                            value: 'Female',
                            groupValue: _radioValue1,
                            onChanged: (String val) {
                              bloc.changeGender(val);
                              _handleRadioValueChange1(val);
                            }),
                        new Text(
                          'Female',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ]);
                }),
          ),
        ],
      ),
    );
  }

  Step addressStep(Bloc bloc, BuildContext context) {
    return Step(
      title: const Text('Address'),
      isActive: currentStep >= 1,
      state: currentStep >= 1 ? StepState.complete : StepState.disabled,
      content: Column(
        children: <Widget>[
          Text('Enter Pincode and Select Area to Locate your Address'),
          ListTile(
            title: StreamBuilder(
              stream: bloc.pin,
              builder: (context, snapshot) {
                return TextField(
                  keyboardType: TextInputType.number,
                  controller: pinCtl,
                  onChanged: bloc.changePin,
                  decoration: new InputDecoration(
                      hintText: 'Central Delhi - 110001',
                      labelText: 'Pincode',
                      errorText: snapshot.error),
                  maxLength: 6,
                );
              },
            ),
            trailing: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  area = ['Select Area'];
                  _handleSearch(context, pinCtl.text.toString());
                }),
          ),
          fetchAdr == 1
              ? Column(
                  children: <Widget>[
                    ListTile(
                      title: StreamBuilder(
                        stream: bloc.area,
                        builder: (context, snapshot) {
                          return DropdownButton<String>(
                              isExpanded: true,
                              value: dropdownValue,
                              icon: Icon(
                                Icons.arrow_downward,
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue) {
                                bloc.changeArea(newValue);
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: area.map((String value) {
                                return DropdownMenuItem<String>(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList());
                        },
                      ),
                    ),
                    StreamBuilder(
                        stream: bloc.block,
                        builder: (context, snapshot) {
                          return ListTile(
                            title: TextField(
                              keyboardType: TextInputType.number,
                              enabled: false,
                              onChanged: bloc.changeBlock(blockCtl.text),
                              style: TextStyle(color: Colors.grey),
                              controller: blockCtl,
                              decoration: new InputDecoration(
                                labelText: 'Block',
                              ),
                              //maxLength: 6,
                            ),
                          );
                        }),
                    StreamBuilder(
                        stream: bloc.city,
                        builder: (context, snapshot) {
                          return ListTile(
                            title: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: bloc.changeCity(divCtl.text),
                              controller: divCtl,
                              enabled: false,
                              style: TextStyle(color: Colors.grey),
                              decoration: new InputDecoration(
                                labelText: 'City',
                              ),
                              //maxLength: 6,
                            ),
                          );
                        }),
                    StreamBuilder(
                        stream: bloc.district,
                        builder: (context, snapshot) {
                          return ListTile(
                            title: TextField(
                              keyboardType: TextInputType.number,
                              controller: distCtl,
                              enabled: false,
                              onChanged: bloc.changeDistrict(distCtl.text),
                              style: TextStyle(color: Colors.grey),
                              decoration: new InputDecoration(
                                labelText: 'District',
                              ),
                              //maxLength: 6,
                            ),
                          );
                        }),
                    StreamBuilder(
                        stream: bloc.state,
                        builder: (context, snapshot) {
                          return ListTile(
                            title: TextField(
                              keyboardType: TextInputType.number,
                              enabled: false,
                              onChanged: bloc.changeState(stateCtl.text),
                              style: TextStyle(color: Colors.grey),
                              controller: stateCtl,
                              decoration: new InputDecoration(
                                labelText: 'State',
                              ),
                              //maxLength: 6,
                            ),
                          );
                        }),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Step idStep(Bloc bloc) {
    return Step(
      title: const Text('Identification Details'),
      isActive: currentStep >= 2,
      state: currentStep >= 2 ? StepState.complete : StepState.disabled,
      content: Column(
        children: <Widget>[
          StreamBuilder(
            stream: bloc.patId,
            builder: (context, snapshot) {
              return TextField(
                onChanged: bloc.changePatID,
                keyboardType: TextInputType.number,
                maxLength: 12,
                decoration: InputDecoration(
                  hintText: '012345678912',
                  labelText: 'Enter 12digit UID ',
                  errorText: snapshot.error,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void callArea(String pin) async {
    area = ['Select Area'];
    Map<String, dynamic> adr = await fetchArea(pin);
    print(adr.length);
    if (adr.length > 0) {
      List<AreaModel> area1 = adr['ar'].toList();
      for (var i in area1) {
        area.add(i.name.toString());
      }
      blockCtl.text = adr['block'].toString();
      divCtl.text = adr['divison'].toString();
      distCtl.text = adr['district'].toString();
      stateCtl.text = adr['state'].toString();
    }
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

    if (adr.length == 0) {
      showAlertDialog(context, 'Invalid Pincode',
          'The Pincode You have Entered Is Incorrect');
    }
    //close the dialoge
    setState(() {
      fetchAdr = 1;
    });
    //fetchAdr = 0;
  }

  Future<void> _handleSearch(BuildContext context, String string) async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader, 'Fetching Locations');
      callArea(string);
    } catch (error) {
      print(error);
    }
  }

  showAlertDialog(BuildContext context, String title, String content) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        if (title == "Success") {
          Navigator.pop(context);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
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
