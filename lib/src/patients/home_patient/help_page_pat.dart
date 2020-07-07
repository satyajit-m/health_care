import 'package:flutter/material.dart';

class HelpPagePat extends StatefulWidget {
    HelpPagePat({Key key}) : super(key: key);

  @override
  _HelpPagePatState createState() => _HelpPagePatState();
}

class _HelpPagePatState extends State<HelpPagePat> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('Help Page'),
      ),
    );
  }
}