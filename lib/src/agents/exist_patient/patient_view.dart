import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_care/const/color_const.dart';
import 'package:health_care/const/route_constants.dart';
import 'package:health_care/const/size_config.dart';
import 'package:health_care/core/models/UserProf.dart';
import 'package:health_care/src/agents/exist_patient/pat_history.dart';

class PatientView extends StatefulWidget {
  final UserProf prof;
  const PatientView({Key key, @required this.prof}) : super(key: key);

  @override
  _PatientViewState createState() => _PatientViewState();
}

class _PatientViewState extends State<PatientView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
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
                        'Patient Dashboard',
                        style: GoogleFonts.roboto(
                            fontSize: 25, fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 15,
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 15),
              elevation: 8,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.deepOrange[300], width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                type: MaterialType.transparency,
                elevation: 6.0,
                color: Colors.transparent,
                shadowColor: Colors.grey[50],
                child: Material(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.deepOrange, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Colors.deepOrange[300],
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: () {
                      Navigator.of(context).pushNamed(ExistAddRoute,
                          arguments: widget.prof.personal.phone);
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.playlist_add,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Add New Helth Update',
                        style: GoogleFonts.sourceSansPro(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 15),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.green, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ExpansionTile(
                  title: Text('Patient Info'),
                  children: <Widget>[getPatient(), getAddress(), getId()],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Divider(
              height: 2,
            ),
            Container(
              color: Colors.indigo,
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
            patHistory(context, widget.prof.personal.phone)
          ],
        ),
      ),
    );
  }

  Widget getPatient() {
    return ExpansionTile(
      backgroundColor: Colors.indigo[50],
      title: Text('Personal Info'),
      children: <Widget>[
        ListTile(
          leading: Text(
            'Name :',
            style: TextStyle(fontSize: 17),
          ),
          title: Text(
            '${widget.prof.personal.name}',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ListTile(
          leading: Text('Email :', style: TextStyle(fontSize: 17)),
          title: Text(
            '${widget.prof.personal.email}',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ListTile(
          leading: Text('Phone :', style: TextStyle(fontSize: 17)),
          title: Text(
            '${widget.prof.personal.phone}',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ListTile(
          leading: Text('DOB :', style: TextStyle(fontSize: 17)),
          title: Text(
            '${widget.prof.personal.dob}',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ListTile(
          leading: Text('Gender :', style: TextStyle(fontSize: 17)),
          title: Text(
            '${widget.prof.personal.gender}',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget getAddress() {
    return ExpansionTile(
      backgroundColor: Colors.cyan[50],
      title: Text('Address'),
      children: <Widget>[
        ListTile(
          leading: Text(
            'Area :',
            style: TextStyle(fontSize: 17),
          ),
          title: Text(
            '${widget.prof.address.area}',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ListTile(
          leading: Text('Email :', style: TextStyle(fontSize: 17)),
          title: Text(
            '${widget.prof.address.block}',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ListTile(
          leading: Text('Phone :', style: TextStyle(fontSize: 17)),
          title: Text(
            '${widget.prof.address.city}',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ListTile(
          leading: Text('DOB :', style: TextStyle(fontSize: 17)),
          title: Text(
            '${widget.prof.address.district}',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ListTile(
          leading: Text('Gender :', style: TextStyle(fontSize: 17)),
          title: Text(
            '${widget.prof.address.state}',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ListTile(
          leading: Text('Gender :', style: TextStyle(fontSize: 17)),
          title: Text(
            '${widget.prof.address.pincode}',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget getId() {
    return ExpansionTile(
      backgroundColor: Colors.deepOrange[50],
      title: Text('Identification'),
      children: <Widget>[
        ListTile(
          leading: Text(
            'Id :',
            style: TextStyle(fontSize: 17),
          ),
          title: Text(
            '${widget.prof.id.gid}',
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }
}
