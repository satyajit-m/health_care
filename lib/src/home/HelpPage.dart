import 'package:flutter/material.dart';


class HelpPage extends StatefulWidget {
  HelpPage({Key key}) : super(key: key);

  final String title = "Carousel Demo";

  @override
  HelpPageState createState() => HelpPageState();
}

class HelpPageState extends State<HelpPage> {
  //var _scaffoldKey = GlobalKey<ScaffoldState>();
  String s = "Block";
  var block = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Fetch Data Example'),
          ),
          body: Center(
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  if (block == 1) {
                    //Run ur Block Api here
                    s = "UnBlock";
                    block = 0;
                  } else {
                    //Run ur Unblock Api
                    s = "Block";
                    block = 1;
                  }
                });
              },
              child: Text(s),
            ),
          )),
    );
  }
}
