import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_care/const/color_const.dart';
import 'package:health_care/const/size_config.dart';
import 'package:health_care/core/models/UserProf.dart';

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
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RawMaterialButton(
                    elevation: 10.0,
                    child: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    constraints: BoxConstraints.tightFor(
                      width: 40.0,
                      height: 40.0,
                    ),
                    shape: CircleBorder(),
                    fillColor: Colors.white),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal:10.0),
              child: Card(
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
              height: 15,
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 10),
              elevation: 8,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.indigo, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                type: MaterialType.transparency,
                elevation: 6.0,
                color: Colors.transparent,
                shadowColor: Colors.grey[50],
                child: InkWell(
                  splashColor: Colors.indigo[100],
                  onTap: () {},
                  child: ListTile(
                    leading: Icon(
                      Icons.playlist_add,
                      color: Colors.indigo,
                    ),
                    title: Text(
                      'Proceed To Questionnaire',
                      style: GoogleFonts.sourceSansPro(
                          color: Colors.indigo, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.indigo,
                    ),
                  ),
                ),
              ),
            )
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
