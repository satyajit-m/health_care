import 'package:flutter/material.dart';
import 'package:health_care/src/forms/AgentCall.dart';
import 'package:moceansdk/moceansdk.dart';

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

  TextEditingController phone = new TextEditingController();
  TextEditingController phonetp = new TextEditingController();

  var mocean = Mocean(Basic('56168b9d', '0057c9fe'));

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: phone,
              keyboardType: TextInputType.number,
              maxLength: 12,
            ),
            RaisedButton(
              onPressed: () {
                mocean.sendCode.send({
                  "mocean-to": "917540915155",
                  "mocean-brand": "BRAND_NAME"
                });
              },
              child: Text('Submit'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AgentCall()));
              },
              child: Text('Form'),
            ),
            TextField(
              controller: phonetp,
              keyboardType: TextInputType.number,
              maxLength: 10,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text('Submit OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
