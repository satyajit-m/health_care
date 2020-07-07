import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care/const/color_const.dart';
import 'package:health_care/const/route_constants.dart';
import 'package:health_care/services/router_models.dart';

import 'SignIn.dart';

class LoginPage extends StatefulWidget {
  final Destination next;
  const LoginPage({Key key, @required this.next}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseUser user;
  bool load = true;

  _LoginPageState() {}

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => Future(() {
          getUser();
        }));
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
        body: load == true
            ? Center(child: CircularProgressIndicator())
            : (Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _rHealthLogo(h, w),
                      _docImage(h, w),
                      _signInButton(h, w),
                      _phoneSignIn(h, w)
                    ],
                  ),
                ),
              )));
  }

  Widget _rHealthLogo(h, w) {
    return Container(
      child: Image(
        image: AssetImage('assets/logo/main_logo.png'),
        height: h * 0.15,
      ),
    );
  }

  Widget _docImage(h, w) {
    return Image(
      image: AssetImage("assets/img/doctor1.png"),
      height: h * 0.3,
      width: w,
    );
  }

  //Google Sign In for Health Workers
  Widget _signInButton(h, w) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              width: 8,
            ),
            Expanded(child: Divider()),
            Expanded(
              child: Center(child: Text('For Health Workers')),
              flex: 2,
            ),
            Expanded(child: Divider()),
            SizedBox(
              width: 8,
            ),
          ],
        ),
        SizedBox(
          height: h * 0.02,
        ),
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(width: 2, color: Colors.green[300])),
          margin: EdgeInsets.symmetric(horizontal: w * 0.1),
          //elevation: 10.0,
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            borderOnForeground: true,
            color: Colors.white,
            child: InkWell(
              onTap: () {
                this.setState(() {
                  load = true;
                });
                signInWithGoogle().whenComplete(() async {
                  FirebaseUser user = await FirebaseAuth.instance.currentUser();
                  var email = user.email;

                  final snapShot = await Firestore.instance
                      .collection('admin')
                      .document(email)
                      .get();
                  if (snapShot.exists) {
                    Navigator.of(context).popUntil((route) => route.isFirst);

                    Navigator.pushReplacementNamed(context, AgentHomeRoute);
                  } else {
                    setState(() {
                      load = false;
                    });
                    Navigator.pushNamed(context, AgentFormRoute);
                  }
                }).catchError((error) {
                  this.setState(() {
                    load = false;
                  });
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: h * 0.008),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Image(
                          image: AssetImage("assets/logo/google_logo.png"),
                          height: h * 0.04,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Sign In With Google',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: h * 0.023),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //Phone Sign In for Patients

  Widget _phoneSignIn(h, w) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              width: 8,
            ),
            Expanded(child: Divider()),
            Expanded(
              child: Center(child: Text('For Registered Patients')),
              flex: 2,
            ),
            Expanded(child: Divider()),
            SizedBox(
              width: 8,
            ),
          ],
        ),
        SizedBox(
          height: h * 0.02,
        ),
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(width: 2, color: Colors.green[300])),
          margin: EdgeInsets.symmetric(horizontal: w * 0.1),
          //elevation: 10.0,
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            borderOnForeground: true,
            color: Colors.white,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  PhoneLoginRoute,
                  arguments: widget.next,
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: h * 0.008),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                          child: Icon(Icons.phone,
                              size: h * 0.04, color: phoneLoginIcon)),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Sign In With Phone',
                          style: TextStyle(
                              color: phoneLoginText,
                              fontWeight: FontWeight.bold,
                              fontSize: h * 0.023),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void getUser() async {
    final _auth = FirebaseAuth.instance;
    user = await _auth.currentUser();
    if (user != null) {
      var email = user.email;
      if ((email == "") || (user.email == null)) {
        Navigator.pushReplacementNamed(context, PatHomeRoute);
      } else {
        final snapShot =
            await Firestore.instance.collection('admin').document(email).get();
        if (snapShot.exists) {
          Navigator.pushReplacementNamed(context, AgentHomeRoute);
        } else {
          setState(() {
            load = false;
          });
          Navigator.pushNamed(context, AgentFormRoute);
        }
      }
    } else {
      setState(() {
        load = false;
      });
    }
  }
}
