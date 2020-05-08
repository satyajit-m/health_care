import 'package:flutter/material.dart';
import 'package:health_care/src/forms/AgentForm.dart';
import 'package:health_care/src/forms/blocs/provider.dart';

class AgentCall extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Hello',
        home: AgentForm(),
      ),
    );
  }
}
