import 'package:flutter/material.dart';
import 'package:health_care/core/models/covid_model.dart';
import 'package:health_care/src/covid/district_view.dart';

class AnimatedListItem extends StatefulWidget {
  final CovidDists model;
  final int index;

  AnimatedListItem(this.model, this.index);

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> {
  bool _lock = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration d) {
      setState(() {
        _lock = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 100),
      opacity: _lock ? 1 : 0,
      curve: Curves.easeOutQuint,
      child: AnimatedPadding(
        duration: Duration(milliseconds: 1000),
        curve: Curves.ease,
        padding: _lock
            ? EdgeInsets.zero
            : EdgeInsets.only(top: MediaQuery.of(context).size.height),
        child: getDistOD(widget.model, widget.index),
      ),
    );
  }
}
