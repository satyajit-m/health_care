import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:health_care/const/route_constants.dart';
import 'package:health_care/push_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './services/router.dart' as router;
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
    return ConnectivityAppWrapper(
          app: MaterialApp(
        theme: ThemeData(
          accentColor: Color(0xFF52DA75),
          primaryColor: Color(0xFF32C96C),
          iconTheme: IconThemeData(color: Color(0xFF32C96C)),
        ),
        //onGenerateRoute: Navigation.router.generator,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.Router.generateRoute,

        initialRoute: initScreen == 0 || initScreen == null ? OnBoardRoute : LoginRoute,

      ),
    );
  }
}
