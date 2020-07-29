import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:health_care/core/models/covid_model.dart';

Future getCases() async {
  

  var cdata = await http.get("https://api.covid19india.org/v4/data.json");
  var jsonData = json.decode(cdata.body);
  CovidModel covid = CovidModel.fromMap(jsonData['OR']);

  covid.total.active = covid.total.confirmed - covid.total.recovered-covid.total.deceased;
  covid.today.active=covid.today.confirmed-covid.today.deceased-covid.today.recovered;
  

  return covid;
}
