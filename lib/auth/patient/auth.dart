import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health_care/auth/patient/widgets/mobile_button.dart';

import 'package:health_care/const/login_state.dart';
import 'package:health_care/const/route_constants.dart';
import 'package:health_care/services/router_models.dart';

import 'widgets/google_button.dart';

class Auth extends StatefulWidget {

  final Destination next;
  const Auth({ Key key, @required this.next }): super(key: key);
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  ValueNotifier<int> _loginStatus = ValueNotifier(LoginState.waiting);

  @override
  initState() {
    getCurrentUser();

    super.initState();
  }

  void getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(widget.next.route);
    print(widget.next.popUntilRoute);
    if (user == null) {
      _loginStatus.value = LoginState.notLoggedIn;
    } else {
      Navigator.of(context).pushReplacementNamed(widget.next.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double buttonWidth = width = 0.80 * width;

    final Destination args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      // backgroundColor: Color.fromRGBO(227, 227, 227, 1),
      body: SafeArea(
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: _loginStatus,
            builder: (BuildContext context, int currentState, Widget child) {
              if (currentState == LoginState.waiting) {
                return CircularProgressIndicator();
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: buttonWidth,
                      child: Image(
                        image: AssetImage('assets/img/shopping_app.png'),
                      ),
                    ),
                    MobileSignInButton(
                      minWidth: buttonWidth,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          PhoneLoginRoute,
                          arguments: widget.next,
                        );
                      },
                    ),
                    // Divider
                    Row(
                      children: [
                        hr(context, 60.0, 10.0),
                        Text("OR"),
                        hr(context, 10.0, 60.0),
                      ],
                    ),
                    // OAuth
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GoogleSignInButton(
                          minWidth: buttonWidth,
                          onPressed: () {
                            print("ok Google4");
                          },
                        ),
                        // Divider for Oauths
                        Divider(
                          height: height * 0.02,
                          color: Colors.transparent,
                        ),
                        // FacebookSignInButton(
                        //   minWidth: buttonWidth,
                        //   onPressed: () {
                        //     print("ok Facebook");
                        //   },
                        // ),
                        MaterialButton(
                          onPressed: () {},
                          child: Text(
                            'Take a PeekaBoo',
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget hr(BuildContext context, double left, double right) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: left, right: right),
        child: Divider(
          color: Colors.black,
          height: 1,
        ),
      ),
    );
  }
}
