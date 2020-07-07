import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/core/models/covid_model.dart';

Future getCases() async {
  final cases = List<CovidModel>();

  var cdata = await http.get("https://api.covid19india.org/v3/data.json");
  var jsonData = json.decode(cdata.body);
  var list = jsonData['OR']['districts'];

  list.forEach((k, v) {
    if (k == "Others" || k == "Unknown") {
    } else {
      CovidModel covidModel = new CovidModel.fromMap(k, v);
      covidModel.active = covidModel.total - covidModel.recov - covidModel.decs;
      covidModel.dactive = covidModel.dconf-covidModel.drecov;
      cases.add(covidModel);
    }
  });

  return cases;
}
