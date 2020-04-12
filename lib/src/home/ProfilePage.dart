import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care/auth/SignIn.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  final String title = "Carousel Demo";

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  //var _scaffoldKey = GlobalKey<ScaffoldState>();
  String email = '';
  bool load = true;
  void dispose() {
    super.dispose();
  }

  ProfilePageState() {
    getuser();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            load == true ? CircularProgressIndicator() : Text(email),
            RaisedButton(
              onPressed: () {
                signOutGoogle().whenComplete(() {
                  Navigator.pushReplacementNamed(context, '/');
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
