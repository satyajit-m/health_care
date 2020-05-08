import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care/src/App.dart';

import 'SignIn.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseUser user;
  bool load = true;

  _LoginPageState() {
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
        body: load == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _rHealthLogo(h, w),
                      SizedBox(
                        height: h * 0.12,
                      ),
                      _docImage(h, w),
                      SizedBox(
                        height: h * 0.12,
                      ),
                      _signInButton(h, w),
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

  Widget _signInButton(h, w) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(width: 2.5, color: Colors.green[200])),
      margin: EdgeInsets.symmetric(horizontal: w * 0.1),
      elevation: 10.0,
      color: Colors.white,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        borderOnForeground: true,
        color: Colors.white,
        child: InkWell(
          onTap: () {
            signInWithGoogle().whenComplete(() {
              Navigator.pushReplacementNamed(context, '/home');

              // setState(() {});
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
    );
  }

  void getUser() async {
    user = await FirebaseAuth.instance.currentUser();
    print(user);
    Future.delayed(const Duration(milliseconds: 100), () {
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          load = false;
        });
      }
    });
  }
}
