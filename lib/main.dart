import 'package:flutter/material.dart';
import 'package:health_care/auth/LoginPage.dart';
import 'package:health_care/src/App.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // MyApp() {
  //   //Navigation.initPaths();
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Color(0xFF52DA75),
        primaryColor: Color(0xFF32C96C),
        iconTheme: IconThemeData(color: Color(0xFF32C96C)),
      
      ),
      //onGenerateRoute: Navigation.router.generator,
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => LoginPage(),
       '/home': (context) => App(),
        //'/phoneAuth': (context) => PhoneAuth(),
        //'/profile/form': (context) => ProfileForm(),
        //'/profile/myOrders': (context) => MyOrders(FirebaseUser user),
      },
    );
  }
}
