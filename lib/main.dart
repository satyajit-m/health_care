import 'package:flutter/material.dart';
import 'package:health_care/OnBoard.dart';
import 'package:health_care/auth/LoginPage.dart';
import 'package:health_care/push_notifications.dart';
import 'package:health_care/src/App.dart';
import 'package:health_care/src/forms/AgentCall.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    PushNotificationsManager push = new PushNotificationsManager();
    push.init();
  }
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

      initialRoute: initScreen == 0 || initScreen == null ? "first" : "/",

      routes: {
        'first': (context) => OnBoard(),
        '/': (context) => LoginPage(),
        '/home': (context) => App(),
        '/newpat': (context) => AgentCall(),
      },
    );
  }
}
