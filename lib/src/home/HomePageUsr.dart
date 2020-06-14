import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care/clips/HomeClip.dart';
import 'package:health_care/const/color_const.dart';
import 'package:health_care/src/forms/AgentCall.dart';
import 'package:health_care/src/forms/AgentForm.dart';

class HomePageUsr extends StatefulWidget {
  HomePageUsr({Key key}) : super(key: key);

  static const routeName = '/home';

  @override
  HomePageUsrState createState() => HomePageUsrState();
}

class HomePageUsrState extends State<HomePageUsr> {
  //var _scaffoldKey = GlobalKey<ScaffoldState>();

  void dispose() {
    super.dispose();
  }

  HomePageUsrState() {}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      body: Stack(children: <Widget>[
        ClipPath(
          clipper: HomeClip(),
          child: Container(
            color: lightGreen,
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[200],
                  ),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/img/doctor3.png',
                      )),
                ),
                height: height * 0.3,
                width: width,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              newPatient(height, width),
              SizedBox(
                height: height * 0.03,
              ),
              existPatient(height, width),
              SizedBox(
                height: height * 0.05,
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget newPatient(double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
      height: height * 0.13,
      width: width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10,
        child: DecoratedBox(
          decoration: BoxDecoration(
            //border: Border.all(color: Colors.deepOrange),
            borderRadius: BorderRadius.circular(10.0),
            // gradient: LinearGradient(
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //     colors: [Colors.deepOrange[200], Colors.deepOrange[50]]),
          ),
          child: Material(
            type: MaterialType.transparency,
            elevation: 6.0,
            color: Colors.transparent,
            shadowColor: Colors.grey[50],
            child: InkWell(
              splashColor: Colors.deepOrange[100],
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AgentCall()));
              },
              child: ListTile(
                leading: Image.asset('assets/logo/newpat.png'),
                title: Text(
                  'New Patient',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  children: <Widget>[
                    Divider(),
                    Text('Setup a New Patient Account')
                  ],
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  existPatient(double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
      height: height * 0.13,
      width: width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10,
        child: DecoratedBox(
          decoration: BoxDecoration(
            //   border: Border.all(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(10.0),
            // gradient: LinearGradient(
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //     colors: [Colors.deepPurple[200], Colors.deepPurple[50]]),
          ),
          child: Material(
            type: MaterialType.transparency,
            elevation: 6.0,
            color: Colors.transparent,
            shadowColor: Colors.grey[50],
            child: InkWell(
              splashColor: Colors.deepPurple[100],
              onTap: () {
                //Navigator.pushReplacementNamed(context, '/agent');
              },
              child: ListTile(
                leading: Image.asset('assets/logo/existpat.png'),
                title: Text(
                  'Existing Patient',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(children: <Widget>[
                  Divider(),
                  Text('Search for a patient, Add Health Updates'),
                ]),
                isThreeLine: true,
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 60);
    var fcontrol = Offset(size.width * 0.25, size.height - 20);
    var fend = Offset(size.width * 0.5, size.height - 10);
    path.quadraticBezierTo(fcontrol.dx, fcontrol.dy, fend.dx, fend.dy);

    var scontrol = Offset(size.width * 0.75, size.height - 20);
    var send = Offset(size.width, size.height - 60);
    path.quadraticBezierTo(scontrol.dx, scontrol.dy, send.dx, send.dy);
    path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
