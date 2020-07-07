import 'package:flutter/material.dart';
import 'package:health_care/src/agents/new_patient/newpat_form.dart';
import 'package:health_care/src/forms/blocs/provider.dart';

class NewPatCall extends StatelessWidget {
  NewPatCall({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: NewPatForm(),
    );
  }
}
