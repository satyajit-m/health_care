import 'package:flutter/material.dart';

import 'package:health_care/const/route_constants.dart';
import 'package:health_care/services/router_models.dart';

// Should be called on the initState of the auth mandatory page
// after firebaseUser is found to be null
// parameter : Router of the page that requires auth

// How it works?
// It checks for authentication. If no authentication is found, it calls the auth page.
// The current page is pushReplaced after authentication.

// TODO : Test what is printed on cancelling the auth
// by pressing back button
void signInGate(BuildContext context, String destination) {
  Navigator.pop(context);
  Navigator.pushNamed(
    context,
    LoginRoute,
    arguments: Destination(destination, PhoneLoginRoute),
  );
}
