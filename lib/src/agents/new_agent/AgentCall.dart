import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care/src/forms/blocs/provider.dart';

import 'AgentForm.dart';

class AgentCall extends StatelessWidget {
  AgentCall({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: AgentForm(),
    );
  }
}
