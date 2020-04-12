import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care/auth/LoginPage.dart';

import 'SignIn.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String email = '';
  bool load = true;
  @override
  Widget build(BuildContext context) {
    getuser();
    return Scaffold(
      appBar: AppBar(
        title: Text('GSign'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            load == true ? CircularProgressIndicator() : Text(email),
            RaisedButton(
              onPressed: () {
                signOutGoogle().whenComplete(() {
                  Navigator.of(context).pop();
                });
              },
              child: Text('SignOut'),
            )
          ],
        ),
      ),
    );
  }

  getuser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    email = user.email;
    Future.delayed(const Duration(milliseconds: 2000), () {
// Here you can write your code
      if (this.mounted) {
        setState(() {
          load = false;
          // Here you can write your code for open new view
        });
      }
    });
  }
}
