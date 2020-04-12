import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  HelpPage({Key key}) : super(key: key);

  final String title = "Carousel Demo";

  @override
  HelpPageState createState() => HelpPageState();
}

class HelpPageState extends State<HelpPage> {
  //var _scaffoldKey = GlobalKey<ScaffoldState>();

  void dispose() {
    super.dispose();
  }

  HelpPageState() {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text('Help'),
      ),
    );
  }
}
